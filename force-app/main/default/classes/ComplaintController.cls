public with sharing class ComplaintController {
    @AuraEnabled(cacheable=true)
    public static List<Case> getComplaintsOrderedByPriority() {
        return [
            SELECT Id, CaseNumber, Subject, Description, Priority, Status, 
                   Account.Name, CreatedDate, Type, Origin
            FROM Case
            ORDER BY Priority DESC, CreatedDate DESC
            LIMIT 100
        ];
    }

    @AuraEnabled(cacheable=true)
    public static ComplaintMetrics getComplaintMetrics() {
        Integer totalCases = [SELECT COUNT() FROM Case];
        Integer highPriority = [SELECT COUNT() FROM Case WHERE Priority = 'High'];
        Integer mediumPriority = [SELECT COUNT() FROM Case WHERE Priority = 'Medium'];
        Integer lowPriority = [SELECT COUNT() FROM Case WHERE Priority = 'Low'];
        Integer openCases = [SELECT COUNT() FROM Case WHERE Status = 'Open' OR Status = 'New' OR Status = 'In Progress'];
        Integer closedCases = [SELECT COUNT() FROM Case WHERE Status = 'Closed' OR Status = 'Resolved'];

        return new ComplaintMetrics(
            totalCases,
            highPriority,
            mediumPriority,
            lowPriority,
            openCases,
            closedCases
        );
    }

    @AuraEnabled(cacheable=true)
    public static List<CategoryCount> getCategoryDistribution() {
        List<CategoryCount> categoryData = new List<CategoryCount>();
        
        AggregateResult[] groupedResults = [
            SELECT Type, COUNT(Id) AS cnt
            FROM Case
            GROUP BY Type
            ORDER BY COUNT(Id) DESC
        ];

        for (AggregateResult ar : groupedResults) {
            String category = (String) ar.get('Type');
            Integer count = (Integer) ar.get('cnt');
            categoryData.add(new CategoryCount(category, count));
        }

        return categoryData;
    }

    @AuraEnabled
    public static void createComplaint(String accountName, String email, String category, 
                                       String description, String priority, String severity) {
        if (String.isBlank(accountName) || String.isBlank(description) || String.isBlank(category)) {
            throw new AuraHandledException('All required fields must be provided.');
        }

        try {
            Account acc;
            List<Account> existingAccounts = [
                SELECT Id FROM Account WHERE Name = :accountName LIMIT 1
            ];

            if (existingAccounts.isEmpty()) {
                acc = new Account(
                    Name = accountName,
                    Phone = email
                );
                insert acc;
            } else {
                acc = existingAccounts[0];
            }

            String calculatedPriority = ComplaintPriorityService.calculatePriority(
                category, 
                'Standard', 
                description
            );

            Case complaint = new Case(
                AccountId = acc.Id,
                Subject = category + ': ' + description.left(50),
                Description = description,
                Type = category,
                Priority = calculatedPriority,
                Status = 'New',
                Origin = 'Web Form',
                SeverityLevel__c = severity
            );

            insert complaint;
        } catch (Exception e) {
            throw new AuraHandledException('Error creating complaint: ' + e.getMessage());
        }
    }

    public class ComplaintMetrics {
        @AuraEnabled
        public Integer totalCases { get; set; }
        @AuraEnabled
        public Integer highPriority { get; set; }
        @AuraEnabled
        public Integer mediumPriority { get; set; }
        @AuraEnabled
        public Integer lowPriority { get; set; }
        @AuraEnabled
        public Integer openCases { get; set; }
        @AuraEnabled
        public Integer closedCases { get; set; }

        public ComplaintMetrics(Integer total, Integer high, Integer medium, 
                               Integer low, Integer open, Integer closed) {
            this.totalCases = total;
            this.highPriority = high;
            this.mediumPriority = medium;
            this.lowPriority = low;
            this.openCases = open;
            this.closedCases = closed;
        }
    }

    public class CategoryCount {
        @AuraEnabled
        public String category { get; set; }
        @AuraEnabled
        public Integer count { get; set; }

        public CategoryCount(String category, Integer count) {
            this.category = category;
            this.count = count;
        }
    }
}

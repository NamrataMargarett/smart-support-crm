public with sharing class CaseAssignmentService {
    public static void assignCaseQueue(Set<Id> caseIds) {
        if (caseIds == null || caseIds.isEmpty()) {
            return;
        }

        List<Case> casesToUpdate = [
            SELECT Id, Category__c, OwnerId
            FROM Case
            WHERE Id IN :caseIds
        ];

        Map<String, Id> queueMap = getQueueMap();

        for (Case c : casesToUpdate) {
            String targetQueue = resolveQueueName(c.Category__c);
            if (queueMap.containsKey(targetQueue)) {
                c.OwnerId = queueMap.get(targetQueue);
            }
        }

        if (!casesToUpdate.isEmpty()) {
            update casesToUpdate;
        }
    }

    public static String resolveQueueName(String category) {
        if (String.isBlank(category)) {
            return 'General Support';
        }

        switch on category {
            when 'Hardware', 'Software' {
                return 'Technical Support';
            }
            when 'Billing', 'Refund' {
                return 'Finance Support';
            }
            when 'Account' {
                return 'Account Support';
            }
            when 'Shipping' {
                return 'Logistics Support';
            }
            when else {
                return 'General Support';
            }
        }
    }

    private static Map<String, Id> getQueueMap() {
        Map<String, Id> queueMap = new Map<String, Id>();

        for (Group g : [
            SELECT Id, DeveloperName
            FROM Group
            WHERE Type = 'Queue'
            AND DeveloperName IN ('Technical_Support', 'Finance_Support', 'Account_Support', 'Logistics_Support', 'General_Support')
        ]) {
            queueMap.put(g.DeveloperName, g.Id);
        }

        return queueMap;
    }
}

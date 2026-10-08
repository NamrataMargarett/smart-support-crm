public with sharing class ComplaintPriorityService {
    public static String calculatePriority(String category, String customerType, String description) {
        String normalizedCategory = category == null ? '' : category.trim().toLowerCase();
        String normalizedCustomerType = customerType == null ? 'Standard' : customerType.trim();
        String normalizedDescription = description == null ? '' : description.trim().toLowerCase();

        Integer score = 0;

        Map<String, Integer> categoryWeight = new Map<String, Integer>{
            'billing' => 2,
            'shipping' => 1,
            'hardware' => 1,
            'software' => 1,
            'account' => 1
        };

        if (categoryWeight.containsKey(normalizedCategory)) {
            score += categoryWeight.get(normalizedCategory);
        }

        if (normalizedCustomerType.equalsIgnoreCase('Premium') || normalizedCustomerType.equalsIgnoreCase('Enterprise')) {
            score += 1;
        }

        List<String> urgentWords = new List<String>{
            'urgent', 'critical', 'security', 'outage', 'failed payment', 'refund',
            'cannot access', 'not working', 'down', 'breach', 'fraud'
        };

        for (String word : urgentWords) {
            if (normalizedDescription.contains(word)) {
                score += 3;
                break;
            }
        }

        if (normalizedDescription.contains('error') || normalizedDescription.contains('issue') ||
            normalizedDescription.contains('failed') || normalizedDescription.contains('delay') ||
            normalizedDescription.contains('blocked')) {
            score += 1;
        }

        if (score >= 5) {
            return 'High';
        }
        if (score >= 3) {
            return 'Medium';
        }
        return 'Low';
    }

    public static Map<String, Integer> getPrioritySummary(List<Case> cases) {
        Map<String, Integer> summary = new Map<String, Integer>{
            'High' => 0,
            'Medium' => 0,
            'Low' => 0,
            'Total' => 0
        };

        for (Case c : cases) {
            String priority = c.Priority == null ? 'Medium' : c.Priority;
            summary.put('Total', summary.get('Total') + 1);
            if (summary.containsKey(priority)) {
                summary.put(priority, summary.get(priority) + 1);
            }
        }
        return summary;
    }
}

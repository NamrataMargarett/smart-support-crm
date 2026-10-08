public with sharing class CaseAssignmentService {
    public static String assignCaseToQueue(String category, String accountSegment) {
        if (String.isBlank(category)) {
            return 'General Support';
        }

        String normalizedCategory = category.trim();

        if (normalizedCategory == 'Hardware' || normalizedCategory == 'Software') {
            return 'Technical Support';
        }
        if (normalizedCategory == 'Billing' || normalizedCategory == 'Refund') {
            return 'Billing Support';
        }
        if (normalizedCategory == 'Account') {
            return 'Customer Support';
        }
        if (normalizedCategory == 'Shipping') {
            return 'Logistics Support';
        }

        return 'General Support';
    }

    public static String determinePriority(String category, String severity) {
        if (String.isBlank(severity)) {
            severity = 'Medium';
        }

        if (severity == 'Critical' || category == 'Hardware') {
            return 'Critical';
        }

        if (severity == 'High' || category == 'Billing') {
            return 'High';
        }

        if (severity == 'Medium') {
            return 'Medium';
        }

        return 'Low';
    }
}

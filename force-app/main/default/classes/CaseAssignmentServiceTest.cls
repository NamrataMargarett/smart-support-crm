@IsTest
public class CaseAssignmentServiceTest {
    @IsTest
    static void testAssignCaseToQueue() {
        Test.startTest();
        String queueName = CaseAssignmentService.assignCaseToQueue('Hardware', 'Enterprise');
        Test.stopTest();

        System.assertEquals('Technical Support', queueName);
    }

    @IsTest
    static void testDeterminePriority() {
        Test.startTest();
        String priority = CaseAssignmentService.determinePriority('Billing', 'High');
        Test.stopTest();

        System.assertEquals('High', priority);
    }
}

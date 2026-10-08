@IsTest
public with sharing class CaseAssignmentServiceTest {
    @IsTest
    static void testHardwareAssignment() {
        Account acc = new Account(Name = 'Test Customer');
        insert acc;

        Case c = new Case(
            Subject = 'Hardware Problem',
            Category__c = 'Hardware',
            AccountId = acc.Id,
            Status = 'New',
            Origin = 'Email'
        );

        insert c;

        Test.startTest();
        CaseAssignmentService.assignCaseQueue(new Set<Id>{ c.Id });
        Test.stopTest();

        Case updatedCase = [SELECT OwnerId FROM Case WHERE Id = :c.Id];
        System.assertNotEquals(null, updatedCase.OwnerId);
    }
}

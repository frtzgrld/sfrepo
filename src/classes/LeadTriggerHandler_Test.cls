@isTest
private class LeadTriggerHandler_Test {
    private static Integer intFlag = 1;

    @TestSetup static void dataSetup(){
        LeadTriggerHandler_Test.intFlag = 10;
    }

    @isTest static void testNewLead() {

        Lead leadRec = LeadTestDataFactory_Test.createSingleLead('', ',Inc.');
        Lead anotherLead = new LeadTestDataBuilder_Test().withFirstName('')
                                                            .withLastName()
                                                            .build();
        List<Lead> multipleLead = new LeadTestDataBuilder_Test().withFirstName('')
                                                            .withLastName()
                                                            .buildMultiple(10);
        Test.startTest();
        insert leadRec;
        Test.stopTest();

        List<Lead> leadRecs = [SELECT Id, LastName
                                FROM Lead
                                WHERE (Id = :leadRec.Id)];

        for (Lead lr: leadRecs) {
            System.assertEquals('Doe (NEW)', lr.LastName);
        }
    }
}
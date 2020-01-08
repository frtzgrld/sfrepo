@isTest
private class LeadTriggerHandler_Test {

    @isTest static void testNewLead(){
        //SETUP
     /*   Lead leadRec = new Lead(LastName = 'Test Last name',
                                Company = 'Acme, Inc.',
                                Status = 'Open - Not Contacted');*/

        Lead leadRec = LeadTestDataFactory_Test.createNewSingleLead('', ', Inc.');
        //build one
        Lead anotherLead = new LeadTestDataBuilder_Test().withFirstName('').withLastName().withCompany('').build();
        //build many
        List<Lead> leadList = new LeadTestDataBuilder_Test().withFirstName('').withLastName() .withCompany('').buildMultiple(10);

        
        //TESTING
        Test.startTest();
        insert leadRec;
        Test.stopTest();

        //VERIFICATION
        List<Lead> leadRecs = [SELECT Id, LastName
                               FROM Lead
                               WHERE (Id = :leadRec.Id)];

        for(Lead lr: leadRecs){
            System.assertEquals('Doe (NEW)', lr.LastName, 'Last Name is not matched!');
        }                       
    }

}
@isTest
public class ContactTriggerHandler_Test {
    @istest static void checkPrimaryContactTest() {
        List<Contact> conRec = new List<Contact>();
        Account actRecInsert = new Account(Name='Apple Inc',
                                           BillingStreet='Street',
                                           BillingCity='City',
                                           BillingPostalCode='PostalCode',
                                           BillingState='State',
                                           BillingCountry='USA',
                                           Phone='+123',
                                           Fax='+123');
        
        Test.startTest();
        try {
        insert actRecInsert;

            Account actRec = [SELECT Id, Name
                                FROM Account
                                WHERE (Name = 'Apple Inc')];
            conRec.add(new Contact(LastName = 'Moran',
                                   AccountId = actRec.Id,
                                   Primary__c = true));
            
            conRec.add(new Contact(LastName = 'Dela Cruz',
                                   AccountId = actRec.Id, 
                                   Primary__c = true));
            insert conRec;
            update conRec;
        } catch(Exception e) {
            Boolean isError = false;
            if(e.getMessage().contains('Invalid Contact. An Account may only have 1 Primary Contact')) {
                isError = true;
            }
            System.assertEquals(isError, true);
        }
        
        Test.stopTest();
    }
}
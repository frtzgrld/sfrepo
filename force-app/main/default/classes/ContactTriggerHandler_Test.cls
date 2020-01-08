@isTest

private class ContactTriggerHandler_Test {
    //TEST SETUP
    @TestSetup static void makeData(){
         Account singleAccount = new AccountTestDataBuilder_Test().withAccountName('')
                                                                 .withBillingAddressUS('usa')
                                                                 .emptyShipping()
                                                                 .withPhoneUS()
                                                                 .withFaxUS()
                                                                 .buildMe();
        insert singleAccount;

        Contact singleContact = new ContactTestDataBuilder_Test().withFirstName().withLastName().withAccountName(singleAccount.Id).withMailing().build();
        insert singleContact;
    }
    //INSERT A NEW CONTACT CLEAN VERSION
    @isTest static void newCleanContact(){

        Account getOneAccount = [SELECT Id, Name
                                FROM Account
                                ORDER BY createdDate DESC LIMIT 1];

        Contact getOneContact = [SELECT Id, Name, AccountId
                                FROM Contact
                                ORDER BY createdDate DESC LIMIT 1];

        Test.startTest();
            List<Contact> listContact = [SELECT Id, AccountId
                                        FROM Contact
                                        WHERE (Id = :getOneContact.Id)];
        Test.stopTest();                             
        for(Contact contactLoop: listContact){
            System.assertEquals(getOneAccount.Id, contactLoop.AccountId, 'Account Name is not the same');
        }
    }
    //Create new multiple contact 

    @isTest static void multipleContacts(){
        Account getOneAccount = [SELECT Id, Name
                                FROM Account
                                ORDER BY createdDate DESC LIMIT 1];

        List<Contact> getMultipleContact = new ContactTestDataBuilder_Test().withFirstName()
                                                                            .withLastName()
                                                                            .withAccountName(getOneAccount.Id)
                                                                            .withMailing()
                                                                            .multipleContact(5);

        Test.startTest();
        try{
            insert getMultipleContact;
        } catch (DmlException e){
            List<Contact> contactQuery = [SELECT Id, Name, FirstName, LastName
                                        FROM Contact
                                        WHERE (Id = :getMultipleContact)];
            System.debug(contactQuery);
            Test.stopTest();

            Integer noOfLoops = 0;
            for(Contact contactLoop : contactQuery){
                System.assertEquals('Doe'+noOfLoops, contactLoop.LastName, e.getMessage());
                noOfLoops++;
            }
        }



    }

    //CHECK FOR DUPLICATE IN PRIMARY CONTACT
    @isTest static void checkDoublePrimary (){
        Account singleAccount = [SELECT Id, Name
                                FROM Account
                                ORDER BY createdDate DESC LIMIT 1];

        Account accNameEqual = [SELECT Id, Name
                                FROM Account
                                WHERE (Name = :singleAccount.Name)];

        List<Contact> conList = new List<Contact>();
        
        conList.add(new Contact(AccountId = accNameEqual.Id, LastName = 'Doe', Primary__c = true));
        conList.add(new Contact(AccountId = accNameEqual.Id, LastName = 'Doe Second', Primary__c = true));        

        insert conList;

            Test.startTest();
            try{
                update conList;
            } catch (DmlException dmle) {
                Boolean error = false;
                if(dmle.getMessage().contains('Invalid Contact. An Account may only have 1 Primary Contact.')){
                    error = true;
                }
                System.assertEquals(error, true);
        }
            Test.stopTest();  
    }

}
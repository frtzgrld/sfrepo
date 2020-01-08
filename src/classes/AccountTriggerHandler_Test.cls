@isTest

private class AccountTriggerHandler_Test {

    //TEST SETUP
    @TestSetup static void makeData(){
        Account singleAccount = new AccountTestDataBuilder_Test().withAccountName('')
                                                                 .withBillingAddressUS('US')
                                                                 .emptyShipping()
                                                                 .withPhoneUS()
                                                                 .withFaxUS()
                                                                 .buildMe();
        insert singleAccount;

        List<Contact> singleContact = new ContactTestDataBuilder_Test().withAccountName(singleAccount.Id)
                                                                 .withMailing()
                                                                 .multipleContact(10);
        insert singleContact;
    }
    //a successful insert account single
    @isTest static void newCleanAccount(){
        Test.startTest();

        Account sampleAccount = [SELECT Id, Name
                                FROM Account
                                ORDER BY createdDate DESC LIMIT 1];                 
        Test.stopTest();
        //query for matching the Id
        List<Account> listAccount = [SELECT Id, Name
                                     FROM Account
                                     WHERE (Id = :sampleAccount.Id)];
        //for each record in the query, compare the AccountName
        for(Account accloop :listAccount){
            System.assertEquals('Samsung', accloop.Name, 'Account name is not matched!');
        }
    }

    //a successful insert account multiple
    @isTest static void newMultipleCleanAccount(){
        List<Account> multiAccount = new AccountTestDataBuilder_Test().withAccountName('')
                                                                 .withBillingAddressUS('US')
                                                                 .emptyShipping()
                                                                 .withPhoneUS()
                                                                 .withFaxUS()
                                                                 .multiAccount(4);
        Test.startTest(); 
        try{
            insert multiAccount;            
        } catch (DmlException e){
        List<Account> hitAccount = [SELECT Id, Name
                                        FROM Account
                                        WHERE (Id = :multiAccount)];

            Integer numberOfLoops = 0;                                     
            //for each record in the query, compare the AccountName
            for(Account accloop :hitAccount){
                    System.assertEquals('Samsung'+numberOfLoops, accloop.Name, e.getMessage());
                    numberOfLoops++;
            }            
        }


        //query for matching the Id
 
        
        Test.stopTest();
    }

    //Update Account and setting of Billing Address to Mailing Address
    @isTest static void updateAccount(){
        
        Account getOneAccount = [SELECT Id, Name, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry
                                FROM Account
                                ORDER BY createdDate DESC LIMIT 1];

        List<Account> listOldValues = [SELECT Id, Name, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry
                                        FROM Account
                                        WHERE (Id = :getOneAccount.Id)];

        for(Account newAccountList : listOldValues){
            newAccountList.BillingStreet = 'This is a new address';
            newAccountList.BillingCity = 'This is a new address';
            newAccountList.BillingState = 'This is a new address';
            newAccountList.BillingPostalCode = '1621';
            newAccountList.BillingCountry = 'This is a new address';
        }
        Test.startTest();
        update listOldValues;
        Test.stopTest();    

        List<Contact> listContact = [SELECT Id, AccountId, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry
                                     FROM Contact
                                     WHERE (AccountId = :getOneAccount.Id)];

        String Billing = getOneAccount.BillingStreet + ' ' + getOneAccount.BillingCity + ' ' + getOneAccount.BillingState + ' ' + getOneAccount.BillingPostalCode + ' ' + getOneAccount.BillingCountry;
        for(Contact cont :listContact){
            String Mail = cont.MailingStreet + ' ' + cont.MailingCity + ' ' + cont.MailingState + ' ' + cont.MailingPostalCode + ' ' + cont.MailingCountry;
            //if not the same, make it pass
            System.assertNotEquals(Billing, Mail, 'Mailing is the same as Billing.');
        }
    }

    //unsuccessful insert of account due to error in Fax
    @isTest static void accountNoFax(){
        Account singleAccount = new AccountTestDataBuilder_Test().withAccountName('')
                                                                 .withBillingAddressUS('US')
                                                                 .emptyShipping()
                                                                 .withPhoneUS()
                                                                 .withnoFaxUS()
                                                                 .buildMe();

        Test.startTest();
        try{
            insert singleAccount;
        }
        catch (DmlException except){
            System.assertNotEquals(singleAccount.Fax.substring(0,2), '+1', 'US telephone numbers must start with +1');
        }

        Test.stopTest();
    }

    //unsuccessful insert of account due to error in Phone
    @isTest static void accountNoPhone(){
        Account singleAccount = new AccountTestDataBuilder_Test().withAccountName('')
                                                                 .withBillingAddressUS('US')
                                                                 .emptyShipping()
                                                                 .withnoPhoneUS()
                                                                 .withFaxUS()
                                                                 .buildMe();

        Test.startTest();
        try{
            insert singleAccount;
        }
        catch (System.DmlException except){
            System.assertNotEquals(singleAccount.Phone.substring(0,2), '+1', 'US telephone numbers must start with +1');
        }

        Test.stopTest();
    }


}
@isTest
public class AccountTriggerHandler_Test {

    @isTest static void testAccountBeforeInsert() {
		
		List<Account> acctRecList = new List<Account>();
        List<Account> multipleAcct = new TestSetupDataBuilder_Test()
                                        .withAccountName('Apple')
                                        .withBillingCountry('USA')
                                        .withShippingCountry('USA')
                                        .buildMultipleAccount(10);

        acctRecList.add(new Account(Name='Apple Inc',
                                        BillingStreet='Street',
                                        BillingCity='City',
                                        BillingPostalCode='PostalCode',
                                        BillingState='State',
                                        BillingCountry='USA',
                                        Phone='+123',
                                        Fax='+123'));
                        
        acctRecList.add(new Account(Name='Apple Inc2',
                                        BillingStreet='Street',
                                        BillingCity='City',
                                        BillingPostalCode='PostalCode',
                                        BillingState='State',
                                        BillingCountry='United States',
                                        Phone='+123',
                                        Fax='+123'));
                        
        acctRecList.add(new Account(Name='Apple Inc3',
                                        BillingStreet='Street',
                                        BillingCity='City',
                                        BillingPostalCode='PostalCode',
                                        BillingState='State',
                                        BillingCountry='United States of America',
                                        Phone='+123',
                                        Fax='+123'));
        
        acctRecList.add(new Account(Name='Apple Inc4',
                                        ShippingCountry='United States of America'
                                        ));
        
        Test.startTest();
        try {
        	insert acctRecList;
            insert multipleAcct;
        } catch(Exception e) {
            System.assert(e.getMessage().contains('US telephone numbers must start with +1.'), '000');
        }
        system.debug('insert acctRecList >>> ' + acctRecList);
       	Account actRect = [SELECT Id, Name, Phone, Fax
                           FROM Account
                           WHERE Name = 'Apple Inc'
                           LIMIT 1];
        
        Contact con = new Contact();
        con.AccountId = actRect.Id;
        con.LastName = 'Moran';
        
        insert con;
        update acctRecList;
        System.debug('CON: '+ con);
        
        Test.stopTest();
    }    
    
    @isTest static void negativeScenario() {
        Account actRec = new Account(
            Name='Apple Inc',
            BillingStreet='Street',
            BillingCity='City',
            BillingPostalCode='PostalCode',
            BillingState='State',
            BillingCountry='USA',
            Phone='123',
            Fax='123');
        
        test.startTest();
        try{
            insert actRec;
        }catch(exception e){
            Boolean expectedExceptionThrown =  false;
            if(e.getMessage().contains('US telephone numbers must start with +1.')) {
                expectedExceptionThrown = true;
            }
            System.assertEquals(expectedExceptionThrown, true);
        }
        	
        test.stopTest();
    }
}
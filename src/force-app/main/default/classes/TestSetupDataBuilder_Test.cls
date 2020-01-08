@isTest
public class TestSetupDataBuilder_Test {
    private Account actRec = new Account();

    public TestSetupDataBuilder_Test withAccountName(String name) {
        actRec.Name = name;
        return this;
    }
    public TestSetupDataBuilder_Test withBillingCountry(String country) {
        actRec.BillingCountry = country;
        return this;
    }

    public TestSetupDataBuilder_Test withShippingCountry(String sCountry) {
        actRec.ShippingCountry = sCountry;
        return this;
    }

    public List<Account> buildMultipleAccount(Integer noOfAccount) {
        List<Account> act = new List<Account>();

        for(Integer i = 0; i < noOfAccount; i++) {
            act.add(new Account(
                            Name = actRec.Name + i,
                            BillingCountry = actRec.BillingCountry,
                            ShippingCountry = actRec.ShippingCountry,
                            BillingStreet='Street',
                            BillingCity='City',
                            BillingPostalCode='PostalCode',
                            BillingState='State',
                            Phone='+123',
                            Fax='+123'
                ));
        }
        System.debug('DEBUG: '+ act);
        return act;
    }
}
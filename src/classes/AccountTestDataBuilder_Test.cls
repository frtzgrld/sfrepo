@isTest

public class AccountTestDataBuilder_Test {

   private Account accRec = new Account();

    //Account name
    public AccountTestDataBuilder_Test withAccountName(String suffix){
        accRec.Name = 'Samsung' + suffix;
        return this;
    }
    //Shipping Details is empty
    public AccountTestDataBuilder_Test emptyShipping(){
        accRec.ShippingStreet = '';
        accRec.ShippingCity = '';
        accRec.ShippingPostalCode = '';
        accRec.ShippingState = '';
        accRec.ShippingCountry = '';
        return this;
    }
    //SET Billing Address to US
    public AccountTestDataBuilder_Test withBillingAddressUS(String country){
        accRec.BillingStreet = 'Test Street';
        accRec.BillingState = 'Oregon';
        accRec.BillingCity = 'Compton';
        accRec.BillingPostalCode = '1234';
        accRec.BillingCountry = country;
        return this;
    }
    //Phone US
    public AccountTestDataBuilder_Test withPhoneUS(){
        accRec.Phone = '+13423423';
        return this;
    }   
    //Fax US
    public AccountTestDataBuilder_Test withFaxUS(){
        accRec.Fax = '+13423423';
        return this;
    }  
    //SET Billing Address to PH
    public AccountTestDataBuilder_Test withBillingAddressPH(){
        accRec.BillingStreet = '2 Alley 12 P. Rosales Street';
        accRec.BillingState = 'Santa Ana';
        accRec.BillingCity = 'Pateros';
        accRec.BillingPostalCode = '1621';
        accRec.BillingCountry = 'PH';
        return this;
    }
    //Phone not US
    public AccountTestDataBuilder_Test withnoPhoneUS(){
        accRec.Phone = '3423423';
        return this;
    }   
    //Fax not US
    public AccountTestDataBuilder_Test withnoFaxUS(){
        accRec.Fax = '3423423';
        return this;
    }         
    //compiler
    public Account buildMe(){
        return accRec;
    }
    //multiple accounts
    public List<Account> multiAccount(Integer nums){
        List<Account> accHold = new List<Account>();

        for(Integer i = 0; i < nums; i++){
            accHold.add(new Account(Name = accRec.Name + i,
                                    BillingStreet = accRec.BillingStreet,
                                    BillingState = accRec.BillingState,
                                    BillingCity = accRec.BillingCity,
                                    BillingPostalCode = accRec.BillingPostalCode,
                                    BillingCountry = accRec.BillingCountry,
                                    Phone = accRec.Phone,
                                    Fax = accRec.Fax));
        }

        return accHold;
    }
}
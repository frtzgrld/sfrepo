public class AccountTriggerAHandler {
    public static void doBeforeInsert(List<Account> newAccts){
        for(Account accCountry: newAccts){
              if(accCountry.BillingStreet != ' ' || accCountry.BillingCity!= ' ' ||  accCountry.BillingState!= ' ' || accCountry.BillingPostalCode!= ' ' || accCountry.BillingCountry!= ' '){
                  String billingstreet = accCountry.BillingStreet;
                  String billingcity = accCountry.BillingCity;
                  String billingstate = accCountry.BillingState;
                  String billingpostal = accCountry.BillingPostalCode;
                  String billingcountry = accCountry.BillingCountry;
                  //set new vars
                  accCountry.ShippingStreet = billingstreet;
                  accCountry.ShippingCity = billingcity;
                  accCountry.ShippingState = billingstate;
                  accCountry.ShippingPostalCode= billingpostal;
                  //country validation
                  if(billingcountry == 'USA' || accCountry.ShippingCountry == 'USA'){
                      accCountry.BillingCountry = 'US';
                      accCountry.ShippingCountry = 'US';
                  }
                  else if(accCountry.BillingCountry == 'United States' || accCountry.ShippingCountry == 'United States'){
                      accCountry.BillingCountry = 'US';
                      accCountry.ShippingCountry = 'US';
                  }    
                  else if(accCountry.BillingCountry == 'United States of America' || accCountry.ShippingCountry == 'United States of America'){
                      accCountry.BillingCountry = 'US';
                      accCountry.ShippingCountry = 'US';
                  } else{
                      accCountry.ShippingCountry = billingcountry;              
                  }    
              }  
        }
    }
    
}
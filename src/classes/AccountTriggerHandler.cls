public class AccountTriggerHandler {
   //boolean check on what to run. FALSE = Do the before update of the Account then set to true.
   public static boolean checkThisBefore = FALSE;
   public static void doBeforeInsert(List<Account> newAccts){
        for(Account accCountry: newAccts){
            //Empty String check: Shipping Address
              if(String.isEmpty(accCountry.ShippingStreet) && String.isEmpty(accCountry.ShippingCity) &&  String.isEmpty(accCountry.ShippingState) && String.isEmpty(accCountry.ShippingPostalCode) && String.isEmpty(accCountry.ShippingCountry))
              {
                  //Yes: set the shipping address to billing address
                  accCountry.ShippingStreet = accCountry.BillingStreet;
                  accCountry.ShippingCity = accCountry.BillingCity;
                  accCountry.ShippingState = accCountry.BillingState;
                  accCountry.ShippingPostalCode= accCountry.BillingPostalCode;
                  accCountry.ShippingCountry = accCountry.BillingCountry;                     
              } 
                  //country validation
                  if(accCountry.BillingCountry.equalsIgnoreCase('USA') || accCountry.BillingCountry.equalsIgnoreCase('United States') || accCountry.BillingCountry.equalsIgnoreCase('United States of America'))
                  {
                         
                      			accCountry.BillingCountry = 'US';
                         
                  } 
                  if(accCountry.ShippingCountry.equalsIgnoreCase('USA') || accCountry.ShippingCountry.equalsIgnoreCase('United States') || accCountry.ShippingCountry.equalsIgnoreCase('United States of America'))
                  {
                                
                      			accCountry.ShippingCountry = 'US';
                  }
                  //PHONE AND FAX
                      if(accCountry.BillingCountry == 'US'){
                          if(String.isNotBlank(accCountry.Phone)){
                              if(accCountry.Phone.substring(0,2) != '+1'){
                                  accCountry.Phone.addError('US telephone numbers must start with +1');
                              }                              
                          }
                          if(String.isNotBlank(accCountry.Fax)){
                              if(accCountry.Fax.substring(0,2) != '+1'){
                                  accCountry.Fax.addError('US telephone numbers must start with +1');                      
                              }                                
                          }
                      }
        }
    }   
    
    //update the account trigger
    public static void doBeforeUpdate(Account acItem){
        //System.debug('The boolean is:'+ checkThisBefore);
        System.debug('this goes first');
        
        //puts up the result in a list if any
        List<Account> accList = [SELECT Id, Name,
                                	(SELECT Id, Name, FirstName, LastName FROM Contacts)
                                FROM Account
                                WHERE (Id = :acItem.Id) ];
        
		//System.debug('Acc' +accList);
        
        Map<String, Contact> accMapList = new Map<String, Contact>();
        for(Account accListNewVar : accList){
            //if the child relationship name list has a result
            if(!accListNewVar.Contacts.isEmpty()){
                //set the values to Mailing Address
                for(Contact finalResult :accListNewVar.Contacts){
                    finalResult.MailingStreet = acItem.BillingStreet;
                    finalResult.MailingCity = acItem.BillingCity;
                    finalResult.MailingState = acItem.BillingState;
                    finalResult.MailingPostalCode = acItem.BillingPostalCode;
                    finalResult.MailingCountry = acItem.BillingCountry;
                    accMapList.put(finalResult.Id, finalResult);
                }
            }
        }
        //if the map has a value, update the values of it to the list.
        if(accMapList.size() > 0){
            checkThisBefore = TRUE;
        	update accMapList.values();          
        }
    }
}
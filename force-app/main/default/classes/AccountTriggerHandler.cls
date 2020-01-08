public class AccountTriggerHandler {
    public static Boolean isUpdateTriggered = false;
    
    public static void changeContactMailingAddress(Account actItem) {
        List<Account> actList = [SELECT Id, Name,
                                 (SELECT Id, Name, FirstName, LastName
                                  FROM Contacts)
                                 From Account
                                 WHERE (Id = :actItem.Id)];
        
        System.debug('ACC LIST '+ actList);
        
        Map<String, Contact> conUpdate = new Map<String, Contact>();
        for (Account act: actList) {
            if (!act.Contacts.isEmpty()) {
            for (Contact conItem: act.Contacts) {
                    conItem.MailingStreet = actItem.BillingStreet;
                    conItem.MailingCity = actItem.BillingCity;
                    conItem.MailingPostalCode = actItem.BillingPostalCode;
                    conItem.MailingState = actItem.BillingState;
                    conItem.MailingCountry = actItem.BillingCountry;
                    conUpdate.put(conItem.Id, conItem);
                }
            }
        }
        
        if(conUpdate.size() > 0) {
            isUpdateTriggered = true;
            Database.update(conUpdate.values());
        }
    }
    
    public static void accountBeforeInsert(List<Account> actList) {
        String defNo = '+1';    
        for (Account actItem: actList) {
            /*checks the billing country if it isNotBlank and sets the default value to 'US' if it satisfies the if condition block */
            if (String.isNotBlank(actItem.BillingCountry)) {            
                if (actItem.BillingCountry.equalsIgnoreCase('USA') 
                    || actItem.BillingCountry.equalsIgnoreCase('United States') 
                    || actItem.BillingCountry.equalsIgnoreCase('United States of America')) {
                        
                        actItem.BillingCountry = 'US';
                    }
                
                //checks if the phone is not null and the Billing Country is equals to US, throws validation error
                if (String.isNotBlank(actItem.Phone) && actItem.BillingCountry.equalsIgnoreCase('US')) {
                    if(!actItem.Phone.startsWith(defNo)) {
                        actItem.Phone.addError('US telephone numbers must start with +1.');
                    }
                }
                
                //checks if the fax is not null and the Billing Country is equals to US, throws validation error
                if (String.isNotBlank(actItem.Fax) && actItem.BillingCountry.equalsIgnoreCase('US')) {
                    if(!actItem.Fax.startsWith(defNo)) {
                        actItem.Fax.addError('US telephone numbers must start with +1.');
                    }
                }           
            }           
            
            //checks the value of shipping fee if it is empty
            if (String.isBlank(actItem.ShippingStreet)) { 
                actItem.ShippingStreet = actItem.BillingStreet;   
            }
            
            if (String.isBlank(actItem.ShippingCity)) { 
                actItem.ShippingCity = actItem.BillingCity;   
            }
            
            if (String.isBlank(actItem.ShippingPostalCode)) { 
                actItem.ShippingPostalCode = actItem.BillingPostalCode;   
            }
            
            if (String.isBlank(actItem.ShippingState)) { 
                actItem.ShippingState = actItem.BillingState;   
            }
            
            if (String.isBlank(actItem.ShippingCountry)) { 
                actItem.ShippingCountry= actItem.BillingCountry;   
            }
            //end
            
            if(String.isNotBlank(actItem.ShippingCountry)) {           
                if (actItem.ShippingCountry.equalsIgnoreCase('USA')
                    || actItem.ShippingCountry.equalsIgnoreCase('United States') 
                    || actItem.ShippingCountry.equalsIgnoreCase('United States of America')) {
                        
                        actItem.ShippingCountry = 'US';
                    }
            }
        }
        
    } 
    
}
trigger AccountBeforeInsert on Account (before insert) {
    
    for(Account actItem: Trigger.new) {
        if (String.isNotBlank(actItem.BillingCountry)) {            
            if (actItem.BillingCountry == 'USA' 
                || actItem.BillingCountry == 'United States' 
                || actItem.BillingCountry == 'United States of America') {
      
                actItem.BillingCountry = 'US';
            }
        }
        
        //retains the value of shipping fields if it is not empty
        if (String.isNotBlank(actItem.ShippingStreet)) {
              actItem.ShippingStreet= actItem.ShippingStreet;
        }
        
        if (String.isNotBlank(actItem.ShippingCity)) {
              actItem.ShippingCity= actItem.ShippingCity;
        }
        
        if (String.isNotBlank(actItem.ShippingPostalCode)) {
              actItem.ShippingPostalCode= actItem.ShippingPostalCode;
        }
        
        if (String.isNotBlank(actItem.ShippingState)) {
              actItem.ShippingState= actItem.ShippingState;
        }
        
        //end
        
        //checks the value of shipping field if it is empty
        if (String.isBlank(actItem.ShippingStreet)) { 
              actItem.ShippingStreet= actItem.BillingStreet;   
        }
        
        if (String.isBlank(actItem.ShippingCity)) { 
              actItem.ShippingCity= actItem.BillingCity;   
        }
        
        if (String.isBlank(actItem.ShippingPostalCode)) { 
              actItem.ShippingPostalCode= actItem.BillingPostalCode;   
        }
        
        if (String.isBlank(actItem.ShippingState)) { 
              actItem.ShippingState= actItem.BillingState;   
        }
        
        if (String.isBlank(actItem.ShippingCountry)) { 
              actItem.ShippingState= actItem.BillingCountry;   
        }
        //end
        
        if(String.isNotBlank(actItem.ShippingCountry)) {           
            if (actItem.ShippingCountry == 'USA' 
                || actItem.ShippingCountry == 'United States' 
                || actItem.ShippingCountry == 'United States of America') {
            
                actItem.ShippingCountry = 'US';
            }
        }
    }
}
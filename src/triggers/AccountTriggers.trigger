trigger AccountTriggers on Account (before insert, after update) {
    
    if(Trigger.isUpdate){
        //acItem = stores the new values, oldMap = stores the old values
        for(Account acItem: Trigger.new){
            Account oldMap = Trigger.oldMap.get(acItem.Id);
            //if there are changes, fire the update class, if none, do nothing
            if(acItem.BillingCity != oldMap.BillingCity ||acItem.BillingStreet != oldMap.BillingStreet ||acItem.BillingState != oldMap.BillingState ||acItem.BillingPostalCode != oldMap.BillingPostalCode ||acItem.BillingCountry != oldMap.BillingCountry)
            {
				AccountTriggerHandler.doBeforeUpdate(acItem);	                   
            }
        }        
    } else if(Trigger.isInsert){
		AccountTriggerHandler.doBeforeInsert(Trigger.new);        
    }

}
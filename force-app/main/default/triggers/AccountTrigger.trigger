trigger AccountTrigger on Account (before insert, after update) {
    if (Trigger.isInsert && Trigger.isBefore) {
        AccountTriggerHandler.accountBeforeInsert(Trigger.new);
    } else if (Trigger.isUpdate && Trigger.isAfter) {
        
        //AccountTriggerHandler.changeContact(Trigger.new, Trigger.oldMap);          
        
        for (Account actItem: Trigger.new) {
            Account oldAccount = Trigger.oldMap.get(actItem.Id);
            System.debug('OLD VAL IS: '+ oldAccount.BillingStreet);
            System.debug('OLD VAL IS: '+ actItem.BillingStreet);
            
            if (actItem.BillingStreet != oldAccount.BillingStreet
                || actItem.BillingCity != oldAccount.BillingCity
                || actItem.BillingPostalCode != oldAccount.BillingPostalCode
                || actItem.BillingState != oldAccount.BillingState
                || actItem.BillingCountry != oldAccount.BillingCountry) {
                    System.debug('ADDRESS WAS CHANGED');
                    AccountTriggerHandler.changeContactMailingAddress(actItem);               
                }
        }
    }
}
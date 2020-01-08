trigger ContactTrigger on Contact (before insert, before update) {
    
    ContactTriggerHandler.checkPrimaryContact(Trigger.new);
    
}
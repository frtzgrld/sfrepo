trigger ContactTrigger on Contact (before insert, before update) {
    if (Trigger.isInsert){
		ContactTriggerHandler.doBeforeUpdate(Trigger.new);        
    } else if (Trigger.isUpdate){
        ContactTriggerHandler.doBeforeUpdate(Trigger.new);
    }

    
}
trigger LeadTrigger on Lead (before insert) {
    LeadTriggerHandler.doBeforeInsert(Trigger.new);
}
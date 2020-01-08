trigger LeadTrigger on Lead (before insert) {
   /* for(Lead leadRec: Trigger.new){
        leadRec.LastName += ' (NEW)';
    }*/
    
    LeadTriggerHandler.doBeforeInsert(Trigger.new);
}
public class LeadTriggerHandler {
    public static void doBeforeInsert(List<Lead> newLeads) {
        for (Lead leadRec: newLeads) {
            leadRec.LastName += ' (NEW) ';
        }
    }
}
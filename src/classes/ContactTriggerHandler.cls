public class ContactTriggerHandler {
    
    public static void checkPrimaryContact(List<Contact> conRec) {
        if(!AccountTriggerHandler.isUpdateTriggered) {
            List<String> accountList = new List<String>();
            
            for (Contact conItem: conRec) {
                if(conItem.Primary__c) {
                    accountList.add(conItem.AccountId);
                }
            }
            
            List<Contact> finalList = [SELECT Id, Primary__c, AccountId
                                       FROM Contact
                                       WHERE (AccountId IN :accountList AND Primary__c = true)];
            
            Map<Id, Contact> conMap = new Map<Id, Contact>();
            for(Contact con: finalList) {
                conMap.put(con.AccountId, con);
            }
            
            for(Contact conItem: conRec) {
                if(conMap.containsKey(conItem.AccountId)) {
                    if (conItem.Id != conMap.get(conItem.AccountId).Id) {
                        conItem.Primary__c.addError('Invalid Contact. An Account may only have 1 Primary Contact');
                    }
                }
            }
        }
    }
}
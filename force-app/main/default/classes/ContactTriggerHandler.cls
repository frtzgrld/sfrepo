public class ContactTriggerHandler {

	//before insert and update
    public static void doBeforeUpdate(List<Contact> newRecupdate){
        //System.debug('this goes second');
        String ContactID;
        
      if(!AccountTriggerHandler.checkThisBefore){
        //Put inside the list the checkbox value
       	List<Boolean> listOfContactupdate = new List<Boolean>();
        for(Contact accRecupdate: newRecupdate){
            listOfContactupdate.add(accRecupdate.Primary__c);
            //put into variable the contact id
            ContactID = accRecUpdate.Id;
        }
        
        List<Contact> holdThisupdate = [SELECT Id, Email, AccountId,  Primary__c 
                                  		FROM Contact 
                                  		WHERE (AccountId != NULL AND Primary__c IN :listOfContactupdate)];
        
        Map<String, Contact> mappingupdate = new Map<String, Contact>();
        for(Contact connedupdate: holdThisupdate){
            //if Contact Id is equal to itself, it wont prevent from saving. if not, proceed below
                //check if primary is checked. if yes, put into map
                if(connedupdate.Primary__c == TRUE){
                    mappingupdate.put(connedupdate.AccountId, connedupdate);       
                }                
        }
        //primary contact condition
        for(Contact consupdate: newRecupdate){
            //if contains matches, provide an error         
            if(mappingupdate.containsKey(consupdate.AccountId)){
                consupdate.addError('Invalid Contact. An Account may only have 1 Primary Contact.');
            }
        } 
      }
    }
}
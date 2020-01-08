@isTest

public class LeadTestDataFactory_Test {
    //create a single Lead Record
    public static Lead createNewSingleLead(String firstNameSuffix, String coSuffix){
        Lead leadRec = new Lead(FirstName = 'John' + firstNameSuffix,
                                LastName = 'Doe',
                                Company = 'Acme' + coSuffix,
                                Email = 'john' + firstNameSuffix + '.doe@phonyAcme.co.us');

        return leadRec;
    }
    //create 10 Lead Records
    public static List<Lead> createNewMultipleLeads(){
        List<Lead> leadList = new list<Lead>();
        for(Integer i=0; i < 10; i++){
            leadList.add(createNewSingleLead(String.valueOf(i), ' Co.' + i));

        }

        return leadList;
    }

}
@isTest

public class LeadTestDataFactory_Test {

    public static Lead createSingleLead(String firstNameSuffix, String coSuffix) {
        
        Lead leadRec = new Lead(FirstName='John'+ firstNameSuffix,
                                LastName='Doe',
                                Company='Acme'+ coSuffix,
                                Email='john'+ firstNameSuffix +'.doe@phonyAcme.co.us');

        return leadRec;
    }    

    public static List<Lead> createNewMultipleLead() {
        List<Lead> leadList = new List<Lead>();

        for(Integer i = 0; i < 10; i++) {
            leadList.add(createSingleLead(String.valueOf(i),'Co'+ i));    
        }

        return leadList;
    }
 }
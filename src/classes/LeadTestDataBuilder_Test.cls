@isTest
public class LeadTestDataBuilder_Test {

    private Lead leadRec = new Lead();
    //Display FirstName
    public LeadTestDataBuilder_Test withFirstName(String fnSuffix){

        leadRec.FirstName = 'John' + fnSuffix;
        return this;
    }
    //Display LastName
    public LeadTestDataBuilder_Test withLastName(){
        leadRec.LastName = 'Doe';
        return this;
    }

    //Display Company
    public LeadTestDataBuilder_Test withCompany(String coSuffix){
        leadRec.Company = 'Acme' + coSuffix;
        return this;
    }
    //combine
    public Lead build(){
        return leadRec;
    }
    //create multiple Lead Record
    public List<Lead> buildMultiple(Integer noOfLeads){

         List<Lead> leadList = new List<Lead>();
         
        for(integer i = 0; i < noOfLeads; i++){
           
                leadList.add(new Lead(FirstName = leadRec.FirstName + i,
                                        LastName = leadRec.LastName,
                                        Company = leadRec.Company + i));
        }

        return leadList;
    }
}
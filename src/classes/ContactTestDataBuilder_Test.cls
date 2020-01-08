@isTest

public class ContactTestDataBuilder_Test {

    private Contact conRec = new Contact();
    //HAVE SOME FIRST NAME
    public ContactTestDataBuilder_Test withFirstName(){
        conRec.FirstName = 'John';
        return this;
    }
    //I HAVE THE LAST NAME
    public ContactTestDataBuilder_Test withLastName(){
        conRec.LastName = 'Doe';
        return this;
    }
    //I HAVE THE ACCOUNT NAME
    public ContactTestDataBuilder_Test withAccountName(Id accID){
        conRec.AccountId = accID;
        return this;
    }
    //I HAVE MAILING ADDRESS
    public ContactTestDataBuilder_Test withMailing(){
            conRec.MailingStreet = 'Alley 14 PRosales Street';
            conRec.MailingCity = 'Makati City';
            conRec.MailingPostalCode = '1621';
            conRec.MailingState = 'Santa Anas';
            conRec.MailingCountry = 'PH';
            return this;       
    }
    //BUILD ONE
    public Contact build(){
        return conRec;
    }
    //multiple contact no primary
    public List<Contact> multipleContact(Integer num){
        List<Contact> contactList = new List<Contact>();

        for(Integer i = 0; i < num; i++){
            contactList.add(new Contact(FirstName = conRec.Firstname + i,
                                        LastName = conRec.LastName + i,
                                        AccountId = conRec.AccountId,
                                        MailingStreet = conRec.MailingStreet,
                                        MailingCity = conRec.MailingCity,
                                        MailingPostalCode = conRec.MailingPostalCode,
                                        MailingState = conRec.MailingState,
                                        MailingCountry = conRec.MailingCountry));
        }

        return contactList;
    }    
    //multiple contact all primary
    public List<Contact> multipleContactWPrimary(Integer num){
        List<Contact> contactList = new List<Contact>();

        for(Integer i = 0; i < num; i++){
            contactList.add(new Contact(FirstName = conRec.Firstname + i,
                                        LastName = conRec.LastName + i,
                                        AccountId = conRec.AccountId,
                                        Primary__c = true,
                                        MailingStreet = conRec.MailingStreet,
                                        MailingCity = conRec.MailingCity,
                                        MailingPostalCode = conRec.MailingPostalCode,
                                        MailingState = conRec.MailingState,
                                        MailingCountry = conRec.MailingCountry));
        }

        return contactList;
    } 
}
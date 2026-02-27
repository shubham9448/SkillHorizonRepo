public class ContactTriggerHandler {
    public static void createRelateAccount(List<Contact> conList){
        List<Account> accList = new List<Account>();
        for(Contact con:conList){
            accList.add(new Account(Name = con.LastName,Active__c = 'Yes'));
        }
        
        if(!accList.isEmpty()){
            insert accList;
        }
    }
    
    public static void updateAccount(List<Contact> conList,Map<Id,Contact> conOldMap){
        Map<Id,Account> accMap = new Map<Id,Account>();
		List<Account> updateAccount = new List<Account>();
        Set<Id> AccIds = new Set<Id>();
        
        for(Contact con:conList){
        	AccIds.add(con.AccountId);    
        }
        
        accMap.putAll([SELECT Name FROM Account WHERE Id IN:AccIds]);
        
        for(Contact con:conList){
            String OldEmail = conOldMap.get(con.Id) == null ? null : conOldMap.get(con.Id).Email;
            if(con.Email != oldEMail ){
                String accName = accMap.get(con.AccountId).Name;
                if(con.Name == accName){
                updateAccount.add(new Account(Id = con.AccountId,Email__c = con.Email));    
                }    
            }
        }
        
        if(!updateAccount.isEmpty()){
            update updateAccount;
        }
        
    }

    public static void question33(List<Contact> conList){
        List<Messaging.SingleEmailMessage> seList = new List<Messaging.SingleEmailMessage>();

        Id emailTempId = [SELECT Id FROM EmailTemplate WHERE Name='Q33 email template'].Id;
        for(Contact con:conList){
            if(con.Email != null){
                Messaging.SingleEmailMessage sm = new Messaging.SingleEmailMessage();
                sm.setTemplateId(emailTempId);
                sm.setTargetObjectId(con.Id);
                seList.add(sm);
            }
        }

        if(!seList.isEmpty()){
            Messaging.sendEmail(seList);
        }
    }

    public static void question44(List<Contact> conList){
        Set<String> setEmail = new Set<String>();
        List<Contact> conList1 = [SELECT Id,Email FROM Contact];
        for(Contact con:conList1){
            setEmail.add(con.Email);
        }

        for(Contact con:conList){
            if(setEmail.contains(con.Email) && con.Email != null){
                con.AddError('You cant insert this as already a contact is present with same email Id');
            }
        }
    }
}
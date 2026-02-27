public class AccountTriggerHandler {
    public static void createOpportunityBasedOnCondition(List<Account> accList,Map<Id,Account> accOldMap){
        List<Opportunity> oppList = new List<Opportunity>();
        List<Account> updatedAccountList = new List<Account>();
        Map<Id,Decimal> accOppMap = new Map<Id,Decimal>();
        
        for(Account acc:accList){
            Decimal oldValue = accOLdMap == null ? 0 : accOldMap.get(acc.Id).Create_Opportunity_Vanshiv__c;
            if(acc.Create_Opportunity_Vanshiv__c != oldValue && acc.Create_Opportunity_Vanshiv__c >0){
                for(Integer i=1;i<=acc.Create_Opportunity_Vanshiv__c;i++){
                    oppList.add(new Opportunity(Name = acc.Name +i,StageName = 'Prospecting',CloseDate = System.TODAY(),AccountId = acc.Id));		    
                }    
            }            
        }
        if(!oppList.isEmpty()){
            insert oppList;    
        }
               
        for(AggregateResult ar:[SELECT AccountId,COUNT(Id) FROM Opportunity WHERE AccountId IN:accList GROUP BY AccountId]){
        	accOppMap.put((Id)ar.get('AccountId'),(Decimal)ar.get('expr0'));	    
        }       
        for(Account acc:accList){
        	updatedAccountList.add(new Account(Id = acc.Id,Total_Opportunity_Vanshiv__c = accOppMap.get(acc.Id)));    
        }
        
        if(!updatedAccountList.isEmpty()){
            update updatedAccountList;
        }
    }    
    
    public static void deleteRelatedContact(List<Account> accList){    
    	Set<Id> accIds = new Set<Id>();
        for(Account acc:accList){
            accIds.add(acc.Id);
        }
        
        List<Contact> conList = [SELECT Id,AccountId FROM Contact WHERE AccountId IN: accIds];
        
        if(!conList.isEmpty()){
            delete conList;
        }
    }
    
    
    public static void question1(List<Account> accList){
        for(Account acc:accList){
            if(acc.Industry == 'Media'){
                acc.Rating = 'Hot';
            }
        }
    }

    public static void question3(List<Account> accList){
        for(Account acc:accList){
            if(acc.Apex_copy_billing_to_shipping__c){
                acc.ShippingCountryCode = acc.BillingCountryCode;
                acc.ShippingCity= acc.BillingCity;
                acc.ShippingCountry=acc.BillingCountry;
                acc.ShippingState=acc.BillingState;
                acc.ShippingStreet= acc.BillingStreet;
            }
        }
    }

    public static void question5(List<Account> accList){
        List<Contact> conList = new List<Contact>();
        for(Account acc:accList){
            conList.add(new Contact(lastName = acc.Name,Phone=acc.Phone,AccountId = acc.Id));
        }

        if(!conList.isEmpty()){
            insert conList;
        }
    }

    public static void question6(List<Account> accList){
        List<Opportunity> oppList = new List<Opportunity>();
        for(Account acc:accList){
            if(acc.Active__c == 'Yes'){
                oppList.add(new Opportunity(Name = acc.Name,StageName= 'Prospecting',CloseDate = System.TODAY(),AccountId =acc.Id,Amount = 5000));
            }
        }
        if(!oppList.isEmpty()){
            insert oppList;
        }

    }

    public static void question9(List<Account> accList){
        List<Contact> conList = new List<Contact>();
        List<Opportunity> oppList = new List<Opportunity>();
        for(Account acc:accList){
            if(acc.Create_Contact__c){
                conList.add(new Contact(LastName=acc.Name,Phone=acc.Phone,AccountId=acc.Id));    
            }
            if(acc.Create_Opportunity__c){
                oppList.add(new Opportunity(Name= acc.Name,StageName='Prospecting',CloseDate=System.TODAY(),AccountId=acc.Id));    
            }
        }
        if(!conList.isEmpty() || !oppList.isEmpty()){
            insert conList;
            insert oppList;
        }
    }

    public static void question10(List<Account> accList,Map<Id,Account> accMap){
        for(Account acc: accList){
            String oldNumber= accMap.get(acc.Id).Phone;
            if(acc.Phone != oldNumber){
                acc.Description = 'Phone is updated! Old Value: '+oldNumber+'& New Value: '+acc.Phone;
            }
        }
    }
    
    public static void question11(List<Account> accList,Map<Id,Account> oldAccMap){

            for(Account acc:accList){
                if(acc.Apex_copy_billing_to_shipping__c && oldAccMap == null ){
                    acc.ShippingCountryCode = acc.BillingCountryCode;
                    acc.ShippingCity= acc.BillingCity;
                    acc.ShippingCountry=acc.BillingCountry;
                    acc.ShippingState=acc.BillingState;
                    acc.ShippingStreet= acc.BillingStreet;
                }

                if(oldAccMap != null && (acc.Apex_copy_billing_to_shipping__c != oldAccMAp.get(acc.Id).Apex_copy_billing_to_shipping__c) && acc.Apex_copy_billing_to_shipping__c == true){
                    acc.ShippingCountryCode = acc.BillingCountryCode;
                    acc.ShippingCity= acc.BillingCity;
                    acc.ShippingCountry=acc.BillingCountry;
                    acc.ShippingState=acc.BillingState;
                    acc.ShippingStreet= acc.BillingStreet;
                }
            }
        }

    public static void question12(List<Account> accList,Map<Id,Account> accMap){
        if(accMap == null){
            for(Account acc:accList){
                if(acc.Industry != null && acc.Industry == 'Media') {
                    acc.Rating = 'Hot';
                }       
            }
        }else{
            for(Account acc:accList){
                if(acc.Industry != null && acc.Industry == 'Media' && acc.Industry != accMap.get(acc.Id).Industry) {
                    acc.Rating = 'Hot';
                }       
            }
        }       
    }

    public static void question14(List<Account> accList,Map<Id,Account> accOldMap){
        Map<Id,Account> accMap = new Map<Id,Account>();
        List<Contact> conListUpdate = new List<Contact>();
        for(Account acc:accList){
            String oldAccPhone = accOldMap.get(acc.Id).Phone;
            if(acc.Phone != oldAccPhone){
                accMap.put(acc.Id,acc);
            }
        }
        List<Contact> conList = [SELECT Id,Phone,AccountId FROM Contact WHERE AccountId IN: accMap.KeySet()];
        for(Contact con:conList){
            conListUpdate.add(new Contact(Id=con.Id,Phone=accMap.get(con.AccountId).Phone));
        }
        if(!conListUpdate.isEmpty()){
            update conListUpdate;
        }
    }

    public static void question15(List<Account> accList,Map<Id,Account> accMap){
        Set<Id> accIds = new Set<Id>();
        List<Contact> conList = new List<Contact>();
        for(Account acc: accList){
            if(acc.Phone != accMap.get(acc.Id).Phone){
                accIds.add(acc.Id);
            }
        }

        List<Account> accList1 = [SELECT Id,Phone,(SELECT Id,Phone FROM Contacts) FROM Account WHERE Id IN:accIds];

        for(Account acc:accList1){
            for(Contact con:acc.Contacts){
                conList.add(new Contact(Id=con.Id,Phone = acc.Phone));
            }
        }
        if(!conList.isEmpty()){
            update conList;
        }
    }

    public static void question16(List<Account> accList,Map<Id,Account> accMap){
        Map<Id,Account> newaccMap = new Map<Id,Account>();
        List<Contact> newConList = new List<Contact>();
        for(Account acc:accList){
            if(acc.BillingCountry != accMap.get(acc.Id).BillingCountry || acc.BillingCountryCode != accMap.get(acc.Id).BillingCountryCode || acc.BillingCity != accMap.get(acc.Id).BillingCity || acc.BillingState != accMap.get(acc.Id).BillingState){
                newaccMap.put(acc.Id,acc);    
            }
        }
        List<Contact> conList = [SELECT ID,AccountId,MailingCountryCode,MailingCity,MailingCountry,MailingState,MailingStreet FROM Contact WHERE AccountId IN:newaccMap.keySet()];

        for(Contact con:conList){
            newConList.add(new Contact(Id=con.Id,MailingCountryCode = newaccMap.get(con.AccountId).BillingCountryCode,MailingCity= newaccMap.get(con.AccountId).BillingCity,MailingCountry=newaccMap.get(con.AccountId).BillingCountry,MailingState=newaccMap.get(con.AccountId).BillingState));
        }
        if(!newConList.isEmpty()){
            update newConList;
        }

    }

    public static void question19(List<Account> accList,Map<Id,Account> accMap){
        Set<Id> accIds = new Set<Id>();
        for(Account acc:accList){
            if(acc.Active__c != accMap.get(acc.Id).Active__c && acc.Active__c == 'No'){
                accIds.add(acc.Id);
            }
        }
        List<Opportunity> oppList = [SELECT Id,StageName,AccountId FROM Opportunity WHERE AccountId IN: accIds];
        for(Opportunity opp: oppList){
            if(opp.StageName != 'Closed Won'){
                opp.StageName = 'Closed Lost';
            }
        }
        if(!oppList.isEmpty()){
            update oppList;
        }
    }

    public static void question17(List<Account> accList,Map<Id,Account> accMap){
        List<Contact> conList = new List<Contact>();
        Set<Id> accIds = new Set<Id>();
        for(Account acc:accList){
            if(acc.BillingCountry != accMap.get(acc.Id).BillingCountry || acc.BillingCountryCode != accMap.get(acc.Id).BillingCountryCode || acc.BillingCity != accMap.get(acc.Id).BillingCity || acc.BillingState != accMap.get(acc.Id).BillingState){
                accIds.add(acc.Id);
            }
        }
        List<Account> accList1 = [SELECT Id,BillingCountry,BillingCountryCode,BillingCity,BillingState,(SELECT MailingCountry,MailingCountryCode,MailingCity,MailingState FROM Contacts) FROM Account WHERE Id IN:accIds];
        for(Account acc:accList1){
            for(Contact con:acc.Contacts){
                conList.add(new Contact(Id=con.Id,MailingCountry=acc.BillingCountry,MailingCountryCode = acc.BillingCountryCode,MailingCity=acc.BillingCity,MailingState=acc.BillingState));
            }
        }
        if(!conList.isEmpty()){
            Update conList;
        }
    }

    public static void question20(List<Account> accList){
        for(Account acc:accList){
            if(acc.Active__c == 'Yes'){
                acc.addError(Label.Error_Message);
            }
        }
    }

    public static void question21(List<Account> accList,Map<Id,Account> accOldMap){
        for(Account acc:accList){
            if(acc != accOldMap.get(acc.Id) && acc.CreatedDate > System.TODAY()-6){
                acc.addError(Label.Error_Message_Question21);
                System.debug('Ujjawala');
            }
        }
    }

    public static void question25(List<Account> accList){
        Id sysAdmin = [SELECT Id,Name FROM Profile WHERE Name='System Administrator' LIMIT 1].Id;
        for(Account acc:accList){
            if(UserInfo.getProfileId() != sysAdmin){
                acc.addError('Only system admin can delete the account ');
            }
        } 
    }

    public static void question27(Map<Id,Account> accMap){
        List<Account> accList = [SELECT Id,(SELECT Id FROM Opportunities) FROM Account WHERE Id IN:accMap.KeySet()];
        for(Account acc:accList){
            if(acc.Opportunities.Size() > 0){
                Account acc1 = accMap.get(acc.Id);
                acc1.addError('Deletion not possible as related opportunity is present');
            }
        }
    }

    public static void question28(Map<Id,Account> accMap){
        //List<Opportunity> oppList = [SELECT AccountId,StageName,IsClosed FROM Opportunity WHERE StageName = 'Closed Won' AND IsClosed = false];
        List<Account> accList = [SELECT Id,Name FROM Account WHERE Id IN (SELECT AccountId FROM Opportunity WHERE StageName = 'Closed Won' AND IsClosed = false) ];
        for(Account acc:accList){
            accMap.get(acc.Id).addError('Deletion is not possible as open or closed won opportunity is present');
        }
    }

    public static void question41(List<Account> accList,Map<Id,Account> accOldMap){
        List<Contact> conList = new List<Contact>();
        Set<Id> accIds = new Set<Id>();
        for(Account acc:accList){
            if(accOldMap != null && acc.OwnerId != accOldMap.get(acc.Id).OwnerId){
                accIds.add(acc.Id);
            }    
        }

        List<Account> accListNew = [SELECT Id,OwnerId,(SELECT Id,OwnerId FROM Contacts) FROM Account WHERE Id IN:accIds ];
        if(!accList.isEmpty()){
            for(Account acc:accListNew){
                for(Contact con:acc.Contacts){
                    conList.add(new Contact(Id=con.Id,OwnerId = acc.OwnerId));
                }
            }
        }
        if(!conList.isEmpty()){
            update conList;
        }
    }

    public static void question40(List<Account> accList,Map<Id,Account> accOldMap){
        Set<Id> accIds = new Set<Id>();
        for(Account acc:accList){
            if(acc.Active__c == 'No' ){
                accIds.add(acc.Id);
            }
        }

        List<Opportunity> oppList = [SELECT Id,StageName,AccountId FROM Opportunity WHERE AccountId IN:accIds ];

        for(Opportunity opp:oppList){
            opp.StageName = 'Closed Lost';
        }

        
            if(!oppList.isEmpty()){
            update oppList;
            
            }
    }

    public static void question42(List<Account> accList,Map<Id,Account> accOldMap){
        Map<Id,Account> accMap = new Map<Id,Account>();
        for(Account acc:accList){
            String oldName = accOldMap.get(acc.Id).OwnerId;
            if(acc.OwnerId != oldName){
                accMap.put(acc.Id,acc);
            }
        }

        List<Contact> conList = [SELECT Id,OwnerId,AccountId FROM Contact WHERE AccountId IN: accMap.KeySet()];

        if(!conList.isEmpty()){
            for(Contact con:conList){
                con.OwnerId = accMap.get(con.AccountId).OwnerId;
            }
            update conList;
        }
        
    }

    public static void recursionDemo(List<Account> accList){
        List<Account> accList1 = new List<Account>();
        for(Account acc:accList){
            accList1.add(new Account(Id=acc.Id,Description =' Recursion Demo'));
        }
        update accList1;
    }

    public static void callContactAndUserUpdate(List<Account> accList,Map<Id,Account> accOldMap){
        Set<Id> accIds = new Set<Id>();
        for(Account acc:accList){
            if(acc.Active__c != accOldMap.get(acc.Id).Active__c){
                accIds.add(acc.Id);
            }
        }
        List<Contact> conList = [SELECT ActiveContact__c,Account.Active__c FROM Contact WHERE AccountId IN: accIds];

        if(!conList.isEmpty()){
            for(Contact con: conList){
                if(con.Account.Active__c == 'Yes'){
                    con.ActiveContact__c = true;
                }else{
                    con.ActiveContact__c = false;
                }
            }
            update conList;
        }
        if(!accIds.isEmpty()){
            futureCallContactAndUserUpdate(accIds);
        }
        
    }

    @future
    public static void futureCallContactAndUserUpdate(Set<Id> accIds){     
        List<User> usList = new List<User>();
        List<Account> accList = [SELECT Id,OwnerId,Active__c FROM Account WHERE Id IN:accIds];
        if(!accList.isEmpty()){
            for(Account acc:accList){
                if(acc.Active__c == 'Yes'){
                    usList.add(new User(Id=acc.OwnerId,IsActive = true));
                }else{
                    usList.add(new User(Id=acc.OwnerId,IsActive = false));
                }
            }
        }
        if(!usList.isEmpty()){
            update usList;
        }
        
    }
}
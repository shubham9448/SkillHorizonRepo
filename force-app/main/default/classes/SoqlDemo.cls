public class SoqlDemo {
    
    public static void demo(){
        List<Account> accList = [SELECT ID,Name FROM Account 
                                 WHERE Rating = 'Hot' AND Industry = 'Media'];
        
        Set<Id> accIdSet = new Set<Id>();
        if(!accList.isEmpty()){
            for(Account acc:accList){
                System.debug(acc);
                accIdSet.add(acc.Id);
            }
        }
        
        List<Account> accList2 = [SELECT Id,Name FROM Account 
                                  WHERE Id IN:accIdSet];
    }
    
    
    public static void aggregateResult(){
        List<AggregateResult> argList = [SELECT Account.Name ,SUM(Amount) sum,MIN(Amount) min,MAX(Amount) max FROM Opportunity 
                                         GROUP BY Account.Name HAVING SUM(Amount) > 50000];
        System.debug(argList);
        
        for(AggregateResult ar:argList){
        	System.debug('Name = '+ar.get('Name'));
            System.debug('Sum = '+ar.get('sum'));
            System.debug('Min = '+ar.get('min'));
            System.debug('Max = '+ar.get('max'));
        }
    }
    
    public static void question1(){
        Set<Id> accIds = new Set<Id>();
        List<Account> accList = [SELECT Id FROM Account LIMIT 5];
        for(Account acc:accList){
        	accIds.add(acc.Id);    
        }
        System.debug(accIds);
    }
    
    public static void question2(){
        Map<Id,Account> accMap = new Map<Id,Account>();
        List<Account> accList = [SELECT Id,Name,Phone FROM Account LIMIT 5];
        //accMap.putAll([SELECT Id,Name,Phone FROM Account LIMIT 5]);
        for(Account acc: accList){
            accMap.put(acc.Id,acc);
        }
        System.debug(accMap.Values());
    }
    
    public static void question3(){
       	Map<Id,Account> accMap = new Map<Id,Account>();
        accMap.putAll([SELECT Id,Name,Phone FROM Account LIMIT 5]);
        System.debug(accMap.Values());
    }
    
    public static void question4(){
        Set<Id> accIds = new Set<Id>();
        Map<Id,Account> accMap = new Map<Id,Account>();
        List<Account> accList = [SELECT Id,Name FROM Account LIMIT 5];
        for(Account acc:accList){
        	accIds.add(acc.id);
            accMap.put(acc.Id,acc);
        }
        
        for(Id i:accIds){
            if(accMap.containsKey(i)){
                System.debug(accMap.get(i));
            }
        }
    }
    
    public static void question5(){
        List<Account> accList = [SELECT Id,Name FROM Account 
                                 WHERE CreatedDate = THIS_WEEK AND CreatedDate = LAST_WEEK];
    }
    
    public static void question6(){
        List<Contact> conList = [SELECT Id,FirstName,LastName,Phone FROM Contact 
                                 WHERE CreatedDate = THIS_WEEK AND CreatedDate = LAST_WEEK];
    }
    
    public static void question7(){
        List<Account> accList = [SELECT Id,Name,Phone,(SELECT Id,FirstName,LastName,Phone FROM Contacts) 
                                 FROM Account WHERE CreatedDate = LAST_WEEK AND CreatedDate = THIS_WEEK ];
    }
    
    public static void question8(){
        List<Contact> conList = [ SELECT Id,FirstName,LastName,Account.Name,Account.Phone FROM Contact 
                                 WHERE CreatedDate = THIS_WEEK AND CreatedDate= LAST_WEEK ];
    }
    
    public static void question9(){
        //ASC
    	List<Account> accListAsc = [SELECT Id,Name,Phone,(SELECT Id,Name,StageName,CloseDate FROM Opportunities) FROM Account 
                                 WHERE Phone != null ORDER BY CreatedDate ASC];  
        System.debug(accListAsc);
        //DESC
        List<Account> accListDesc = [SELECT Id,Name,Phone,(SELECT Id,Name,StageName,CloseDate FROM Opportunities) FROM Account 
                                 WHERE Phone != null ORDER BY CreatedDate DESC]; 
        System.debug(accListDesc);
    } 
    
    public static void question10(){
        List<Account> accList = [SELECT Id,Name,Phone,(SELECT Id,FirstName,LastName FROM Contacts) FROM Account WHERE Phone != null ];
        for(Account acc:accList){
            System.debug(acc.Name +' has '+acc.Contacts.Size()+' related Contacts');
        }
    }
    
    public static void question11(){
        List<AggregateResult> agrList = [SELECT Account.Name,SUM(Amount) sum FROM Opportunity 
                                         WHERE Account.Phone != null GROUP BY Account.Name ];
        for(AggregateResult arg:agrList){
            System.debug(arg.get('Account.Name') +' has '+arg.get('sum')+' worth Opportunities');
        }
    }
    
    public static void question12(){
        
    }
    
    public static void question13(){
        List<Account> accList = new List<Account>();
        for(Integer i=1;i<=5;i++){
            accList.add(new Account(Name = 'Demo test '+i,Phone='123456'));
        }
        if(!accList.isEmpty()){
            insert accList;
        }
    }
    
    public static void question14(){
        List<Opportunity> oppList = new List<Opportunity>();
        for(Integer i=1;i<=5;i++){
            oppList.add(new Opportunity(Name='Opportunity demo '+i,StageName = 'Prospecting',CloseDate = System.TODAY()));
        }
        if(!oppList.isEmpty()){
            insert oppList;
        }
    }
    
    public static void question15(){
        Account acc = new Account();
        acc.Name = 'Account Demo Test';
        acc.Active__c = 'Yes';
        acc.Phone = '34353453';
        
        insert acc;
        
        Contact con = new Contact();
        con.LastName = acc.Name;
        con.Phone = acc.Phone;
        con.FirstName = 'TEST';
        con.AccountId = acc.Id;
        
        insert con;
    }
    
    public static void question16(){
    
        Account acc = new Account();
        acc.Name = 'Account Demo Test';
        acc.Active__c = 'Yes';
        acc.Phone = '34353453';
        
        insert acc;
        
        Contact con = new Contact(LastName = acc.Name,Phone = acc.Phone,FirstName = 'TEST',AccountId = acc.Id);        
        insert con;
        
        Opportunity opp = new Opportunity(Name = 'Test Opportunity ',StageName = 'Prospecting',CloseDate = System.TODAY(),AccountId = acc.Id);
        insert opp;
    }
    
    public static void question17(){
        List<Account> accList = new List<Account>();
        List<Opportunity> oppList = new List<Opportunity>();
        for(Integer i=1;i<=5;i++){
            Account acc = new Account();
        	acc.Name = 'Account Demo Test '+i;
        	acc.Active__c = 'Yes';
        	acc.Phone = '34353453'+i;
        	accList.add(acc);
        }
        if(!accList.isEmpty()){
            Database.insert(accList,false);
        }
        for(Account acc:accList){
        	oppList.add(new Opportunity(Name = acc.Name,StageName = 'Prospecting',CloseDate = Date.TODAY(),AccountId = acc.Id));    
        }
        Database.insert(oppList,false);        
    }
    
    public static void question18(){
        List<Account> accList = new List<Account>();
        List<Opportunity> oppList = new List<Opportunity>();
        List<Contact> conList = new List<Contact>();
        for(Integer i=6;i<=10;i++){
        	accList.add(new Account(Phone = '34353453'+i,Name = 'Account Demo Test '+i,Active__c = 'Yes'));
        }
        if(!accList.isEmpty()){
            Database.insert(accList,false);
        }
        for(Account acc:accList){
        	oppList.add(new Opportunity(Name = acc.Name,StageName = 'Prospecting',CloseDate = Date.TODAY(),AccountId = acc.Id)); 
            conList.add(new Contact(LastName = acc.Name,Phone = acc.Phone,AccountId = acc.Id));
        }
        Database.insert(oppList,false);
		Database.insert(conList,false);        
    }
    
    public static void question19(){
        List<Account> accList = [SELECT Id,Phone FROM Account WHERE Phone = null LIMIT 5];
        if(!accList.isEmpty()){
            for(Account acc:accList){
                acc.Phone = '654321';
            }
            update accList;
        }
    }
    
    public static void question20(){
        List<Contact> conList = [SELECT Id,Email FROM Contact WHERE Email = NULL];
        if(!conList.isEmpty()){
            for(Contact con:conList){
                con.Email = 'test@test.com';
            }
            update conList;
        }
    }
    
    public static void question21(){
        List<Account> accList = [SELECT Id,Phone FROM Account WHERE Phone = NULL LIMIT 5];
        if(accList.isEmpty()){
            for(Account acc:accList){
                acc.Phone = '123456';
            }
            
            for(Integer i=6;i<=10;i++){
                accList.add(new Account(Name = 'Test Demo Test '+i,Active__c ='Yes'));
            }
            Database.upsert(accList,false);
        }
        
    }
    
    /*public static void parentChild(){
        List<Account> accList = [SELECT Id,(SELECT Id,FirstName,LastName FROM Contacts) FROM Account];
        for(Account acc:accList){
            System.debug(acc);
            if(!acc.COntacts.isEmpty()){
                for(Contact con:acc.Contacts){
                    System.debug(con.FirstName);
                    System.debug(con.LastName);
                }    
            }
            
        }
    }*/
    
        public static void question22(){
        List<Opportunity> oppList = [SELECT Id ,StageName FROM Opportunity WHERE CreatedDate = LAST_MONTH ];
        if(!oppList.isEmpty()){
            for(Opportunity opp:oppList){
                opp.StageName = 'Closed Won';
            } 
            
            for(Integer i=1;i<=5;i++){
                oppList.add(new Opportunity(Name = 'Test demo '+i,StageName = 'Prospecting',CloseDate = System.Today()));
            }
            upsert oppList;
        }            
    }
    
    public static void question23(){
        List<Account> accList = [SELECT Id,Phone FROM Account WHERE Phone='123456' LIMIT 5];
        if(!accList.isEmpty()){
            Database.delete(accList,false);
        }
    }
    
    public static void question24(){
        List<Account> accList = [SELECT Id,Phone FROM Account WHERE Phone ='123456' ALL ROWS];
        if(!accList.isEmpty()){
            undelete accList;
        }
    }
    
    public static void question25(){
        List<Opportunity> oppList = [SELECT Id,StageName FROM Opportunity 
                                     WHERE StageName = 'Closed Lost' AND CreatedDate = LAST_MONTH];
        if(!oppList.isEmpty()){
            delete oppList;
        }
    }
    
    public static void question26(){
        List<Opportunity> oppList = new List<Opportunity>();
        List<Account> accList = [SELECT Id,Name FROM Account WHERE CreatedDate = LAST_WEEK];
        if(!accList.isEmpty()){
            for(Account acc:accList){
            	oppList.add(new Opportunity(Name = acc.Name,CloseDate = System.TODAY(),StageName = 'Prospecting',AccountId = acc.Id));    
            }
            insert oppList;
        }
    }
    
    public static void question27(){
        List<Account> accList = [SELECT Id,Phone FROM Account WHERE CreatedDate = LAST_N_DAYS:9];
        if(!accList.isEmpty()){
            for(Account acc:accList){
                acc.Phone = '1234567890';
            }
            Database.update(accList,false);
        }
        
    }
    
    public static void question28(){
        List<Opportunity> oppList = [SELECT Id,StageName FROM Opportunity WHERE isClosed = true AND CreatedDate = LAST_N_Days:7];
        if(!oppList.isEmpty()){
            for(Opportunity opp:oppList){
                if(opp.StageName == 'Closed Won'){
                    opp.Description = 'Opportunity is Closed Won';
                }else{
                    opp.Description = 'Opportunity is Closed Lost';
                }
                System.debug(opp.Description);
            }            
            update oppList;
        }
    }
    
    public static void question29(){  //doubt why directly we were unable to assign why new instance was required // i think because contact was involved so related
        List<Account> updatedAccount = new List<Account>();
        List<Account> accList = [SELECT Id,Name,Total_Contact__c,(SELECT Id FROM Contacts) FROM Account WHERE CreatedDate = LAST_MONTH];
        if(!accList.isEmpty()){
            for(Account acc:accList){
                updatedAccount.add(new Account(Id = acc.Id,Total_Contact__c=  acc.Contacts.size() >0 ? acc.Contacts.size():0 ));               
            }
          Database.update(updatedAccount,true);  
        }
    }
    
    public static void question30(){
        List<Contact> conList = [SELECT Id,Phone,Account.Phone FROM Contact WHERE CreatedDate = LAST_WEEK AND Phone = null ];
        List<Contact> updateConList = new List<Contact>();
        if(!conList.isEmpty()){
            for(Contact con:conList){
            	updateConList.add(new Contact(Id = con.Id,Phone = con.Account.Phone));	    
            }
            update updateConList;
        }
    }
    
    public static void question34(){
        List<Position__c> posList = [SELECT Id,Name,(SELECT Id,Name FROM Job_Applications__r) FROM Position__c];
        if(!posList.isEmpty()){
            for(Position__c pos:posList){
                if(!pos.Job_Applications__r.isEmpty()){
                	System.debug('Position Name '+pos.Name);
                    for(Job_Application__c js:pos.Job_Applications__r){
                    	System.debug('Job Application '+js.Name);    
                    }
                }
            }
        }
    }
    
    public static void question35(){
        List<Candidate__c> canList = [SELECT Id,Name,(SELECT Id,Name FROM Job_Applications__r) FROM Candidate__c];
        if(!canList.isEmpty()){
            for(Candidate__c can:canList){
                System.debug('Candidate '+can.Name);
                if(!can.Job_Applications__r.isEmpty()){
                    for(Job_Application__c js:can.Job_Applications__r){
                        System.debug('Job application '+js.Name);
                    }	    
                }
            }
        }        
    }
    
    public static void question36(){
        List<Job_Application__c> JaList = [SELECT Id,Name,(SELECT Id,Candidate__c FROM Reviews__r) FROM Job_Application__c];
        
        if(!JaList.isEmpty()){
            for(Job_Application__c ja:JaList){
                System.debug('Job Application '+ja.Name);
                if(!ja.Reviews__r.isEmpty()){
                    for(Review__c r:ja.Reviews__r){
                    System.debug('Review Candidate '+r.Candidate__c);    
                    }
                }
            }
        }
    }
    
    public static void question37(){
        List<Job_Application__c> JaList = [SELECT Id,Name,(SELECT Id,Candidate__c FROM Reviews__r),Total_Number_of_Reviews__c FROM Job_Application__c];
        List<Job_Application__c> updateJaList = new List<Job_Application__c>();
        if(!JaList.isEmpty()){
            for(Job_Application__c ja:JaList){
                System.debug('Job Application '+ja.Name);
                updateJaList.add(new Job_Application__c(Id = ja.Id,Total_Number_of_Reviews__c = ja.Reviews__r.size()== null? 0: ja.Reviews__r.size()));
            }
        }
    }
    
	
    // See Deleted records
    /*public static void demo1(){
        List<Account> accList = [SELECT Id,Name FROM Account WHERE IsDeleted = true ALL ROWS];
        System.debug(accList);
        for(Account acc:accList){
        	System.debug(acc.Name);    
        }
    }*/
    
    public static void demo2(){
    	List<List<sObject>> soslQuery = [FIND 'Courtney Brown' IN ALL FIELDS RETURNING User(Name)];
        System.debug(soslQuery);
    }
    
    public static void demo3(){
        List<Account> accList = new List<Account>{
            new Account(Name ='Test1'),
                new Account(Name ='Test2'),
                new Account(Name = 'Test 3'),
                new Account()
        };
            
            List<Database.SaveResult> srList = Database.insert(accList,false);
        
    }
    
    
}
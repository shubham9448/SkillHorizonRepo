public class PracticeExample {
	/*public static void question1(){
        Set<Id> accSet = new Set<Id>();
        List<Account> accList = [SELECT Id FROM Account LIMIT 5];
        for(Account acc:accList){
            accSet.add(acc.Id);
        }
        System.debug(accSet);
    }
    
    public static void question2(){
        Map<Id,Account> accMap = new Map<Id,Account>();
        List<Account> accList = [SELECT Id FROM Account LIMIT 5];
        for(Account acc:accList){
            accMap.put(acc.id,acc);
        }
        
        for(Id i:accMap.KeySet()){
            System.debug(accMap.get(i));
        }
    }
    
    public static void question3(){
        Map<Id,Account> accMap = new Map<Id,Account>();
        List<Account> accList = [SELECT Id FROM Account LIMIT 5];
        accMap.putAll(accList);
        
        System.debug(accMap.values());
    }
    
    public static void question4(){
        Set<Id> accSet = new Set<Id>();
        Map<Id,Account> accMap = new Map<Id,Account>();
        List<Account> accList = [SELECT Id FROM Account LIMIT 5];
        for(Account acc:accList){
            accSet.add(acc.Id);
            accMap.putAll(accList);
        }
        
        for(Id i:accSet){
            if(accMap.containsKey(i)){
                System.debug(accMap.get(i));
            }
        }
        
    }
    
    public static void question5(){
        List<Account> accList = [SELECT Id,Name,CreatedDate FROM Account WHERE CreatedDate = LAST_WEEK];
        for(Account acc:accList){
            System.debug(acc);
        }
    }
    
    public static void question6(){
        List<Contact> conList = [SELECT Id,FirstName,LastName,CreatedDate FROM Contact WHERE CreatedDate = LAST_WEEK];
        for(Contact con:conList){
            System.debug(con);
        }
    }
    public static void question7(){
        List<Account> accList = [SELECT Id,Name,(SELECT Id,Name FROM Contacts) FROM Account WHERE CreatedDate = LAST_WEEK];
        for(Account acc: accList){
            System.debug(acc.Name);
            for(Contact con:acc.Contacts){
                System.debug(con.FirstName+''+con.LastName);
            }
        }
    }
    
    public static void question8(){
        List<Contact> conList = [SELECT Id,Account.Name,Account.Phone FROM Contact WHERE CreatedDate = LAST_WEEK];
        for(Contact con:conList){
            System.debug('The Account Name is '+con.Account.Name +' and number is '+con.Account.phone);
        }
    }
    
    public static void question9(){
        List<Account> accList = [SELECT Id,Name,Phone,(SELECT Id,Name,CloseDate,StageName FROM Opportunities) 
                                 FROM Account WHERE Phone != NULL ORDER BY CreatedDate ASC];
        for(Account acc:accList){
            System.debug(acc.Name);
            for(Opportunity opp:acc.Opportunities){
                System.debug(opp);
            }
        }
    }
    
    public static void question10(){
        List<Account> accList = [SELECT Id,Name,(SELECT Id,FirstName,LastName FROM Contacts) FROM Account WHERE Phone != NULL];
        for(Account acc:accList){
                System.debug(acc.Name +' has '+acc.Contacts.Size()+' Related Contacts');
        }
    }
    
    public static void question11(){
        
        List<Account> accList = [SELECT Id,Name,(SELECT Id,Amount FROM Opportunities) FROM Account WHERE Phone != Null];
        for(Account acc:accList){
            Decimal Total=0;
            for(Opportunity opp:acc.Opportunities){
                Total+=opp.Amount;
            }
            System.debug(acc.Name+' has '+Total+' worth Opportunities');
        }
    }
    
    public static void question12(){
        Account acc1 = new Account();
        acc1.Name = 'Account_1';
        acc1.Active__c='Yes';
        
        insert acc1;
        
        Account acc2 = new Account();
        acc2.Name = 'Account_1';
        acc2.Active__c='Yes';
        
        insert acc2;
        
        List<Account> accList = new List<Account>();
        Account acc = new Account();
        acc.Name = 'Account_1';
        acc.Active__c='Yes';
        accList.add(acc);
        
        Account acc3 = new Account();
        acc3.Name = 'Account_1';
        acc3.Active__c='Yes';
        accList.add(acc3);
        
        insert accList;
    }
    
    public static void question13(){
        List<Account> accList = new List<Account>();
        for(Integer i=1;i<=5;i++){
        	accList.add(new Account(Name='Test Demo '+i,Phone='123456'));    
        }
        insert accList;
    }
    
    public static void question14(){
        List<Opportunity> oppList = new List<Opportunity>();
        for(Integer i=1;i<=5;i++){
            oppList.add(new Opportunity(Name='Test Opp '+i,CloseDate=Date.TODAY(),StageName='Prospecting'));
        }
        insert oppList;
    }
    
    public static void question15(){
        Account acc = new Account();
        acc.Name ='Account Demo';
        acc.Active__c='Yes';
        
        insert acc;
        
        Contact con = new Contact();
        con.FirstName = 'Contact';
        con.LastName = 'Demo';
        con.AccountId = acc.Id;
        con.Phone = '348732469';
        
        insert con;
    }
    
    public static void question16(){
        Account acc = new Account();
        acc.Name = 'Demo Account';
        acc.Phone = '2382873018'; 
        insert acc;
        
        Contact con = new Contact();
        con.FirstName = 'Test';
        con.LastName = acc.Name;
        con.Phone = '83408237432';
        insert con;
        
        Opportunity opp = new Opportunity();
        opp.Name = acc.Name;
        opp.CloseDate = Date.TODAY();
        opp.StageName = 'Prospecting';
        insert opp;
    }
    
    public static void question17(){
        List<Account> accList = new List<Account>();
        List<Opportunity> oppList = new List<Opportunity>();
        for(Integer i=1;i<=5;i++){
            Account acc = new Account();
            acc.Name = 'Test Demo '+i;
            acc.Phone = '934629237'+i;
            accList.add(acc);
        }
        Database.insert(accList,false);
        
        for(Account acc:accList){
            Opportunity opp = new Opportunity();
            opp.Name = acc.Name;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.TODAY();
            oppList.add(opp);
        }
        Database.insert(oppList,false);     
    }
    
    public static void question18(){
        List<Account> accList = new List<Account>();
        List<Opportunity> oppList = new List<Opportunity>();
        List<Contact> conList = new List<Contact>();
        for(Integer i=1;i<=5;i++){
        	Account acc = new Account();
            acc.Name= 'Test Demo '+i;
            acc.Active__c= 'Yes';
            accList.add(acc);
        }
        insert accList;
        
        for(Account acc:accList){
            for(Integer i=1;i<=5;i++){
                Opportunity opp = new Opportunity();
                opp.Name = acc.Name;
                opp.CloseDate= System.TODAY();
                opp.StageName = 'Prospecting';
                opp.AccountId = acc.Id;
                oppList.add(opp);
                
                Contact con = new Contact();
                con.AccountId = acc.Id;
                con.FirstName = 'Test '+i;
                con.LastName = acc.Name;
                con.Phone = '893463298'+i;
                conList.add(con);
            }
            
        }
        insert oppList;
        insert conList;        
    }
    
    public static void question19(){
        List<Account> accList = [SELECT Id,Name FROM Account WHERE Phone = NULL];
        for(Account acc:accList){
            acc.Phone= '654321';
        }
        Database.update(accList,False);
    }
    
    public static void question20(){
        List<Contact> conList = [SELECT Id,FirstName,LastName FROM Contact WHERE Email = NULL];
        for(Contact con:conList){
            con.Email = 'test@test.com';
        }
        update conList;
    }
    
    public static void question21(){
        List<Account> accList = [SELECT Id,Name FROM Account WHERE Phone = NULL];
        for(Account acc:accList){
            acc.Phone = '123456';
        }
        
        for(Integer i=1;i<=5;i++){
            Account acc = new Account();
            acc.Name= 'Test Demo '+i;
            acc.Active__c= 'Yes';
            accList.add(acc);
        }
        Database.UPSERT(accList,false);
    }
    
    public static void question22(){
        List<Opportunity> oppList = [SELECT Id,Name FROM Opportunity WHERE CreatedDate = LAST_MONTH];
        for(Opportunity opp:oppList){
            opp.StageName = 'Closed Won';
        }
        
        for(Integer i=1;i<=5;i++){
            Opportunity opp = new Opportunity();
            opp.Name= 'Test Opp '+i;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.TODAY();
            oppList.add(opp);
        }
        
        UPSERT oppList;
    }
    
    public static void question23(){
        List<Account> accList = [SELECT Id FROM Account WHERE Phone ='123456'];
        Database.Delete(accList,False);
    }
    
    public static void question24(){
        List<Account> accList = [SELECT Id FROM Account WHERE Phone = '123456' ALL ROWS];
        UNDELETE accList;
    }
    
    public static void question25(){
        List<Opportunity> oppList = [SELECT Id FROM Opportunity WHERE StageName= 'Closed Lost' AND CreatedDate = LAST_MONTH];
        Delete oppList;
    }
    
    public static void question26(){
        List<Account> accList = [SELECT Id FROM Account WHERE CreatedDate = LAST_WEEK];
        List<Opportunity> oppList = new List<Opportunity>();
        for(Account acc:accList){
            Opportunity opp = new Opportunity();
            opp.Name = 'Test '+acc.Name;
            opp.CloseDate= System.TODAY();
            opp.StageName = 'Prospecting';
            oppList.add(opp);
        }
    }
    
    public static void question27(){
        List<Account> accList = [SELECT Id FROM Account 
                                 WHERE CreatedDate = LAST_N_DAYS:9];
        for(Account acc:accList){
            acc.Phone='1234567890';
        }
        Database.insert(accList,false);
    }
    
    public static void question28(){
        List<Opportunity> oppList = [SELECT Id,Name FROM Opportunity 
                                     WHERE CreatedDate = LAST_N_DAYS:7];
        for(Opportunity opp:oppList){
            if(opp.StageName == 'Closed Won'){
                opp.Description = 'Opportunity is Closed Won';
            }else if(opp.StageName == 'Closed Lost'){
                opp.Description = 'Opportunity is Closed Lost';
            }else{
                opp.Description = 'Work is under way';
            }
        }
    }
    
    public static void question29(){
        List<Account> accList = [SELECT Id,Name,(SELECT Id FROM Contacts) 
                                 FROM Account WHERE CreatedDate = LAST_MONTH];
        for(Account acc:accList){
            if(acc.Contacts == NULL){
                acc.Total_Contact__c = 0;
            }else{
                acc.Total_Contact__c = acc.Contacts.Size();
            }
        }
        insert accList;
    }
    
    public static void question30(){
        List<Contact> conList = [SELECT Id,account.Phone FROM Contact 
                                 WHERE Phone = NULL AND CreatedDate = LAST_WEEK];
        for(Contact con:conList){
            con.Phone = con.Account.Phone;
        }
        Database.UPDATE(conList,false);
    }
    
    public static void question31(){
    	List<Account> accList = [SELECT Id,(SELECT Id,Salary__c FROM Employees__r),Total_Salary__c 
                                 FROM Account WHERE CreatedDate = THIS_YEAR];
        for(Account acc:accList){
            Decimal Total = 0;
            for(Employee__c emp:acc.Employees__r){
                Total+=emp.Salary__c;
            }
            acc.Total_Salary__c= Total;
        }
        UPDATE accList;
    }
    
    public static void question32(){
        List<Employee__c> empList = [SELECT Id,Phone__c,Account__r.Phone FROM Employee__c
                                WHERE CreatedDate = THIS_YEAR AND Phone__c = NULL];
        for(Employee__c emp:empList){
            emp.Phone__c = emp.Account__r.Phone;
        }
        Database.UPDATE(empList);
    }
    
    public static void question33(){
        List<Contact> conList = [SELECT Id,Employee__r.Phone__c,Phone FROM Contact 
                                 WHERE CreatedDate = LAST_WEEK AND Phone = NULL ];
        for(Contact con:conList){
            con.Phone = con.Employee__r.Phone__c;
        }
        Database.UPDATE(conList);
    }
    
    public static void question34(){
        List<Position__c> posList = [SELECT Id,Name,(SELECT Id,Name FROM Job_Applications__r) FROM Position__c];
        for(Position__c pos:posList){
            System.debug(pos);
        }
    }
    
    public static void question35(){
        List<Candidate__c> canList = [SELECT Id,(SELECT Id FROM Job_Applications__r) FROM Candidate__c];
        for(Candidate__c can:canList){
            System.debug(can);
        }
    }
    
    public static void question36(){
        List<Job_Application__c> jobList = [SELECT Id,(SELECT Id FROM Reviews__r) FROM Job_Application__c];
        for(Job_Application__c ja:jobList){
            System.debug(ja);
        }
    }
    public static void question37(){
        List<Job_Application__c> jobList = [SELECT Id,(SELECT Id FROM Reviews__r) FROM Job_Application__c];
        for(Job_Application__c ja:jobList){
            Integer total=ja.Reviews__r.Size();
            System.debug('This job application '+ja+'has this much reviews'+total);
                
        }
    }*/
}
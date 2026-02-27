public class collectionWithLoop {
    public static void demo(){
        List<Account> accList = [SELECT Id,Name FROM Account LIMIT 10];
        Set<Id> accSet = new Set<Id>();
        Map<Id,Account> accMap = new Map<Id,Account>();
        System.debug('Output from List');
        if(!accList.isEmpty()){
            for(Account acc:accList){
                System.debug(acc);
                accSet.add(acc.Id);
            }
            
            if(!accSet.isEmpty()){
                for(Id i :accSet){
                    System.debug(i);
                }
            }
            accMap.putAll(accList);
            
            for(Id i:accMap.KeySet()){
                System.debug(accMap.get(i));
            }
        }
    }
    
    
    public static void demo1(){
        List<Resource__c> resList = [SELECT Name,RecordTypeId,Phone__c FROM Resource__c];
        Map<String,Resource__c> resMap = new Map<String,Resource__c>();
        for(Resource__c re:resList){
            if(!resMap.ContainsKey(re.Name)){
            	resMap.put(re.Name,re);    
            }            
        }
        
        System.debug(resMap);
    }
    
    public static void question1(){
        List<Account> accList = new List<Account>();
        List<Opportunity> oppList = new List<Opportunity>();
        Set<Id> accId = new Set<Id>();
        Set<Id> oppId = new Set<Id>();
        Map<Id,Opportunity> oppMap = new Map<Id,Opportunity>();
        
        
        for(Integer i=1;i<=5;i++){
        	accList.add(new Account(Name ='Test'+i,Active__c = 'Yes'));    
        }
        if(!accList.isEmpty()){
        	insert accList;    
        }
        
        
        for(Account acc:accList){
        	oppList.add(new Opportunity(Name =acc.Name,AccountId=acc.Id,StageName = 'Prospecting',CloseDate = System.TODAY()));	    
        }
        if(!oppList.isEmpty()){
        	insert oppList;    
        }
        
        
        for(Opportunity opp:oppList){
        	accId.add(opp.AccountId);
        	oppId.add(opp.Id);    
        }
        
        oppMap.putAll(oppList);
        
        for(Id i:oppMap.KeySet()){
            System.debug(oppMap.get(i));
        }
        
        for(Opportunity opp1: oppMap.Values()){
            System.debug(opp1);
        }
    }
    
    
}
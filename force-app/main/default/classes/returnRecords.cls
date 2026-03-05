public with sharing class returnRecords {
    @AuraEnabled(cacheable=true)
    public static List<sObject> getRecords(String ObjectName){
        if(ObjectName == 'Account'){
            return [SELECT Id,Name,Industry,Phone FROM Account LIMIT 10];
        }else if(ObjectName == 'Contact'){
            return [SELECT Id,FirstName,LastName,Email FROM Contact LIMIT 10];
        }else if(ObjectName == 'Lead'){
            return [SELECT Id,FirstName,LastName,Company FROM Lead LIMIT 10];
        }else if(ObjectName == 'Opportunity'){
            return [SELECT Id,Name,StageName,Amount FROM Opportunity LIMIT 10];    
        }else{
            return new List<sObject>();
        }
        
    }
}
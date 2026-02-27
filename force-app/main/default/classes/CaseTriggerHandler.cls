public with sharing class CaseTriggerHandler {
    public static void question7(List<Case> caseList){
        List<Account> accList = new List<Account>();
        for(Case cs:caseList){
            if(cs.AccountId != null){
                accList.add(new Account(Id=cs.AccountId,Latest_Case_Number__c=cs.CaseNumber));
            }
        }
        if(!accList.isEmpty()){
            update accList;
        }

    }

    public static void question34(List<Case> caseList){
        Map<Id,Account> accMap = new Map<Id,Account>();
        Map<Id,Decimal> countPartnerMap = new Map<Id,Decimal>();
        Map<Id,Decimal> countCustomerMap = new Map<Id,Decimal>();
        Set<Id> accIds = new Set<Id>();
        Id partnerId = [SELECT Id FROM RecordType WHERE Name='Partner Case' AND sObjectType= 'Case'].Id;
        Id customerId = [SELECT Id FROM RecordType WHERE Name='Customer Case' AND sObjectType = 'Case'].Id;
        //get case related account
        for(Case cs:caseList){
            if(cs.AccountId != null){
                accIds.add(cs.AccountId);
            }
        }
        //
        List<AggregateResult> argParList = [SELECT AccountId,COUNT(Id) num FROM Case WHERE RecordTypeId =: partnerId GROUP BY AccountId];
        for(AggregateResult ar:argParList){
            countPartnerMap.put((Id)ar.get('AccountId'),(decimal)ar.get('num'));
        }
        List<AggregateResult> argCusList = [SELECT AccountId,COUNT(Id) num FROM Case WHERE RecordTypeId =: customerId GROUP BY AccountId];
        for(AggregateResult ar:argCusList){
            countCustomerMap.put((Id)ar.get('AccountId'),(decimal)ar.get('num'));
        }
        if(countPartnerMap != null || countCustomerMap != null){
            for(Id i:accIds){
            accMap.put(i,new Account(Id=i,Total_Customer_Case__c=countCustomerMap.get(i),Total_Partner_Case__c=countPartnerMap.get(i)));
            }
        }
        if(!accMap.values().isEmpty()){
            update accMap.values();
        }
    }


    public static void webCase(List<Case> csList){
        Set<Id> webCaseId = new Set<Id>();
        for(Case cs:csList){
            if(cs.Origin == 'Web'){
                webCaseId.add(cs.Id);
            }
        }
        if(!webCaseId.isEmpty()){
            futureWebCase(webCaseId);
        }
        
    }
    @future 
    public static void futureWebCase(Set<Id> caseId){
        try{
            List<Case> csList = [SELECT Id FROM Case WHERE Id IN: caseId];
            Delete csList;
        }catch(Exception e){
            System.debug('Error message is '+e.getMessage());
        }
    }

    @future
    public static void calculateCase(Set<Id> csIds){
        try{
            Set<Id> accIds = new Set<Id>();
            Map<Id,Account> accMap = new Map<Id,Account>();
            for(Case cs: [SELECT AccountId FROM Case WHERE Id IN: csIds]){
                accIds.add(cs.AccountId);
            }
            List<Case> caseList = [SELECT Id,Origin FROM Case WHERE AccountId IN: accIds];

            for(Case cs:caseList){
                if(!accMap.containsKey(cs.AccountId)){
                    accMap.put(cs.AccountId,new Account(Id=cs.AccountId,Case_Create_Through_Web__c=0,Case_Create_Through_Phone__c=0,Case_Create_Through_Email__c=0));
                }
                    Account acc = accMap.get(cs.AccountId);
                    if(cs.Origin == 'Web'){
                        acc.Case_Create_Through_Web__c++;
                    }else if(cs.Origin == 'Phone'){
                        acc.Case_Create_Through_Phone__c++;
                    }else{
                        acc.Case_Create_Through_Email__c++;
                    }
            }
            if(!accMap.values().isEmpty()){
                update accMap.values();
            }


        }catch(Exception e){
            System.debug('Error message is '+e.getMessage());
        }
    }
}
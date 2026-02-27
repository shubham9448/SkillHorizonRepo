public with sharing class EmployeeTriggerHandler {
    public static void question29(List<Employee__c> empList){
        Set<Id> accIds = new Set<Id>();
        List<Employee__c> empList1 = new List<Employee__c>();
        List<Account> accList = new List<Account>();
        Map<Id,Decimal> countMap = new Map<Id,Decimal>();
        Map<Id,Account> accMap = new Map<Id,Account>();
        for(Employee__c emp:empList){
            if(emp.Account__c != null){
                empList1.add(emp);
                accIds.add(emp.Account__c);
            }else{
                return;
            }
        }
        if(!accIds.isEmpty()){
            //list account related
            accMap.putAll([SELECT Id,Left_Employee_Count__c FROM Account WHERE Id IN: accIds ]);
        }
        
        //count of deleted employee
        for(Employee__c emp:empList1){
            if(countMap.containsKey(emp.Account__c)){
                countMap.put(emp.Account__c,countMap.get(emp.Account__c)+1);
            }else{
                Decimal empCount = accMap.get(emp.Account__c).Left_Employee_Count__c == null ? 0 : accMap.get(emp.Account__c).Left_Employee_Count__c;
                countMap.put(emp.Account__c,empCount+1);
            }
        }
        //insert the delete count in list
        for(Account acc:accMap.Values()){
            accList.add(new Account(Id=acc.Id,Left_Employee_Count__c=countMap.get(acc.Id)));
        }
        //perform dml in order to update account
        if(!accList.isEmpty()){
            update accList;
        }

    }

    //undelete
    public static void question30(List<Employee__c> empList){
        Set<Id> accIds = new Set<Id>();
        List<Employee__c> empList1 = new List<Employee__c>();
        List<Account> accList = new List<Account>();
        Map<Id,Decimal> countMap = new Map<Id,Decimal>();
        Map<Id,Account> accMap = new Map<Id,Account>();
        for(Employee__c emp:empList){
            if(emp.Account__c != null){
                empList1.add(emp);
                accIds.add(emp.Account__c);
            }
        }
        if(!accIds.isEmpty()){
            //list account related
            accMap.putAll([SELECT Id,Left_Employee_Count__c FROM Account WHERE Id IN: accIds ]);
        }
        
        //count of deleted employee
        for(Employee__c emp:empList1){
            if(countMap.containsKey(emp.Account__c)){
                countMap.put(emp.Account__c,countMap.get(emp.Account__c)-1);
            }else{
                countMap.put(emp.Account__c,accMap.get(emp.Account__c).Left_Employee_Count__c-1);
            }
        }

        for(Account acc:accMap.Values()){
            accList.add(new Account(Id=acc.Id,Left_Employee_Count__c=countMap.get(acc.Id),Active__c='Yes'));
        }
        if(!accList.isEmpty()){
            update accList;
        }

    }

    public static void question32(List<Employee__c> empList){
        List<Account> accList = new List<Account>();
        Set<Id> accIds = new Set<Id>();
        for(Employee__c emp:empList){
            if(emp.Account__c != null){
                accIds.add(emp.Account__c);
            }
        }

        if(!accIds.isEmpty()){
            List<AggregateResult> argList = [SELECT Account__c,COUNT(Id) num FROM Employee__c WHERE Account__c IN: accIds GROUP BY Account__c];
        
            for(AggregateResult ar:argList){
                Decimal empCount = (decimal)ar.get('num') > 0 ? (decimal)ar.get('num') : 0;
                accList.add(new Account(Id=(Id)ar.get('Account__c'),Total_Employee_Count__c =empCount));
            }    
        }
        

        if(!accList.isEmpty()){
            update accList;
        }
    }

    public static void question45(List<Employee__c> empList){
        List<Employee__Share> emShareList = new List<Employee__Share>();
        Id suProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1].Id;
        Id usId = [SELECT Id FROM User WHERE ProfileId =: suProfileId LIMIT 1].Id;
        for(Employee__c em:empList){
            emShareList.add(new Employee__Share(UserOrGroupId = usId,ParentId =em.Id,
            RowCause = Schema.Employee__Share.RowCause.Manual));
        }
        if(!emShareList.isEmpty()){
            insert emShareList;
        }
    }
}
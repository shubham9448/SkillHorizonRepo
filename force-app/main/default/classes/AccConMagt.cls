@RestResource(urlMapping='/accountcontactmgt/')
global class AccConMagt {
    @httpGet
    global static AccountWrapper getAccountsApex(){
        Set<Id> accIds = new Set<Id>();
        Map<String , String> accParamMap = RestContext.request.params;

        String accIndustry = accParamMap.get('Industry');

        List<Account> accList = [SELECT Id, Industry, Name, AnnualRevenue FROM Account WHERE AnnualRevenue!=null and Industry=: accIndustry];

        for(Account acc:accList ){
            accIds.add(acc.Id);
        }

        List<Contact> conList = [SELECT Id,FirstName, LastName, Email, AccountId FROM Contact WHERE AccountId In :accIds];

        List<Case> caseList = [SELECT Id, Priority, Subject, AccountId FROM Case WHERE AccountId In :accIds];


        AccountWrapper accWrapper = new AccountWrapper();
        accWrapper.accList = accList;
        accWrapper.conList = conList;
        accWrapper.caseList = caseList;

        return accWrapper;
    }

    global class AccountWrapper{
        global List<Account> accList;
        global List<Contact> conList;
        global List<Case> caseList;    
    }     

}
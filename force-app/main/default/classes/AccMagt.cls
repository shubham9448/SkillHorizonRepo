@RestResource(urlMapping='/accountmgt/')
global class AccMagt {
    /*@httpGet
    global static List<Account> getTopAcc(){		
    List<Account> accList = [SELECT Id, Name,AnnualRevenue FROM Account WHERE AnnualRevenue!=null ];

    return accList;
    }*/
    @httpGet
    global static List<Account> getAccountsApex(){
    Map<String, String> accParamMap = RestContext.request.params;

    String accIndustry = accParamMap.get('Industry');

    List<Account> accList = [SELECT Id, Industry, Name, AnnualRevenue FROM Account WHERE AnnualRevenue!=null and Industry =: accIndustry];

    return accList;
    }


    @httpPost
    global static String createAccount(String accName, String accRating,String accIndustry){
        Account acc = new Account();
        acc.Name = accName;
        acc.Rating = accRating;
        acc.Industry = accIndustry;
        try{
            insert acc;
            return 'Account created successfully';
        }
        catch(Exception ex){
            return ex.getMessage();
        }  
    }

    @httpdelete 
    global static String deleteAccount(){
        Map<String, String> accparamMap = RestContext.request.params;
            String accId = accparamMap.get('accIds');
            
            List<String> accIds = accId.split(',');
        
            List<Account> acclist=[SELECT Id,Name FROM Account WHERE Id IN:accIds];
        if(!acclist.isEmpty()){
            try{
                delete acclist;
                return 'Deleted Successfully';                
            } 
                catch(Exception ex){
                return ex.getMessage();
            }
        }else{
                return 'record not found';
        }
    }
}

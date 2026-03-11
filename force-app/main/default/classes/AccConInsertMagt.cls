@RestResource(urlMapping='/accountconinsertmgt/')
global class AccConInsertMagt {
    global class AccountContactWrapper{
        global Account AccRecord{get;set;}
        global Contact ConRecord{get;set;}    
    }
    @httpPost

    /*global static String insertAccCon(AccountContactWrapper Info){
        Account accRecord = Info.AccRecord;
        Contact conRecord = Info.ConRecord;
        try{
            insert accRecord;
            conRecord.AccountId = accRecord.Id;
            insert conRecord;
            return 'Account and Contact Inserted Successfully';
        }catch(Exception e){
            return 'Error Occured'+e.getMessage();
        }      
    }*/
    global static String insertAccCon(){
         String requestBody = RestContext.request.requestBody.toString();
         System.debug(requestBody);
        

    }

}
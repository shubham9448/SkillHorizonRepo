@RestResource(urlMapping='/integrationpractise/')
global class IntegrationPractiseClass {
    @httpPost
    /*global static Account getAccount(){
        Account acc = new Account();
        acc.Name = 'Tech Solution';
        acc.Active__c = 'Yes';
        acc.Industry = 'Technology';
        acc.Rating = 'Hot';
        try{
            insert acc;
            return acc;
        }catch(Exception e){
            System.debug(e.getMessage());
            return null;
        }
    }*/

    global static string insertAccount(){
        String requestBody = RestContext.request.requestBody.toString();
        System.debug(requestBody);
        Account acc = (Account)JSON.deserialize(requestBody, Account.class);
        try{
            insert acc;
            return 'Account Inserted Successfully';
        }catch(Exception e){
            return 'Error Occured'+e.getMessage();
        }
    }
}
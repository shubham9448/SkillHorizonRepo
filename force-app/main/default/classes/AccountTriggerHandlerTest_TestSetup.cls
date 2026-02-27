@isTest
private class AccountTriggerHandlerTest_TestSetup {
    
	@testSetup
    private static void testData(){
        List<Account> accList = new List<Account>();
        for(Integer i=1;i<=5;i++){
            Account acc = new Account();
            acc.Name = 'Test';
            acc.Industry = 'Media';
            accList.add(acc);
        }
        
        insert accList;
    }
    
   	@isTest
    private static void question12Test_Insert(){
        List<Account> accList = [SELECT Rating FROM Account WHERE Industry = 'Media'];
        for(Account acc:accList){
        	System.assertEquals('Hot', acc.Rating, 'Media account not created');    
        }
    }
}
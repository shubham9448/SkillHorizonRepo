@isTest
private class AccountTriggerHandlerTest {

    @isTest //question1 & question 12
    private static void question12Test_Insert(){
        Test.startTest();
        DataFactory.AccountData(1, true);
        Test.stopTest();

        List<Account> accList = [
            SELECT Rating FROM Account WHERE Industry = 'Media'
        ];
        for(Account acc:accList){
        	System.assertEquals('Hot', acc.Rating, 'Media account not created');    
        }
        
    }
    
    @isTest //question1 & question 12
    private static void question12Test_Update(){
        Test.startTest();
        DataFactory.AccountData(1, true);
        List<Account> accList1 = [
            SELECT Rating,Industry FROM Account WHERE Industry = 'Electronics'
        ];
        
        for(Account acc:accList1){
            acc.Industry = 'Media';
        } 
        update accList1;
        Test.stopTest();
        List<Account> accList = [SELECT Id,Rating FROM Account WHERE Id IN:accList1];
        for(Account acc: accList){
        	System.assertEquals('Hot', acc.Rating);    
        }
        
    }
    
    @isTest
    private static void question5Test(){
        Test.startTest();
        DataFactory.AccountData(1, true);
        Test.stopTest();
        
        List<Contact> conList = [SELECT Id FROM Contact];
        System.assertEquals(2,conList.size());
    }
    
    @isTest
    private static void question6Test(){
        Test.startTest();
        DataFactory.AccountData(1, true);
        Test.stopTest();
        
        List<Opportunity> oppList = [SELECT Id FROM Opportunity];
        System.assertEquals(1,oppList.size());
    }
    

    @isTest
    private static void question11Test_BeforeInsert(){
        
        Test.startTest();  
        DataFactory.AccountData(1, true);
        Test.stopTest();

        List<Account> accListTrue = [SELECT Name,ShippingCountryCode,ShippingCity,ShippingCountry,ShippingState,ShippingStreet,Apex_copy_billing_to_shipping__c FROM Account WHERE Apex_copy_billing_to_shipping__c = true LIMIT 1];
        System.assertEquals(1, accListTrue.size(), 'True account not found');
		Account accTrue = accListTrue[0];
        System.assertEquals('IN', accTrue.ShippingCountryCode);
        System.assertEquals('Jaipur', accTrue.ShippingCity);
        System.assertEquals('India', accTrue.ShippingCountry);
        System.assertEquals('Rajasthan', accTrue.ShippingState);
        System.assertEquals('Jagathpura fatak', accTrue.ShippingStreet);

        List<Account> accListFalse = [SELECT Name,ShippingCountryCode,ShippingCity,ShippingCountry,ShippingState,ShippingStreet,Apex_copy_billing_to_shipping__c FROM Account WHERE Apex_copy_billing_to_shipping__c = false LIMIT 1];
		System.assertEquals(1, accListFalse.size(), 'True account not found');
        Account accFalse = accListFalse[0];
        System.assertEquals(null, accFalse.ShippingCountryCode);
        System.assertEquals(null, accFalse.ShippingCity);
        System.assertEquals(null, accFalse.ShippingCountry);
        System.assertEquals(null, accFalse.ShippingState);
        System.assertEquals(null, accFalse.ShippingStreet);    
    }
}
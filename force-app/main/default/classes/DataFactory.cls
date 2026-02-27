public with sharing class DataFactory {
    public static void AccountData(Integer n,Boolean inp){
        List<Account> accList = new List<Account>();
        for(Integer i=1;i<=n;i++){
            Account acc = new Account();
            acc.Name= 'Demo Test '+i;
            acc.Active__c = 'Yes';
            acc.Industry = 'Media';
            acc.Apex_copy_billing_to_shipping__c = true;
            acc.BillingCountryCode = 'IN';
        	acc.BillingCity= 'Jaipur';
        	acc.BillingCountry= 'India';
        	acc.BillingState = 'Rajasthan';
        	acc.BillingStreet = 'Jagathpura fatak';
            accList.add(acc);
            
            Account acc1 = new Account();
            acc1.Name = 'Test Demo '+i;
        	acc1.Apex_copy_billing_to_shipping__c = false;
            acc1.Industry= 'Electronics';
        	acc1.BillingCountryCode = 'IN';
        	acc1.BillingCity= 'Jodpur';
        	acc1.BillingCountry= 'India';
        	acc1.BillingState = 'Rajasthan';
        	acc1.BillingStreet = 'Jagathpura 101 fatak';
        	accList.add(acc1);
        }
        if(!accList.isEmpty() && inp){
            insert accList;
        }
    }
}
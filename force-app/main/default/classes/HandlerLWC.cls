public class HandlerLWC {
    @AuraEnabled(cacheable = true)
    public static List<Position__c> featchPosition(){
        return [SELECT Id,Name,Status__c,Max_pay__c,Min_pay__c,Location__c FROM Position__c WHERE Status__c = 'New Position'];
    }
}

public with sharing class V2MOMTriggerHandler {
    public static void createFeedbackRecord(List<V2MOM__c> v2List){
        List<Feedback__c> fbList = new List<Feedback__c>();
        Date todayDate = Date.Today();
        Integer currentYear = todayDate.Year();
        String yearString = String.valueOf(currentYear);
        for(V2MOM__c v:v2List){
            if(v.Resource__c != null){
                fbList.add(new Feedback__c(V2MOM__c=v.Id,Year__c=yearString,Overall_Feedback__c='Feedback by HR'));
                fbList.add(new Feedback__c(V2MOM__c=v.Id,Year__c=yearString,Overall_Feedback__c='Feedback by Manager'));
            }   
        }
        if(!fbList.isEmpty()){
            insert fbList;
        }

    }
}
public with sharing class ResourceTriggerHandler {
    
    public static void createAppraisalV2MOM(List<Resource__c> rList){

        List<Appraisal__c> apprList = new List<Appraisal__c>();
        List<V2MOM__c> v2List = new List<V2MOM__c>();
        for(Resource__c r:rList){
            apprList.add(new Appraisal__c(Resource__c = r.Id,Status__c = 'Draft',Re_Reviewed__c= true));
            date dateToday = date.today();
            String year = dateToday.year().toString();
            v2List.add(new V2MOM__c(Resource__c= r.Id,Status__c='New',Year__c=year,Manager_s_Email__c='Shubham245@gmail.com'));
        }

        if(!apprList.isEmpty() || !v2List.isEmpty()){
            insert apprList;
            insert v2List;
        }
    }
}
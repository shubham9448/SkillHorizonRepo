trigger ResourceTrigger on Resource__c (after insert) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            ResourceTriggerHandler.createAppraisalV2MOM(Trigger.new);
        }
    }
}
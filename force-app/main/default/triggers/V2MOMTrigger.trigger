trigger V2MOMTrigger on V2MOM__c (after insert) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            V2MOMTriggerHandler.createFeedbackRecord(Trigger.new);
        }
    }
}
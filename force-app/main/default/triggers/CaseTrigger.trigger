trigger CaseTrigger on Case (before insert,after insert) {
if(Trigger.isAfter){
    if(Trigger.isInsert){
        CaseTriggerHandler.question7(Trigger.new);
        CaseTriggerHandler.question34(Trigger.new);
        CaseTriggerHandler.webCase(Trigger.new);
    }
}
}
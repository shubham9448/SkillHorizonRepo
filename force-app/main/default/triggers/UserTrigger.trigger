trigger UserTrigger on User (after insert) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            UserTriggerHandler.question43(Trigger.new);
        }
    }

}
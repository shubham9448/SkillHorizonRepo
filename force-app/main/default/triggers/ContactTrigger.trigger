trigger ContactTrigger on Contact (before insert,after insert,after update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            //ContactTriggerHandler.question44(Trigger.new);
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            //ContactTriggerHandler.createRelateAccount(Trigger.new);
            ContactTriggerHandler.question33(Trigger.new);
        }else if(Trigger.isUpdate){
            ContactTriggerHandler.updateAccount(Trigger.new,Trigger.oldMap);
        }
    }	
}
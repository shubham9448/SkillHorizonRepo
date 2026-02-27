trigger EmployeeTrigger on Employee__c (after delete,after insert,after undelete) {
    if(Trigger.isAfter){
        if(Trigger.isdelete){
            EmployeeTriggerHandler.question29(Trigger.old);
            EmployeeTriggerHandler.question32(Trigger.old);
        }else if(Trigger.isUndelete){
            EmployeeTriggerHandler.question30(Trigger.new);
            EmployeeTriggerHandler.question32(Trigger.new);
        }else if(Trigger.isInsert){
            EmployeeTriggerHandler.question32(Trigger.new);
        }
    }
}
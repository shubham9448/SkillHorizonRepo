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
            Set<Id> accIdSet = new Set<Id>();
            for(Contact con:Trigger.new){
                if(con.AccountId != null){
                    accIdSet.add(con.AccountId);
                }
            }
            if(accIdSet.size() > 0){
                ContactTriggerHandler.futureCountNumberOfContact(accIdSet);
            }

            BatchApex1 ba = new BatchApex1();
            Database.executeBatch(ba);
        }else if(Trigger.isUpdate){
            ContactTriggerHandler.updateAccount(Trigger.new,Trigger.oldMap);
        }
    }	
}
trigger AccountTrigger on Account (before insert,before update,before delete,after insert,after update,after delete) {
    //System.debug('Before Trigger Event Execution');
    
    /*for(Account acc: trigger.new){
        acc.description = 'Before Trigger Event Executed';
    }*/
   
    if(Trigger.isBefore){
        if(Trigger.isInsert){
        	//AccountTriggerHandler.question1(Trigger.new); 
            //AccountTriggerHandler.question3(Trigger.new);  
            AccountTriggerHandler.question11(Trigger.new,null);   
            AccountTriggerHandler.question12(Trigger.new,null);
        }else if(Trigger.isUpdate){
            AccountTriggerHandler.question10(Trigger.new,Trigger.oldMap);
            AccountTriggerHandler.question11(Trigger.new,Trigger.oldMap);
            AccountTriggerHandler.question12(Trigger.new,Trigger.oldMap);
            //AccountTriggerHandler.question21(Trigger.new,Trigger.oldMap);
        }else if(Trigger.isDelete){
            //AccountTriggerHandler.question20(Trigger.old);
            AccountTriggerHandler.question25(Trigger.old);
            AccountTriggerHandler.question27(Trigger.oldMap);
            AccountTriggerHandler.question28(Trigger.oldMap);
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            AccountTriggerHandler.question5(Trigger.new);
            //AccountTriggerHandler.deleteRelatedContact(Trigger.old);
            AccountTriggerHandler.question6(Trigger.new);
            AccountTriggerHandler.question9(Trigger.new);
            //AccountTriggerHandler.recursionDemo(Trigger.new);
        }else if(Trigger.isUpdate){
            //AccountTriggerHandler.question14(Trigger.new,Trigger.oldMap);
            AccountTriggerHandler.question15(Trigger.new,Trigger.oldMap);
            //AccountTriggerHandler.question16(Trigger.new,Trigger.oldMap);
            AccountTriggerHandler.question17(Trigger.new,Trigger.oldMap);
            AccountTriggerHandler.question19(Trigger.new,Trigger.oldMap);
            AccountTriggerHandler.callContactAndUserUpdate(Trigger.new,Trigger.oldMap);
            if(Util.isExecute){
                Util.isExecute = false;
                AccountTriggerHandler.question40(Trigger.new,Trigger.oldMap);
                
            }
            AccountTriggerHandler.question42(Trigger.new,Trigger.oldMap);      
            //AccountTriggerHandler.question41(Trigger.new,Trigger.oldMap);
        }
    }

}
trigger OpportunityTrigger on Opportunity (before insert,before update,after insert,after update,after delete,after undelete) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
        	OpportunityTriggerHandler.question2(Trigger.new);  
            OpportunityTriggerHandler.question22(Trigger.new);
            OpportunityTriggerHandler.question47(Trigger.new,null);
              
        }else if(Trigger.isUpdate){
            OpportunityTriggerHandler.question13(Trigger.new,Trigger.oldMap);
            //OpportunityTriggerHandler.question24(Trigger.new);
            OpportunityTriggerHandler.question26(Trigger.new);
            OpportunityTriggerHandler.question47(Trigger.new,Trigger.oldMap);
            
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            OpportunityTriggerHandler.maxOpportunity(Trigger.new);
            OpportunityTriggerHandler.question8(Trigger.new);
            OpportunityTriggerHandler.createProject(Trigger.new,null); //Assignment 2 Q1
            //OpportunityTriggerHandler.question35(Trigger.new,null);
            OpportunityTriggerHandler.question36(Trigger.new,null);

        }else if(Trigger.isUpdate){
            OpportunityTriggerHandler.createProject(Trigger.new,Trigger.oldMap); //Assignment 2 Q1
            OpportunityTriggerHandler.question18(Trigger.new,Trigger.oldMap);
            if(Util.isExecute){
                Util.isExecute=false;
                OpportunityTriggerHandler.question39(Trigger.new,Trigger.oldMap);
            }
            //OpportunityTriggerHandler.question35(Trigger.new,Trigger.oldMap);
            OpportunityTriggerHandler.question40(Trigger.new,Trigger.oldMap);
        }else if(Trigger.isDelete){
           // OpportunityTriggerHandler.question35(Trigger.old,null);
        }else if(Trigger.isUndelete){
            //OpportunityTriggerHandler.question35(Trigger.new,null);
        }
    }
}
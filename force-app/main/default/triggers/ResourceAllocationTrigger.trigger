trigger ResourceAllocationTrigger on Resource_Allocation__c (after insert) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            //ResourceAllocationTriggerHandler.calculateRevenueAndCost(Trigger.newMap);
        }
    }
}
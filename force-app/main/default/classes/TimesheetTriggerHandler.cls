public with sharing class TimesheetTriggerHandler {
    public static void updateTimesheetRevenueCost(List<Timesheet__c> tsList,Map<Id,Timesheet__c> tsOldMap){
        Set<Id> pjIds = new Set<Id>();
        for(Timesheet__c ts:tsList){
            String oldStatus = tsOldMap.get(ts.Id).Status__c;
            if(ts.status__c != oldStatus && ts.status__c == 'Approved'){
                pjIds.add(ts.Project__c);
            }
        }

        
    }        
}
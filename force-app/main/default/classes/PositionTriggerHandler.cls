public with sharing class PositionTriggerHandler{
    public static void updateMinMax(List<Position__c> posList){
        for(Position__c pos:posList){
            if(pos.Open_Date__c == null || pos.Min_Pay__c == null || pos.Max_Pay__c == null){
                pos.Open_Date__c = System.TODAY();
                pos.Min_Pay__c = 10000;
                pos.Max_Pay__c = 15000;
            }
        }

    }
}
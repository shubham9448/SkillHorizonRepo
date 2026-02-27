@isTest
public with sharing class OpportunityTriggerHandlerTest {
    @testSetup
    public static void createOpp(){
        List<Opportunity> oppList = new List<Opportunity>();
        oppList.add(new Opportunity(Name= 'Test opp',StageName= 'Closed Won',CloseDate = System.TODAY()));
        oppList.add(new Opportunity(Name= 'Test oppo',StageName= 'Prospecting',CloseDate = System.TODAY()));
        if(!oppList.isEmpty()){
            insert oppList;
        }
    }

    @isTest
    public static void createProjectTest(){
        Set<Id> oppId = new Set<Id>();
        List<Opportunity> oppList = [SELECT Id,Name,StageName FROM Opportunity];
        Map<Id,Opportunity> oppMap = new Map<Id,Opportunity>();
        oppMap.putAll(oppList);
        for(Opportunity opp:oppList){
            if(opp.StageName != 'Closed Won'){
                opp.StageName = 'Closed Won';
            }
        }
        test.startTest();
        update oppList;     
        OpportunityTriggerHandler.createProject(oppList,oppMap);
        test.stopTest();

        for(Opportunity o:oppList){
            oppId.add(o.Id);
        }

        Integer proCount = [SELECT COUNT() FROM Project__c WHERE Opportunity__c IN: oppId];
        System.assertEquals(2, proCount,'Count is not proper');
    }
}
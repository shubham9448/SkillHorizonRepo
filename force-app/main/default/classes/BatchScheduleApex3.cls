public class BatchScheduleApex3 implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id,LeadSource FROM Opportunity WHERE LeadSource = null]);
    }
    public void execute(Database.BatchableContext bc,List<Opportunity> oppList){
        List<Opportunity> newOppList = new List<Opportunity>();
        for(Opportunity opp:oppList){
            opp.LeadSource = 'Web';
            newOppList.add(opp);
        }
        if(!newOppList.isEmpty()){
            update newOppList;
        }
    }
    public void finish(Database.BatchableContext bc){
        System.debug('BatchScheduleApex3 was solved successfully');
    }
}
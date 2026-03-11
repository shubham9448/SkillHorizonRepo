public class BatchScheduleApex4 implements Database.batchable<sObject>,Database.Stateful{
    public static Integer recordCount=0;
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id,StageName FROM Opportunity WHERE CreatedDate = TODAY]);
    }
    public void execute(Database.BatchableContext bc,List<Opportunity> oppList){
        List<Opportunity> oppListNew = new List<Opportunity>();
        for(Opportunity opp:oppList){
            opp.StageName = 'Prospecting';
            oppListNew.add(opp);
            recordCount++;
        }
        if(!oppListNew.isEmpty()){
            update oppListNew;
        }
    }
    public void finish(Database.BatchableContext bc){
        System.debug('BatchScheduleApex4 has run '+recordCount+' successful records ');
    }
}
public class Qestion6BatchApex implements Database.Batchable<sObject>,Database.Stateful{
    public Integer recordSuccessProcessed = 0;
    public Integer recordFailedProcessed = 0;
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id,priority FROM Case WHERE priority = null');
    }
    public void execute(Database.BatchableContext bc,List<Case> csList){
        if(!csList.isEmpty()){
            for(Case cs:csList){
                cs.Priority = 'Low';
            }
            List<Database.SaveResult> results = Database.update(csList,false);
            for(Database.SaveResult sr:results){
                if(sr.isSuccess()){
                    recordSuccessProcessed++;
                }else{
                    recordFailedProcessed++;
                }
            }
        }
        
    }
    public void finish(Database.BatchableContext bc){  
        System.debug('The number of successful record are '+recordSuccessProcessed);
        System.debug('The number of failed record are '+recordFailedProcessed);
    }
}
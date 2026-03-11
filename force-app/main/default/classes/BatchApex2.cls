public class BatchApex2 implements Database.Batchable<sObject>,Database.stateful{
    public static Integer recordSuccessProcessed = 0;
    public static Integer recordFailedProcessed = 0;    
    public Database.queryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id,Priority FROM Case WHERE Priority = null]);
    }
    public void execute(Database.BatchableContext bc,List<Case> csList){
        if(!csList.isEmpty()){
            List<Case> csNewList = new List<Case>();
            for(Case cs:csList){
                cs.Priority = 'Low';
                csNewList.add(cs);
            }
            if(!csNewList.isEmpty()){
                Database.SaveResult[] results = Database.update(csNewList,false);  
                for(Database.saveResult sr:results){
                    if(sr.isSuccess()){
                        recordSuccessProcessed++;
                    }else{
                        recordFailedProcessed++;
                    }
                } 
            }
        }
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Total Records Success Processed '+recordSuccessProcessed);
        System.debug('Total Records Failed Processed '+recordFailedProcessed);
    }
}
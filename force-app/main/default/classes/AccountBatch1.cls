public class AccountBatch1 implements Database.Batchable<sObject>,Database.stateful{
    public Integer recordsProcessed = 0;
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id,Name,Email__c FROM Account WHERE AnnualRevenue > 500000]);
    }
    public void execute(Database.BatchableContext bc,List<Account> accList){
        List<Messaging.SingleEmailMessage> msList = new List<Messaging.SingleEmailMessage>();
        for(Account acc: accList){
            if(acc.Email__c != null){
                 Messaging.SingleEmailMessage ms = new Messaging.SingleEmailMessage();
                ms.setSubject('Welcome to IDFC Bank');
                ms.setPlainTextBody('Dear '+acc.Name +'\n'+'Thank You for becoming a customer of IDFC Bank.'+
                                'Your are our first priopirty as we are Customer First Bank.You belong to Elite Group');
                ms.setToAddresses(new string[] {acc.Email__c});
                recordsProcessed++;
                msList.add(ms);
            }
           
        }

        if(!msList.isEmpty()){
            Messaging.sendEmail(msList);
        }
    }
    public void finish(Database.BatchableContext bc){
        System.debug('The Batch has processed '+recordsProcessed +'Email');
    }
}
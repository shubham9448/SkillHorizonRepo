public class BatchApex5 implements Database.Batchable<sObject>,Database.Stateful{
    public static Decimal LeadAnnualRevenue = 0;
    public static Integer leadRecord = 0;
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id,AnnualRevenue FROM Lead WHERE AnnualRevenue != null]);
    }
    public void execute(Database.BatchableContext bc,List<Lead> ldList){
        for(Lead ld:ldList){
            LeadAnnualRevenue+=ld.AnnualRevenue;
            leadRecord++;
        }
    }
    public void finish(Database.BatchableContext bc){
        AsyncApexJob job = [SELECT CreatedById FROM AsyncApexJob WHERE Id = :bc.getJobId()];
        Id ownerId = job.CreatedById;
        Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
        emailMsg.setSubject('Welcome to Salesforce Email');
        emailMsg.setPlainTextBody('Welcome to salesforce ecoSystem. Total lead revenue is'+LeadAnnualRevenue+' And total lead records are '+leadRecord);
        emailMsg.setTargetObjectId(ownerId);

        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{emailMsg});
    }
}
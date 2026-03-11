public class BatchApex1 implements Database.Batchable<sObject>, Database.Stateful {
    public static Integer recordProcessed = 0;
    public Database.QueryLocator start( Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id,Name,BillingCountryCode,BillingCountry,BillingState,BillingStreet,(SELECT Id,MailingCountry,MailingCountryCode,MailingState,MailingStreet FROM Contacts) FROM Account');
    }
    public void execute(Database.BatchableContext bc,List<Account> accList){
        List<Contact> conList = new List<Contact>();
        for(Account acc:accList){
            for(Contact con:acc.Contacts){
                con.MailingCountryCode = acc.BillingCountryCode;
                con.MailingCountry = acc.BillingCountry;
                con.MailingState = acc.BillingState;
                con.MailingStreet = acc.BillingStreet;
                conList.add(con);
                recordProcessed++;
            }
        }
        if(!conList.isEmpty()){
            update conList;
        }
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Total Records Processed : '+recordProcessed);
    }
}
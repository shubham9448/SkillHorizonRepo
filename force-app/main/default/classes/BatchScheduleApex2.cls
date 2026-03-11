public class BatchScheduleApex2 implements Database.Batchable<sObject>,Database.Stateful{
    public static Integer conuntRecord=0;
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT BillingStateCode,BillingCountry,BillingCountryCode,BillingState,BillingCity,(SELECT MailingCountry,MailingCountryCode,MailingState,MailingCity,MailingStateCode FROM Contacts) FROM Account WHERE Id IN (SELECT AccountId FROM Contact WHERE AccountId != NUll)]);
    }
    public void execute(Database.BatchableContext bc,List<Account> accList){
        List<Contact> conList = new List<Contact>();
        for(Account acc:accList){
            for(Contact con:acc.Contacts){
                con.MailingCity= acc.BillingCity;
                con.MailingCountry = acc.BillingCountry;
                con.MailingCountryCode = acc.BillingCountryCode;
                con.MailingState = acc.BillingState;
                con.MailingStateCode = acc.BillingStateCode;
                conList.add(con);
                conuntRecord++;
            }
        }
        if(!conList.isEmpty()){
            update conList;
        }
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Total Records Processed are '+conuntRecord);
    }
}
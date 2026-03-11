public class BatchApex3 implements Database.Batchable<sObject>,Database.Stateful {
    public static Decimal RevenueLastYear = 0;
    public static Decimal RevenueThisYear = 0;
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id,CreatedDate,isClosed,Amount FROM Opportunity WHERE isClosed = true AND (CreatedDate = THIS_YEAR OR CreatedDate = LAST_YEAR)]);
    }

    public void execute(Database.BatchableContext bc,List<Opportunity> oppList){
        if(!oppList.isEmpty()){
            for(Opportunity opp:oppList){
                Date today = Date.TODAY();
                Integer createdDate = opp.CreatedDate.Year();
                if( createdDate == today.Year()){
                    RevenueThisYear = opp.Amount;
                }else{
                    RevenueLastYear = opp.Amount;
                }
            }
        }
    }
    public void finish(Database.BatchableContext bc){
        System.debug('RevenueLastYear '+RevenueLastYear);
        System.debug('RevenueThisYear '+RevenueThisYear);
    }
}
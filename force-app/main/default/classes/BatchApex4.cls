public class BatchApex4 implements Database.Batchable<sObject>,Database.stateful{
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT AccountId,IsClosed,CreatedDate,Amount FROM Opportunity WHERE (CreatedDate = THIS_YEAR OR CreatedDate = LAST_YEAR) AND IsClosed = true AND AccountId != null]);
    }
    public void execute(Database.BatchableContext bc,List<Opportunity> oppList){
        List<Account> accList = new List<Account>();
        Set<Id> accIds = new Set<Id>();
        Map<Id,Decimal> closedRevenueThisYear = new Map<Id,Decimal>();
        Map<Id,Decimal> closedRevenueLastYear = new Map<Id,Decimal>();
        if(!oppList.isEmpty()){
            for(Opportunity opp:oppList){
                accIds.add(opp.AccountId);
                Integer today = System.Today().Year();
                Integer oppCreatedDate = opp.CreatedDate.Year();
                if(oppCreatedDate == today){
                    Decimal amt = opp.Amount == null ? 0:opp.Amount;
                    if(closedRevenueThisYear.containsKey(opp.AccountId)){
                        closedRevenueThisYear.put(opp.AccountId,(Decimal)closedRevenueThisYear.get(opp.AccountId)+amt);
                    }else{
                        closedRevenueThisYear.put(opp.AccountId,amt);
                    }
                }else{
                    Decimal amt = opp.Amount == null ? 0:opp.Amount;
                    if(closedRevenueLastYear.containsKey(opp.AccountId)){
                        closedRevenueLastYear.put(opp.AccountId,(Decimal)closedRevenueLastYear.get(opp.AccountId)+amt);
                    }else{
                        closedRevenueLastYear.put(opp.AccountId,amt);
                    }
                }      
            }
        }
        for(Id i:accIds){
            accList.add(new Account(Id=i,Total_Closed_Revenue_Last_Year__c=closedRevenueLastYear.get(i),Total_Closed_Revenue_This_Year__c=closedRevenueThisYear.get(i)));
        }

        if(!accList.isEmpty()){
            update(accList);
        }
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Batch was performed sucessfully');
    }
}
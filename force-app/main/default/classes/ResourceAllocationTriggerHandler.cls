public with sharing class ResourceAllocationTriggerHandler {
    public static void calculateRevenueAndCost(Map<Id,Resource_Allocation__c> raMap){
        Map<Id,Project__c> proMap = new Map<Id,Project__c>();

        List<Resource_Allocation__c> newRaList = [SELECT Project__c,Project__r.Estimate_Revenue__c,Project__r.Estimate_Cost__c,Project__r.Start_Date__c,Project__r.End_Date__c,Project__r.Billing_Per_Hour__c,
                                                Resource__r.Cost_Per_Hour__c FROM Resource_Allocation__c WHERE Id IN: raMap.KeySet()];

        for(Resource_Allocation__c r:newRaList){

            Integer workingDay = r.Project__r.Start_Date__c.daysBetween(r.Project__r.End_Date__c) ;
            System.debug(workingDay);
            Decimal estimateRevenue = (Decimal)(r.Project__r.Billing_Per_Hour__c*(8*workingDay));
            System.debug(estimateRevenue);
            Decimal estimateCost = (Decimal)(r.Resource__r.Cost_Per_Hour__c*(8*workingDay));
            System.debug(estimateCost);

            if(proMap.containsKey(r.Project__c)){
                //proMap.get(r.Project__c).Estimate_Revenue__c += estimateRevenue;
                proMap.get(r.Project__c).Estimate_Cost__c += estimateCost;
            }else{
                Decimal baseCost = r.Project__r.Estimate_Cost__c == null ? 0 : r.Project__r.Estimate_Cost__c;
                proMap.put(r.Project__c,new Project__c(Id=r.Project__c,Estimate_Revenue__c=estimateRevenue,Estimate_Cost__c=baseCost + estimateCost));
            }
        }

        if(!proMap.isEmpty()){
            update proMap.values();
        }

    }
}
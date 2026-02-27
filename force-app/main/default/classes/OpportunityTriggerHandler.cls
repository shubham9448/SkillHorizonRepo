public class OpportunityTriggerHandler {
    public static void maxOpportunity(List<Opportunity> oppList){
        List<Account> accList = new List<Account>();
        Map<Id,Decimal> accMap = new Map<Id,Decimal>();
        Set<Id> accIdSet = new Set<Id>();
        
        for(Opportunity opp:oppList){
            if(opp.AccountId != null){
            	accIdSet.add(opp.AccountId);    
            }     
        }
        
        List<AggregateResult> argList = [SELECT AccountId,Max(Amount) max FROM Opportunity
                                         WHERE AccountId IN:accIdSet GROUP BY AccountId];
        for(AggregateResult ar:argList){
            accMap.put((Id)ar.get('AccountId'),(Decimal)ar.get('max'));
        }
        
        for(Id i:accIdSet){
            accList.add(new Account(Id=i,Maximum_Opportunity_Amount__c=accMap.get(i)));
        }
        
        if(!accList.isEmpty()){
        	update accList;    
        }        
    }
        
    public static void question2(List<Opportunity> oppList){
        for(Opportunity opp:oppList){
            opp.Description = (opp.Amount != null && opp.Amount > 100000) ? 'Hot Opportunity' : '';
        }        
    }

    public static void question8(List<Opportunity> oppList){
        List<Account> accList = new List<Account>();
        for(Opportunity opp:oppList){
            if(opp.AccountId != null && opp.Amount != null){
                accList.add(new Account(Id=opp.AccountId,Recent_Opportunity_Amount__c= opp.Amount));   
            }
        }
        if(!accList.isEmpty()){
            upsert accList;
        }
    }

    public static void createProject(List<Opportunity> oppList,Map<Id,Opportunity> oppMap){
        List<Project__c> proList = new List<Project__c>();
        for(Opportunity opp:oppList){
            if(opp.StageName == 'Closed Won' && oppMap == null){
                proList.add(new Project__c(Name= opp.Name,Opportunity__c = opp.Id,Status__c = 'New',Start_Date__c = System.TODAY()));        
            }else if(oppMap != null){
                string oldStage = oppMap.get(opp.Id).StageName;
                if(oldStage != opp.StageName && opp.StageName == 'Closed Won'){
                proList.add(new Project__c(Name= opp.Name,Opportunity__c = opp.Id,Status__c = 'New',Start_Date__c = System.TODAY()));    
                }
            }
        }
        if(!proList.isEmpty()){
            Insert proList;
        }
    }

    public static void question13(List<Opportunity> oppList,Map<Id,Opportunity> oppMap){
        for(Opportunity opp:oppList){
            String oldStageName = oppMap.get(opp.Id).StageName;
            if(opp.StageName != oldStageName){
                if(opp.StageName == 'Closed Lost' & opp.StageName == 'Closed Won'){
                    opp.Description = 'Opp is '+opp.StageName;
                }else{
                    opp.Description = 'Opp is open';
                }
            }
        }
    }

    public static void question18(List<Opportunity> oppList,Map<Id,Opportunity> oppMap){
        List<Task> tsList = new List<Task>();
        for(Opportunity opp:oppList){
            if(opp.StageName != oppMap.get(opp.Id).StageName){
                tsList.add(new Task(Subject = opp.Name+' Task Created',OwnerId = UserInfo.getUserId(),WhatId=opp.Id,Status='In Progress',ActivityDate=System.TODAY()+3));
            }
        }
        if(!tsList.isEmpty()){
            insert tsList;
        }
    }

    public static void question22(List<Opportunity> oppList){
        for(Opportunity opp:oppList){
            if(opp.Amount == null){
                opp.addError(Label.Error_Message_Question_22);
            }
        }
    }

    public static void question24(List<Opportunity> oppList){
        for(Opportunity opp:oppList){
            if(opp.StageName == 'Closed Lost' && opp.Closed_Lost_Reason__c == null){
                opp.addError('Please populate close date reason');
            }
        }
    }

    public static void question26(List<Opportunity> oppList){
        Id SysAdmin = [SELECT Id FROM Profile WHERE Name='System Administrator' LIMIT 1].Id;
        for(Opportunity opp:oppList){
            if(opp.IsClosed && UserInfo.getProfileId() != SysAdmin){
                opp.addError('Only System Admin Can Delete Closed Records');
            }
        }
    }

    //insert,delete,undelete & update
    public static void question35(List<Opportunity> oppList,Map<Id,Opportunity> oppOldMap){
        List<Account> accList = new List<Account>();
        Set<Id> accIds = new Set<Id>();
        for(Opportunity opp:oppList){
            if((oppOldMap != null && opp.AccountId != null && opp.Amount != oppOldMap.get(opp.Id).Amount)||(oppOldMap == null && opp.AccountId != null && opp.Amount != null)){
                accIds.add(opp.AccountId);
        }
            
        List<Account> accList1 = [SELECT Id,AnnualRevenue,(SELECT Amount FROM Opportunities) FROM Account WHERE Id IN:accIds];
            for(Account acc:accList1){
                Decimal TotalAmount = 0;
                    for(Opportunity opp1:acc.Opportunities){
                    TotalAmount+=opp1.Amount;
                    }
                accList.add(new Account(Id=acc.Id,AnnualRevenue=TotalAmount));
            }
        
        if(!accList.isEmpty()){
            update accList;
        }
    }
    }

    public static void question36(List<Opportunity> oppList,Map<Id,Opportunity> oppOldMap){
        Map<Id,Opportunity> oppMap = new Map<Id,Opportunity>();
        Map<Id,Decimal> countAccountMap = new Map<Id,Decimal>();
        Set<Id> accIds = new Set<Id>();
        List<Account> accList = new List<Account>();
        for(Opportunity opp:oppList){
            if(oppOldMap== null && opp.AccountId != null){
                accIds.add(opp.AccountId);
                oppMap.put(opp.Id,opp);
            }else if(opp.AccountId != null && opp.Amount != oppOldMap.get(opp.Id).Amount){
                accIds.add(opp.AccountId);
                oppMap.put(opp.Id,opp);
            }
        }

        for(Opportunity opp:oppMap.Values()){
            if(countAccountMap.containsKey(opp.Id)){
                Decimal add = (Decimal)countAccountMap.get(opp.AccountId)+opp.Amount;
                countAccountMap.put((Id)opp.AccountId,add);
            }else{
                countAccountMap.put((Id)opp.AccountId,(Decimal)oppMap.get(opp.Id).Amount);
            }
        }
        
        for(Id i:accIds){
            accList.add(new Account(Id=i,AnnualRevenue=countAccountMap.get(i)));
        }

        if(!accList.isEmpty()){
            Database.update(accList,false);
        }
    }

    public static void question40(List<Opportunity> oppList,Map<Id,Opportunity> oppOldMap){
        Set<Id> accIds = new Set<Id>();
        for(Opportunity opp:oppList){
            if(opp.StageName == 'Closed Lost' && opp.AccountId != null){
                accIds.add(opp.AccountId);
            }
        }

        List<Account> accList = [SELECT Id,Active__c FROM Account WHERE Id IN: accIds];

        for(Account acc:accList){
            acc.Active__c = 'No';
        }

        if(!accList.isEmpty()){
            update accList;
        }
    }


    public static void question47(List<Opportunity> oppList,Map<Id,Opportunity> oppOldMap){
        List<Opportunity> updateOppList = new List<Opportunity>();
        
        for(Opportunity opp:oppList){
            if(oppOldMap == null){
                if(opp.Amount != null){
                    updateOppList.add(opp);
                }
            }else{
                Decimal oldValue = oppOldMap.containsKey(opp.Id) ? oppOldMap.get(opp.Id).Amount : 0;
                if(opp.Amount != null && opp.Amount != oldValue){
                    updateOppList.add(opp);
                }
            }
            
        }

        List<Discount_Tiers__c> dtList = [SELECT Customer_Tier__c,Discount_Percentage__c,Minimum_Amount__c FROM Discount_Tiers__c ORDER BY Minimum_Amount__c ASC];
        
        for(Opportunity opp: updateOppList ){
            Decimal discountPercentage = 0;
            for(Discount_Tiers__c dt:dtList){
                if(opp.Amount >= dt.Minimum_Amount__c){
                    discountPercentage = dt.Discount_Percentage__c;
                }
            }
            opp.Discount_Custom_Setting__c = opp.Amount*(discountPercentage/100);
            opp.Discount_Percentage_Custom_Setting__c= discountPercentage;
        }        
    }


    public static void question39(List<Opportunity> oppList,Map<Id,Opportunity> oppOLdMap){
        List<Opportunity> updatedOppList = new List<Opportunity>();
        for(Opportunity opp:oppList){
            if( opp.IsClosed == true){
                updatedOppList.add(new Opportunity(Id= opp.Id,Description = 'Opportunity is '+opp.StageName));
            }
        }
        if(!updatedOppList.isEmpty()){
            update updatedOppList;
        }
    }
}
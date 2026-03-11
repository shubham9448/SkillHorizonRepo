public class QueueableApex1 implements Queueable {
    public void execute(QueueableContext qc){
        Id AccountId = [SELECT Id FROM Account WHERE Name = 'Malani From PostMan' LIMIT 1].Id;
        List<Account> accList = [SELECT Id,ParentId FROM Account WHERE BillingStateCode = 'NY'];
        if(!accList.isEmpty()){
            for(Account acc:accList){
                acc.ParentId = AccountId;
            }
            update accList;
        }
    }
}
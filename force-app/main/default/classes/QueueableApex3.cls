public class QueueableApex3 implements Queueable{
    private Integer num;
    public QueueableApex3(Integer n) {
        num=n;
    }
    public void execute(QueueableContext qc){
        List<Account> accList = new List<Account>();
        for(Integer i=0;i<num;i++){
            accList.add(new Account(Name='Account '+i,AnnualRevenue = 45000,Active__c = 'Yes'));
        }
        if(!accList.isEmpty()){
            insert accList;
        }
        if(!Test.isRunningTest()){
            Set<Id> accIds = new Set<Id>();
            for(Account acc: accList){
                accIds.add(acc.Id);
            }
            Id jobId = System.enqueueJob(new QueueableApex3Part2(accIds));
        }
    }
}
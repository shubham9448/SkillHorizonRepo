public class QueueableApex3Part2 implements Queueable{
    private Set<Id> accSet;
    public QueueableApex3Part2(Set<Id> accSet) {
        this.accSet = accSet;
    }
    public void execute(QueueableContext qc){
        List<Opportunity> oppList = new List<Opportunity>();
        for(Id i:accSet){
            oppList.add(new Opportunity(Name = 'Test Opportunity',StageName='Prospecting',CloseDate = System.TODAY(),Amount= 09032025,AccountId=i));
        }
        if(!oppList.isEmpty()){
            insert oppList;
        }
    }
}
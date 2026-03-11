public class ScheduleApex2 implements Schedulable {
    public void execute(SchedulableContext sc){
        BatchScheduleApex2 bsa = new BatchScheduleApex2();
        Id JobId = Database.executeBatch(bsa);
    }
    
}
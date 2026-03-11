public class ScheduleApex4 implements Schedulable{
    public void execute(SchedulableContext sc){
        BatchScheduleApex4 bsa = new BatchScheduleApex4();
        Database.executeBatch(bsa);
    }
}
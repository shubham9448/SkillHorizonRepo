public class ScheduleApex3 implements Schedulable{
    public void execute(SchedulableContext sc){
        BatchScheduleApex3 bsa = new BatchScheduleApex3();
        Database.executeBatch(bsa);
    }
}
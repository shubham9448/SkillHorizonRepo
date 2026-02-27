public class ScheduleJobsApex implements Schedulable{
    public void execute(SchedulableContext sc){
    AccountBatch1 ab = new AccountBatch1();
    Id jobId = Database.executeBatch(ab);
    }

}
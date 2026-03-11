public class ScheduleApex1 implements Schedulable{
    public void execute(SchedulableContext sc){
        List<Opportunity> oppList = [SELECT Id FROM Opportunity WHERE IsClosed = false AND CloseDate<TODAY];
        List<Task> taskList = new List<Task>();
        for(Opportunity opp:oppList){
            Task task = new Task();
            task.WhatId = opp.Id;
            task.OwnerId = UserInfo.getUserId();
            task.Status = 'Not Started';
            task.Subject = 'New Task';
            task.ActivityDate = System.Today()+7;
            taskList.add(task);
        }

        if(!taskList.isEmpty()){
            insert taskList;
        }
    }
}
public with sharing class UserTriggerHandler {
     public static void question43(List<User> usList){
        List<GroupMember> gmList = new List<GroupMember>();
        Id profileId = [SELECT Id,Name FROM Profile WHERE Name ='System Administrator' LIMIT 1].Id;
        Id groupId = [SELECT Id,Name FROM Group WHERE Name = 'Admins'].Id;
        for(User us:usList){
            if(us.IsActive == true && us.ProfileId == profileId){
                gmList.add(new GroupMember(GroupId=groupId,UserOrGroupId = us.Id));
            }
        }
        if(!gmList.isEmpty()){
            insert gmList;
        }
    }
}
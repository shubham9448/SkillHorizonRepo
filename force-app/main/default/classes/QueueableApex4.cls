public class QueueableApex4 implements Queueable {
    private List<Id> userIdList;
    private Id PermissionSetId;
    public QueueableApex4(List<Id> userIdList) {
        List<PermissionSet> psList = [SELECT Id FROM PermissionSet WHERE Name = 'APIPermissionUser' LIMIT 1];

        if(psList.isEmpty()){
            PermissionSet ps = new PermissionSet();
            ps.Name = 'APIPermissionUser';
            ps.Label = 'APIPermissionUser';
            ps.LicenseId = [SELECT Id FROM UserLicense WHERE Name ='Salesforce'].Id;
            insert ps;

            PermissionSetId = ps.Id;
        }else{
            PermissionSetId= psList[0].Id;
        }

        this.userIdList= userIdList;
    }
    public void execute(QueueableContext qc){
        List<PermissionSetAssignment> psList = new List<PermissionSetAssignment>();
        Id profileId = [SELECT Id FROM Profile WHERE Name = 'Demo Profile'].Id;
        List<User> usList = [SELECT Id,ProfileId FROM User WHERE Id IN: userIdList];
        for(User us:usList){
            if(us.ProfileId == profileId){
                psList.add(new PermissionSetAssignment(PermissionSetId = PermissionSetId, AssigneeId = us.Id));
            }
        }
        if(!psList.isEmpty()){
            insert psList;
        }
    }
}
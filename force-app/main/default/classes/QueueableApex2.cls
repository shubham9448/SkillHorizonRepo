public class QueueableApex2 implements Queueable {
    private Contact con;
    private String industryValue;
    public QueueableApex2(Contact con,String industryValue){
        this.con = con;
        this.industryValue = industryValue;
    }
    public void execute(QueueableContext qc){
        List<Contact> conList = new List<Contact>();
        List<Account> accList = [SELECT Id FROM Account WHERE Industry =: industryValue];
        for(Account acc : accList){
            Contact con1 = con.clone(false,false,false,false);
            con1.accountId = acc.Id;
            conList.add(con1); 
        }

        if(!conList.isEmpty()){
            insert conList;
        }
    }
}
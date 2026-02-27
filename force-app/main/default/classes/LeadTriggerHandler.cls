public class LeadTriggerHandler {
    public static void setCompany(List<Lead> leadList){
        for(Lead ld:leadList){
            if(ld.Company == null){
            	ld.Company = 'Self-Employeed';    
            }
        }
    }
}
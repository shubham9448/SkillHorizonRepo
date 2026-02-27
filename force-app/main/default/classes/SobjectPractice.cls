public class SobjectPractice {

    /*public static void createAccount(){
        List<Account> accList = new List<Account>();
        List<Opportunity> oppList = new List<Opportunity>();
        for(Integer i=1;i<=5;i++){
        	Account acc = new Account();
        	acc.Name = 'Test Acc '+i; 
        	acc.Active__c = 'Yes';	
        	accList.add(acc);                  
        }
        
        insert accList;
        for(Account acc:accList){
            Opportunity opp = new Opportunity();
            opp.Name = acc.Name;
            opp.Id = acc.Id;
            opp.StageName = 'Prospecting';
            opp.CloseDate = Date.Today();
        }
       	insert oppList;
        
    }
    
    public static void createOpportunity(){
        
        Opportunity opp = new Opportunity();
        opp.Name = 'Test';
        opp.CloseDate = Date.TODAY();
        opp.StageName = 'Prospecting';        
        Insert opp;
        
        
    }
    
    private static void insertEmployee(){
        Employee__c emp = new Employee__c();
        emp.Name__c= 'Test Employee';
        emp.Salary__c = 250000;
        emp.Department__c = 'Sales';
        Insert emp;
    }
    
    */
    public static void integerList(){
        List<Integer> intList = new List<Integer>();
        List<Integer> intList1 = new List<Integer>();
		intList.add(20);
        intList.add(60);
        intList.add(70);
        intList.add(1,20);
        //intList.add(5,10);
        System.debug('List Contains '+intList);
        //intList.set(3,60);
        //System.debug('List Contains '+intList);
        //
        System.debug(intList.indexOf(70));
        System.debug(intList.get(1));
        
        intList1=intList.clone();
    }
   
    public static void demo(){
        Set<Integer> idSet = new Set<Integer>();
        idSet.add(30);
        idSet.add(60);
        idSet.add(50);
        idSet.add(30);
        
        System.debug('Set'+idSet);
    }
    
    
    public static void mapDemo(){
        Map<Integer,String> IntToString = new Map<Integer,String>();
        IntToString.put(2,'Black');
        IntToString.put(1,'Black');
        IntToString.put(2,'Blue');
        IntToString.put(10,'Green');
        System.debug(IntToString);
        System.debug(IntToString.KeySet()); 
        System.debug(IntToString.Values());
    }
}
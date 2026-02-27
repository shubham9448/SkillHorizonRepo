public class ExceptionHandling {
    public static void demo1(){
        System.debug('Before Exception');
        try{
            Account acc= new Account();
            //insert acc;
            Database.insert(acc,false);
        }catch(DMLException e){
            System.debug(e.getMessage());
        }
    }
}
public class Calculator {
    Integer a,b;
    
    public Calculator(){
        a=9;
        b=4;
    }
    
    public Calculator(Integer i,Integer j){
        a=i;
        b=j;
    }
    
    public void addition(){
        Integer sum =a+b;
    	System.debug('Addition ='+sum);    
    }
    public void subtraction(){
        if(a>b){
        	Integer sub =a-b;
    		System.debug('Subtraction ='+sub);    
        }else{
            Integer sub =b-a;
    		System.debug('Subtraction ='+sub);
        }
    }
    public void multiplication(){
        Integer mul =a*b;
    	System.debug('Multiplication ='+mul);
    }
    public void division(){
        Decimal div =a/b;
        if(div>0){
        	System.debug('Division ='+div);    
        }else{
            return;
        }    	
    }
}
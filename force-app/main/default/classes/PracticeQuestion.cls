public with sharing class PracticeQuestion {
    public static void table(Integer n){
        for(Integer i=1;i<=10;i++){
            System.debug(n+'*'+i+'='+n*i);
        }
    }
    public static void printEven(Integer n){
        for(Integer i=1;i<=n;i++){
            if(Math.mod(i,2)==0){
                System.debug(i);
            }
        }
    }
    
    public static void printOdd(Integer n){
        for(Integer i=1;i<=n;i++){
            if(Math.mod(i,2)!=0){
                System.debug(i);
            }
        }
    }
    
    public static void printNaturalNumber(Integer n){
        for(Integer i=n;i>=1;i--){
            System.debug(i);
        }
    }
    
    public static void sumNaturalNumber(Integer n){
        Integer sum=0;
        for(Integer i=1;i<=n;i++){
            sum+=i;
        }
        System.debug('Sum of natural number is '+sum);
    }
	
    public static void sumEvenNumber(Integer n){
        Integer sum = 0;
        for(Integer i=1;i<=n;i++){
            if(Math.mod(i,2) == 0){
                sum+=i;
            }
        }
        System.debug('Sum of even number is '+sum);
    }
    
    public static void sumOddNumber(Integer n){
        Integer sum = 0;
        for(Integer i=1;i<=n;i++){
            if(Math.mod(i,2) != 0){
                sum+=i;
            }
        }
        System.debug('Sum of odd number is '+sum);
    }
    
    
    
    public static void usingSwitch(Integer i){
        switch on i{
            when 1{
            	Calculator ca = new Calculator(3,7);
                ca.addition();
            }when 2{
                RectangleClass.area(4,8);
            }when 3{
                Triangle tr = new Triangle(3,7,2);
                tr.perimeterNonStatic(6,8,11);
            }when 4{
                RectangleClass.perimeter(7,9);
            }when else{
            	System.debug('Input is invalid');    
            }
        }
    }
}
public class ConditionalStatement {
    public static void maximumNum(Integer num1,Integer num2){
        if(num1>num2){
            System.debug(num1+' is greater');
        }else{
            System.debug(num2+ ' is greater');
        }    
    }
    
    public static void eligibleToVote(Integer age){
        if(age>0 && age>18){
            System.debug('The user is eligible to vote as age is '+age); 
        }else{
            return;    
        }      
    }
    
    public static void numberOddEven(Integer num){
        if(num> 0){
            if(Math.mod(num,2) == 0){
                System.debug('Number is Even');    
            }else{
                System.debug('Number is odd');    
            }
        }else{
            return;
        }
    }
    
    public static void convertorInchToFeet(Integer i){
        Integer feet;
        Decimal inch;
        if(i>= 12){
            feet = i/12;
            inch = Math.mod(i,12);
            System.debug('The user is '+feet+'\''+' feet tall and '+inch+'\"'+' inch');
        }else{
            System.debug('Conversion is not possible');
            return;
        }    
    }
    
    
    public static void checkPosNegZeo(Integer num){
        if(num >0){
            System.debug('Number is positive');    
        }else if(num<0){
            System.debug('Number is negative');     
        }else{
            System.debug('Number is Zero');     
        }    
    }
    
    public static void checkPosNegZeo1(Integer num){
        if(num == 0){
            System.debug('Number is zero');    
        }else{
            if(num>0){
                System.debug('Number is positive');    
            }else{
                System.debug('Number is negative');    
            }
        }    
    }
    
    
    public static void calculateBonus(Integer salary,String Dep){
        Decimal Bonus;
        if(salary>=200000 && Dep == Dep.toLowerCase()){
            Bonus = salary*0.2;
            System.debug('Bonus is '+Bonus);
        }else{
            Bonus = salary*0.1;
            System.debug('Bonus is '+Bonus);
        } 
        
        if(salary>=200000 || Dep == Dep.toLowerCase()){
            Bonus = salary*0.2;
            System.debug('Bonus is '+Bonus);
        }else{
            Bonus = salary*0.1;
            System.debug('Bonus is '+Bonus);
        } 
        
    }
    
    public static void calculateUsingIfElse(Integer l,Integer b){
        if(l+b > 50){
            System.debug('Area = '+l*b);
        }else{
            System.debug('Perimeter = '+2*(l+b));
        }    
    }
    
    public static void calculateUsingTernary(Integer l,Integer b){
        Integer Output = l+b >50 ? l*b : 2*(l+b);
        System.debug('Output is '+Output);
        
    }
    
    
    public static void calculate(Integer n,Integer l,Integer b,Integer h){
        if(n>=1 || n<=4){
            if(n == 1){
                System.debug('Sum of two number is '+(l+b));    
            }else if(n == 2){
                System.debug('Area of Rectangle is '+(l*b));    
            }else if(n == 3){
                System.debug('Perimeter of triangle is '+(l+b+h));    
            }else if(n== 4){
                System.debug('Perimeter of Rectangle is '+2*(l+b));    
            }else{
                System.debug('Please eneter a number between 1-4');
            }                  
        }
    }	
}
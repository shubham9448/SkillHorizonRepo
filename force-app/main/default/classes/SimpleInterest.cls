public with sharing class SimpleInterest {
    Integer pri;
    Integer rat;
    Integer tim;
    
    //default constructor
    public SimpleInterest(){
        pri=10;
        rat=4;
        tim=5;
    }
    
    //perimeterised constructor
    public SimpleInterest(Integer p,Integer r,Integer t){
    	pri=p;
        rat=r;
        tim=t;
    }
    public void calculate(){
    	decimal value = (pri*rat*tim)/100;
        System.debug('Simple Interest ='+value);
    }
}
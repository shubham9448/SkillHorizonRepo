public with sharing class Triangle {
    
    Integer l;
    Integer b;
    Integer h;
    
    //constructor
    public Triangle(Integer le,Integer be,Integer he){
    	l=le;
        b=be;
        h=he;
    }
    //non static non return 
    public void areaNonStatic(){
    	Decimal Area = 0.5*l*b; 
        System.debug(Area);
    }
    
    //non static pass parameter return value
    public Integer perimeterNonStatic(Integer l,Integer b,Integer h){
        Integer per= l+b+h;
        System.debug(per);
        return per;
    }
    
    //static without passing without return
    public static void areaStatic(){
        Integer l=3;
        Integer b=9;
       Decimal Area = 0.5*l*b; 
        System.debug(Area);
    }
    
    //static pass perimeter return
    public static Integer perimeterStatic(Integer l,Integer b,Integer h){
        Integer per= l+b+h;
        System.debug(per);
        return per;
    }
}
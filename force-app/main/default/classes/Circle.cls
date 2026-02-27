public class Circle {
    
    public static void area(){ 
        Integer r=10;
        Double area = Math.PI*r*r;
        System.debug(area);
    }
    
    public static void circumference(){ 
        Integer r=10;
        Double cir = 2*Math.PI*r;
        System.debug(cir);
    }
}
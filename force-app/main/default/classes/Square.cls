public class Square {
    Integer r;
    
    //default constructor
    public Square(){
        r=6;
    }
    
    //perimeterised constructor
    public Square(Integer ra){
    	r=ra;    
    }
    public void area(){
    	Integer area = 2*r;
        System.debug('Area ='+area);
    }
    public void perimeter(){
        Integer per = 4*r;
        System.debug('Perimeter ='+per);
    }
}
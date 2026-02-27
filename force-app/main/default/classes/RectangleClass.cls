public with sharing class RectangleClass {
    public static Integer area(Integer n1,Integer n2){
        System.debug('Area ='+(n1*n2));
        return n1*n2;
    }
		
	public static Integer perimeter(Integer n1,Integer n2){
        System.debug('perimeter ='+2*(n1+n2));
        return 2*(n1+n2);
    }    
}
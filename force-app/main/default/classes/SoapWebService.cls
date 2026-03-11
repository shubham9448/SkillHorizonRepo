global class SoapWebService {
    public class APIException extends Exception {}
    
    webservice static String getAPIStatus (String message) {
    return 'Ready your message is ' + message;
    }

    webservice static List<Opportunity> getOppDetail (Integer searchValue) {
    if (searchValue != null) {
        List<Opportunity> oppList = [SELECT Id, Name, Amount FROM Opportunity WHERE Amount >= :searchValue];             
        return oppList;    
    }else {              
        throw new APIException('error');
       }
    }
}
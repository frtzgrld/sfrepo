public with sharing class test {
    public void testResponse(){
        String apiKey = 'fb69dec0cf61450287c713f070d0d358';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.sansan.com/v2.4/bizCards/search');
        request.setHeader('X-Sansan-Api-Key', apiKey);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200){
            String resp = response.getBody();
            System.debug(resp);
        }        
    }
}
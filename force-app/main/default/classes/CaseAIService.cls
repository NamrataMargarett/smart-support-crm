public with sharing class CaseAIService {
    public static final String DEFAULT_ENDPOINT = 'https://example.com/api/predict';

    public static Map<String, Object> predictComplaint(String description) {
        if (String.isBlank(description)) {
            throw new IllegalArgumentException('Complaint description is required.');
        }

        HttpRequest req = new HttpRequest();
        req.setEndpoint(DEFAULT_ENDPOINT);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setBody('{"description":"' + description.replace('"', '\\"') + '"}');

        Http h = new Http();
        HttpResponse res;

        try {
            res = h.send(req);
            if (res.getStatusCode() == 200) {
                return (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            }
            throw new CalloutException('AI prediction request failed: ' + res.getStatusCode());
        } catch (Exception e) {
            throw new AuraHandledException('AI prediction service is currently unavailable. Configure the Named Credential and endpoint manually.');
        }
    }
}

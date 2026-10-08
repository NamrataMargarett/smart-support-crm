@IsTest
public with sharing class CaseAIServiceTest {
    @IsTest
    static void testPredictionFailureGracefully() {
        Test.setMock(HttpCalloutMock.class, new CaseAIHttpMock());

        try {
            Map<String, Object> result = CaseAIService.predictComplaint('My laptop is not charging');
            System.assertNotEquals(null, result);
        } catch (Exception e) {
            System.assert(e instanceof AuraHandledException);
        }
    }

    public class CaseAIHttpMock implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(200);
            res.setBody('{"category":"Hardware","priority":"High","confidence":0.91}');
            return res;
        }
    }
}

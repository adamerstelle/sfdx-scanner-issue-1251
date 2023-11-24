@RestResource(urlMapping='/teamsAdmin/*')
global with sharing class SampleError {

    @HttpGet
    /* sfge-disable-stack ApexFlsViolationRule */
    global static void doGet() {
        System.RestResponse res = System.RestContext.response;
        Zippex zipFile = new Zippex(); // from https://github.com/pdalcol/Zippex

        // get files to put into a ZIP file
        StaticResource sr = [
            SELECT Id, Body 
            FROM StaticResource 
            WHERE Name = 'logo' 
            WITH SECURITY_ENFORCED];
        zipFile.addFile('logo.png', sr.Body, null);

        // respond to the HTTP Get with a downloadable zip file
        res.headers.put('content-type', 'application/zip');
        res.statusCode = 200;
        res.responseBody = zipFile.getZipArchive();
    }
}
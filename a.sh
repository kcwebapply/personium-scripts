curl -w "\nstatus:%{http_code}\n" "http://localhost/__ctl/Cell" -X GET -H "Authorization: Bearer personiumio" -k -i -s


 curl "http://localhost/testcell/__token" \
> -X POST -i \
> -d "grant_type=password&username=user1&password=password1" \
> -H "Content-Type: application/x-www-form-urlencoded"
HTTP/1.1 200
Server: nginx/1.14.2
Date: Thu, 17 Jun 2021 03:48:50 GMT
Content-Type: application/json
Content-Length: 391
Connection: keep-alive
Location: http://localhost/testcell/__token
X-Personium-Version: 1.7.21

{"access_token":"AR~jxg1An6_7lSJr7_loLsKLbUL933u7MvhPhiJ-jUrBc2nKXnMRwuG-7ePv9O6g1eLBbqFSu-yoXqshZw9APAN1Q","refresh_token_expires_in":86400,"refresh_token":"RR~AJjEuYF0qn5QrSrRrNK5U6-KJnXna50AiicsqIKPUuPSBLr2Y3nR5YdHns03j9W0pb4HyclLngwaGMI7xz9x9w","last_authenticated":null,"p_target":"http:\/\/localhost\/testcell\/","scope":"root","failed_count":0,"token_type":"Bearer","expires_in":3600}


curl "http://localhost/testcell/userbox/WebDavContents" \
-X PROPFIND -i \
-d '<?xml version="1.0" encoding="utf-8"?><D:propfind xmlns:D="DAV:"><D:allprop/></D:propfind>' \
-H 'Depth:0' \
-H "Accept:application/json" -H "Authorization:Bearer AR~jxg1An6_7lSJr7_loLsKLbUL933u7MvhPhiJ-jUrBc2nKXnMRwuG-7ePv9O6g1eLBbqFSu-yoXqshZw9APAN1Q"

HTTP/1.1 207
Server: nginx/1.14.2
Date: Thu, 17 Jun 2021 04:12:35 GMT
Content-Type: application/xml
Content-Length: 517
Connection: keep-alive
ETag: "8-1623831229980"
X-Personium-Version: 1.7.21

<multistatus xmlns="DAV:">
    <response>
        <href>http://localhost/testcell/userbox/WebDavContents</href>
        <propstat>
            <prop>
                <creationdate>2021-06-16T08:13:49.980+0000</creationdate>
                <getlastmodified>Wed, 16 Jun 2021 08:13:49 GMT</getlastmodified>
                <resourcetype>
                    <collection/>
                </resourcetype>
            </prop>
            <status>HTTP/1.1 200 OK</status>
        </propstat>
    </response>
</multistatus>


curl "http://localhost/testcell2/__token" \
-X POST -i \
-d "grant_type=password&username=user2&password=password2" \
-H "Content-Type: application/x-www-form-urlencoded"
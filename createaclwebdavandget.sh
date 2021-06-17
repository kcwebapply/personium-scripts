# webdavに
curl 'http://localhost/testcell/userbox/WebDavContents'  \
-X ACL -i \
-d '<D:acl xmlns:D="DAV:" xmlns:p="urn:x-personium:xmlns" xml:base="http://localhost/testcell/__role/userbox/"><D:ace><D:principal><D:href>userrole</D:href></D:principal><D:grant><D:privilege><p:read/></D:privilege><D:privilege><p:write/></D:privilege></D:grant></D:ace></D:acl>' \
-H "Accept:application/json" -H "Authorization:Bearer personiumio"


curl "http://localhost/testcell/userbox/WebDavContents" \
-X PROPFIND -i \
-d '<?xml version="1.0" encoding="utf-8"?><D:propfind xmlns:D="DAV:"><D:allprop/></D:propfind>' \
-H 'Depth:0' \
-H "Accept:application/json" -H "Authorization:Bearer personiumio"



curl "http://localhost/testcell/userbox/WebDavContents/profile.json" -X PUT -i \
-d "{\"DisplayName\":\"＜APIでアクセスしてみる＞\",\"Description\": \"＜APIでアクセスしてみる＞のサンプルで利用するファイル\",\"Image\": \"data:image/png;base64,{{Image}}\"}" \
-H "Accept:application/json" -H "Authorization:Bearer personiumio"


curl "http://localhost/testcell/userbox/WebDavContents/profile.json" \
-X GET -i \
-H "Accept:application/json" -H "Authorization:Bearer personiumio"

# 結果確認
>> wadakeishinoMacBook-Pro:scripts wadakeishi$   curl "http://localhost/testcell/userbox/WebDavContents/profile.json" \
> -X GET -i \
> -H "Accept:application/json" -H "Authorization:Bearer personiumio"
HTTP/1.1 200
Server: nginx/1.14.2
Date: Thu, 17 Jun 2021 01:59:11 GMT
Content-Type: application/x-www-form-urlencoded
Content-Length: 193
Connection: keep-alive
ETag: "2-1623832185268"
Accept-Ranges: bytes
X-Personium-Version: 1.7.21

{"DisplayName":"＜APIでアクセスしてみる＞","Description": "＜APIでアクセスしてみる＞のサンプルで利用するファイル","Image": "data:image/png;base64,{{Image}}"}
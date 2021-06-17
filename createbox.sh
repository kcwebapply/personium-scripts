# box作成
curl "http://localhost/testcell/__ctl/Box" \
-X POST -i \
-d "{\"Name\":\"userbox\"}" \
-H "Accept:application/json" -H "Authorization:Bearer personiumio"

# Webdav
curl "http://localhost/testcell/userbox/WebDavContents" \
-X MKCOL -i \
-d "<?xml version=\"1.0\" encoding=\"utf-8\"?><D:mkcol xmlns:D=\"DAV:\" xmlns:p=\"urn:x-personium:xmlns\"><D:set><D:prop><D:resourcetype><D:collection/></D:resourcetype></D:prop></D:set></D:mkcol>" \
-H "Accept:application/json" -H "Authorization:Bearer personiumio"


# webdav取得

curl "http://localhost/testcell/userbox" \
-X PROPFIND -i \
-d '<?xml version="1.0" encoding="utf-8"?><D:propfind xmlns:D="DAV:"><D:allprop/></D:propfind>' \
-H 'Depth:1' \
-H "Accept:application/json" -H "Authorization:Bearer personiumio"

# Odata作成

curl -w "\nstatus:%{http_code}\n" "http://localhost/testcell/userbox/ODataContents" -X MKCOL -i \
-d "<?xml version=\"1.0\" encoding=\"utf-8\"?><D:mkcol xmlns:D=\"DAV:\" xmlns:p=\"urn:x-personium:xmlns\"><D:set><D:prop><D:resourcetype><D:collection/><p:odata/></D:resourcetype></D:prop></D:set></D:mkcol>" \
-H "Accept:application/json" -H "Authorization:Bearer personiumio" -k -i -s

# Odata取得
curl -w "\nstatus:%{http_code}\n" "http://localhost/testcell/userbox/ODataContents" \
-X PROPFIND -i \
-H 'Depth:1' \
-d '<?xml version="1.0" encoding="utf-8"?><D:propfind xmlns:D="DAV:"><D:allprop/></D:propfind>' \
-H "Accept:application/json" -H "Authorization:Bearer personiumio"

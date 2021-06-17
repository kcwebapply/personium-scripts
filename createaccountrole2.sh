# account作成
curl "http://localhost/testcell2/__ctl/Account" -X POST -i \
-d "{\"Name\":\"user2\"}" \
-H "X-Personium-Credential:password2" \
-H "Accept:application/json" -H "Authorization:Bearer personiumio"

#role作成
curl "http://localhost/testcell2/__ctl/Role" \
-X POST -i \
-d "{\"Name\":\"userrole2\",\"_Box.Name\":\"userbox2\"}" \
-H "Accept:application/json" -H "Authorization:Bearer personiumio"

# userとrole紐付け
curl "http://localhost/testcell2/__ctl/Role(Name='userrole2',_Box.Name='userbox2')/\$links/_Account" \
 -X POST -i \
 -d "{\"uri\":\"http://localhost/testcell2/__ctl/Account('user2')\"}" \
-H "Accept:application/json" -H "Authorization:Bearer personiumio"



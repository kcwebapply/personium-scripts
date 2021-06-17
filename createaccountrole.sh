# account作成

curl "http://localhost/testcell/__ctl/Account" -X POST -i \
-d "{\"Name\":\"user1\"}" \
-H "X-Personium-Credential:password1" \
-H "Accept:application/json" -H "Authorization:Bearer personiumio"

#role作成

curl "http://localhost/testcell/__ctl/Role" \
-X POST -i \
-d "{\"Name\":\"userrole\",\"_Box.Name\":\"userbox\"}" \
-H "Accept:application/json" -H "Authorization:Bearer personiumio"

# userとrole紐付け
curl "http://localhost/testcell/__ctl/Role(Name='userrole',_Box.Name='userbox')/\$links/_Account" \
 -X POST -i \
 -d "{\"uri\":\"http://localhost/testcell/__ctl/Account('user1')\"}" \
-H "Accept:application/json" -H "Authorization:Bearer personiumio"



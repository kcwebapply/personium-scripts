
# テーブル作成
curl "http://localhost/testcell/userbox/ODataContents/\$metadata/EntityType" \
-X POST -i \
-d '{ "Name":"profile"}' \
-H "Accept:application/json" -H "Authorization:Bearer personiumio"


# データ登録
curl "http://localhost/testcell/userbox/ODataContents/profile" \
-X POST -i \
-d '{"name": "kc"}' \
-H "Accept:application/json" -H "Authorization:Bearer personiumio"

# データ参照
curl "http://localhost/testcell/userbox/ODataContents/profile" \
-X GET -i \
-H "Accept:application/json" -H "Authorization:Bearer personiumio"
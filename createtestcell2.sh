#!/bin/bash

CWD=$(dirname "$0")
ADMIN_FILE="${CWD}/unitadmin_account"

### Check jq
which jq >/dev/null
if [ "$?" -ne 0 ]; then
  echo 'jq command is required. Please install jq.' >&2
  exit 1
fi

### Check unitadmin_account
if [ ! -f "${ADMIN_FILE}" ]; then
  echo 'unitadmin_account file does not exist. Please execute ./init.sh.' >&2
  exit 1
fi

### Check arguments
if [ -z "$1" ]; then
  echo 'Please specify cell_name. Usage: ./create_cell.sh <cell_name>' >&2
  exit 1
fi

### Set variables
UNITADMIN_CELL_URL=$(sed -n 's|^unitadmin_cell_url=||p' ${ADMIN_FILE})
UNITADMIN_ACCOUNT=$(sed -n 's|^unitadmin_account=||p' ${ADMIN_FILE})
UNITADMIN_PASSWORD=$(sed -n 's|^unitadmin_password=||p' ${ADMIN_FILE})

ROOT_URL=http://localhost/
CELL_NAME="$1"
CELL_URL="${ROOT_URL}${CELL_NAME}/"

function check_error () {
  RC="$1"
  MSG="$2"
  if [ "${RC}" -ne 0 ]; then
    echo "${MSG}" >&2
    exit 2
  fi
}

### Get unit admin token
TOKEN=$(curl -f -s -X POST \
  -H "Accept:application/json" \
  -H "content-type:application/x-www-form-urlencoded" \
  -d "grant_type=password" \
  -d "username=${UNITADMIN_ACCOUNT}" \
  -d "password=${UNITADMIN_PASSWORD}" \
  -d "p_target=${ROOT_URL}" \
  "${UNITADMIN_CELL_URL}__token" | jq -r '.access_token')
check_error $? 'Get unit admin token failed.'

### Create cell
curl -i -f -X POST \
  -H "Authorization:Bearer ${TOKEN}" \
  -H "Accept:application/json" \
  -d '{"Name": "'${CELL_NAME}'"}' \
  "${ROOT_URL}__ctl/Cell" >/dev/null
check_error $? 'Create cell failed.'

### Upload snapshot
curl -i -f -X PUT \
  -H "Content-Type:application/x-zip-compressed" \
  -H "Accept:application/json" \
  -H "Authorization:Bearer ${TOKEN}" \
  -T "${CWD}/template.zip" \
  "${CELL_URL}__snapshot/template.zip"
check_error $? 'Upload snapshot failed.'

### 4. Import snapshot
curl -i -f -X POST \
  -H "Accept:application/json" \
  -H "Authorization:Bearer ${TOKEN}" \
  -d '{"Name": "template"}' \
  "${CELL_URL}__import"
check_error $? 'Import snapshot failed.'

echo "Creating cell succeeded!"
echo "Cell URL: ${CELL_URL}"


#box作成
curl "http://localhost/testcell2/__ctl/Box" \
-X POST -i \
-d "{\"Name\":\"userbox2\"}" \
-H "Accept:application/json" -H "Authorization:Bearer personiumio"

# Webdav
curl "http://localhost/testcell2/userbox2/WebDavContents" \
-X MKCOL -i \
-d "<?xml version=\"1.0\" encoding=\"utf-8\"?><D:mkcol xmlns:D=\"DAV:\" xmlns:p=\"urn:x-personium:xmlns\"><D:set><D:prop><D:resourcetype><D:collection/></D:resourcetype></D:prop></D:set></D:mkcol>" \
-H "Accept:application/json" -H "Authorization:Bearer personiumio"


# webdav取得

curl "http://localhost/testcell2/userbox2" \
-X PROPFIND -i \
-d '<?xml version="1.0" encoding="utf-8"?><D:propfind xmlns:D="DAV:"><D:allprop/></D:propfind>' \
-H 'Depth:1' \
-H "Accept:application/json" -H "Authorization:Bearer personiumio"

# Odata作成

curl -w "\nstatus:%{http_code}\n" "http://localhost/testcell2/userbox2/ODataContents" -X MKCOL -i \
-d "<?xml version=\"1.0\" encoding=\"utf-8\"?><D:mkcol xmlns:D=\"DAV:\" xmlns:p=\"urn:x-personium:xmlns\"><D:set><D:prop><D:resourcetype><D:collection/><p:odata/></D:resourcetype></D:prop></D:set></D:mkcol>" \
-H "Accept:application/json" -H "Authorization:Bearer personiumio" -k -i -s

# Odata取得
curl -w "\nstatus:%{http_code}\n" "http://localhost/testcell2/userbox2/ODataContents" \
-X PROPFIND -i \
-H 'Depth:1' \
-d '<?xml version="1.0" encoding="utf-8"?><D:propfind xmlns:D="DAV:"><D:allprop/></D:propfind>' \
-H "Accept:application/json" -H "Authorization:Bearer personiumio"
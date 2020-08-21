# Script to gather domains having same NameServer using Security Trails API
#!/bin/bash

max="$(curl --request POST --url 'https://api.securitytrails.com/v1/domains/list?apikey=KEYHERE' --data '{"filter":{"ns":"NSHERE"}}' | jq  -r '.meta.max_page')"
echo ${max}
for((i=1;i<=$max;i++))
do
curl --request POST --url 'https://api.securitytrails.com/v1/domains/list?apikey=KEYHERE&page='$i --data '{"filter":{"ns":"NSHERE"}}' | jq -r '.records[].hostname' >> out.txt
done

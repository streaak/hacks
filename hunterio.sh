#Script to gather emails from hunter.io API
#!/bin/bash

total=$(curl -s "https://api.hunter.io/v2/email-count?domain=$1" | jq -r '.data.total')
echo "Total is $total"

if [ "$total" != "0" ]; then
	for (( i=0; i<=$total; i+=100 ))
	do
		echo "offset $i"
		curl -s "https://api.hunter.io/v2/domain-search?domain=$1&api_key=KEYHERE&limit=100&offset=$i" | jq -r '.data.emails[].value' >> hunter_emails.txt
	done
	sort -uo hunter_emails.txt hunter_emails.txt
fi

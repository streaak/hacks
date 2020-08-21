Script to gather NXDOMAIN hosts and then output dig command of just the NXDOMAIN hosts.
#!/bin/bash

zdns A --name-servers 1.1.1.1,8.8.8.8,8.8.4.4 --threads 200 -retries 3 -input-file hosts.txt | grep NXDOMAIN | jq -r .name | tee nxdomain-temp.txt
parallel -j 200  'out=$(dig -t A "{2}"); if [[ "$out" =~ "NXDOMAIN" ]]; then echo "$out"; fi >> nxdomain.txt' ::: $1 :::: nxdomain-temp.txt

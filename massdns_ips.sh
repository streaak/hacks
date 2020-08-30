# Gather ips from massdns by supplying a list of hosts

massdns -r resolvers.txt  -q -t A -o S -w ports-massdns.raw hosts.txt
cat ports-massdns.raw | grep -e ' A ' |  cut -d 'A' -f 2 | tr -d ' ' | sort -u > ips.txt

#!/usr/bin/env bash
URL=$1
PAT=$(echo $URL | sed 's/\./\\./g' | sed -e 's/^/\\./')
main(){
    curl -s http://tls.bufferover.run/dns\?\q\=$URL | jq -r '.Results[]' | egrep $PAT | column -s ',' -t
}
main $@

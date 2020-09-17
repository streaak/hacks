# Script to split the file to 1024 hosts per file and run rumble scanner on it if it exceeds the limit. 
f=$1
if [ ! -f "output/$f/rumble/urls.txt" ]; then
	if [ "$(wc -l output/$f/hosts.txt | awk '{print $1}')" -gt 1024 ]; then
		mkdir -p output/$f/rumble-splits/ 
		split -l 1024 output/$f/hosts.txt output/$f/rumble-splits/rumble-
		for x in $(ls -l output/$f/rumble-splits | awk '{print $9}'); do 
			echo $f/$x
			rumble --input-targets output/$f/rumble-splits/$x -R 10000 -r 10000 --screenshots -o output/$f/$x-out --text --rdns-max-concurrent 128
		done
# You can do sort and processing here if required 
	fi
fi

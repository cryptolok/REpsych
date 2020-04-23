#!/bin/bash

# a simple script to convert ASCII art to ASM code

FILE=$1

lines=$(wc -l "$FILE" | cut -d ' ' -f 1)
let lines++

line=1
while [[ $line -ne $lines ]]
do
	echo -n 'db '
	cat "$FILE" | head -n $line | tail -n 1 | hexdump -v -e '"%08_ax  "' -e '16/1 "%02X ""  "" "' -e '16/1 "%_p""\n"' | cut -d ' ' -f 2-18 | sed 's/ /,0x/g' | tail -c +2 | sed 's/0x,//g' | sed 's/,0x$//g' | tr -d '\n'
	let line++
	echo
done
echo 'db 0x00'

#!/bin/sh

echo '[objects]' > temp
echo $1.obj >> temp

/usr/local/SDK/ASM/wla-65816 -o $1.asm $1.obj
/usr/local/SDK/ASM/wlalink -vr temp $1.smc

rm $1.obj
rm temp

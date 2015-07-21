#!/bin/bash
set -e

copy_binary() {
    platform=$1
    pname=$2
    pdir="../../skt/build/$pname/$platform"
    # read version while trimming whitespaces
    pver=$(echo -n $(cat $pdir/$pname.vfs/buildver.txt))
    destdir=$pver/$platform
    mkdir -p $destdir
    cp -f $pdir/${pname}.bin $destdir
    privkey=$(echo -n $(cat ../sktu_private.path))
    openssl dgst -sha1 -sign $privkey $destdir/${pname}.bin > $destdir/${pname}.bin.sig
    echo -n $pver > latest.txt
}

copy_binary linux-x86_64 skd
copy_binary linux-x86_64 sku


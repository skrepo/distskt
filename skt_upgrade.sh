#!/bin/bash



#pdir="../skt/build/sku/linux-x86_64"
## read version while trimming whitespaces
#pver=$(echo -n $(cat $pdir/sku.vfs/buildver.txt))
#cp $pdir/sku.bin sku/x86_64/sku.bin-$pver




copy_binary() {
    pname=$1
    pdir="../skt/build/$pname/linux-x86_64"
    # read version while trimming whitespaces
    pver=$(echo -n $(cat $pdir/$pname.vfs/buildver.txt))
    cp $pdir/${pname}.bin $pname/x86_64/${pname}.bin-$pver
}


signkey_path=$(echo -n $(cat sktu_private.path))

copy_binary sku
pushd sku/x86_64
../../update.sh -s $signkey_path
popd

copy_binary skd
pushd skd/x86_64
../../update.sh -s $signkey_path
popd

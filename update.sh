#!/bin/sh

usage() {
    echo "Usage: $0 [-s <private_key>]" 1>&2
    echo "Create metadata for versioned files repository." 1>&2
    echo "Update latest.txt, create latest-<checksum>.txt and optionally signatures." 1>&2
    echo "To be used with latest-sync as a client" 1>&2
    echo "-s <private_key> - create signature files with private_key" 1>&2
    exit 1
}

while getopts "s:" opt; do
    case $opt in
        s)
            privkey="$OPTARG"
            ;;
        *)
            usage
            ;;
    esac
done

shift $((OPTIND-1))


#TODO make it more robust - now we rely on last modification time
ls -t1 --hide=latest* --hide=*.sig --hide=README.md --hide=update.sh > latest.txt

cat latest.txt | xargs sha256sum > latest-sha256.txt
cat latest.txt | xargs sha1sum > latest-sha1.txt
cat latest.txt | xargs md5sum > latest-md5.txt

if [ -n "$privkey" ]; then
    for f in $(cat latest.txt); do
        if [ ! -f $f.sig ]; then 
            openssl dgst -sha1 -sign $privkey $f > $f.sig
        fi
    done
fi


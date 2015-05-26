#!/bin/sh

ls -t1 --hide=latest.txt --hide=README.md --hide=update.sh > latest.txt

cat latest.txt | xargs sha256sum > latest-sha256.txt
cat latest.txt | xargs sha1sum > latest-sha1.txt
cat latest.txt | xargs md5sum > latest-md5.txt


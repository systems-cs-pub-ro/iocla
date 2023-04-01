## Update checkpatch.pl

```
wget https://raw.githubusercontent.com/torvalds/linux/master/scripts/checkpatch.pl
mv checkpatch.pl > cs/checkpatch.pl

git add cs/checpatch.pl
git commit -m "checkpatch.pl: update to latest master version"

for patch in $(ls -v cs/patches); do git apply < cs/patches/${patch}; done
```

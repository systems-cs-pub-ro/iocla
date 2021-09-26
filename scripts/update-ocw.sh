#!/usr/bin/env bash
python -m pip install dokuwiki
python -m pip install pypandoc


python -c "from pypandoc.pandoc_download import download_pandoc;download_pandoc(version='2.5')"

files=`git diff --name-only HEAD~1 HEAD | grep README.md`
python scripts/convert.py --username $USERNAME --password $PASSWORD --files $files

#! /bin/bash

# clear
# rm -r *_cache *_files

# render
quarto render --no-clean

# fix section numbers
python3 _section_numbers.py

# track changes
git add .
git commit -m "$1"

# publish
git push

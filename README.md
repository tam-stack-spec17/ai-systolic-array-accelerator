\#!/usr/bin/env bash

set -e



\# 1. Navigate to your local git repository

REPO\_DIR="$HOME/vlsi-accelerator-portfolio"

if \[ ! -d "$REPO\_DIR" ]; then

&#x20;   # Fallback to current directory if specific folder is not found

&#x20;   REPO\_DIR="$(pwd)"

fi



cd "$REPO\_DIR"

echo "Working directory: $(pwd)"



\# 2. Create the docs and images hierarchy

mkdir -p docs/images

echo "Created docs/images directory structure."



\# 3. Locate and copy assets from Windows Downloads (if running inside WSL)

WIN\_USER=$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\\r')

WIN\_DOWNLOADS="/mnt/c/Users/${WIN\_USER}/Downloads"



if \[ -d "$WIN\_DOWNLOADS" ]; then

&#x20;   echo "Checking Windows Downloads (${WIN\_DOWNLOADS}) for project assets..."



&#x20;   # Copy the PDF report if present

&#x20;   find "$WIN\_DOWNLOADS" -maxdepth 1 -type f -iname "\*Systolic\*Report\*.pdf" -exec cp -v {} docs/Comprehensive\_Report.pdf \\; 2>/dev/null || true



&#x20;   # Copy diagrams if present

&#x20;   cp -v "$WIN\_DOWNLOADS"/fig\*.png docs/images/ 2>/dev/null || true

fi



\# 4. Verify directory contents

echo "--- Current docs/ structure ---"

ls -la docs/

ls -la docs/images/



\# 5. Stage, commit, and push changes to GitHub

git status

git add README.md docs/



\# Commit with a conventional commit message

git commit -m "docs: publish technical report, microarchitecture diagrams, and updated README" || echo "No new changes to commit."



\# Push to the remote repository

git push origin main



echo "Push to GitHub complete: https://github.com/tam-stack-spec17/ai-systolic-array-accelerator.git"


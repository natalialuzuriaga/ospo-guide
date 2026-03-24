#!/bin/bash

# repo-health-report.sh
# Checks for common repository health indicators and appends
# a summary report to MAINTENANCE_LOG.md

REPORT_DATE=$(date +"%Y-%m-%d")
OUTPUT_FILE="MAINTENANCE_LOG.md"
REPO_ROOT=$(git rev-parse --show-toplevel)

echo "" >> "$OUTPUT_FILE"
echo "## 🏥 Repository Health Report — $REPORT_DATE" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# ── Check 1: README exists ──────────────────────────────────────
echo "### 📄 Key File Checklist" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

for file in README.md CONTRIBUTING.md LICENSE .gitignore; do
  if [ -f "$REPO_ROOT/$file" ]; then
    echo "- ✅ \`$file\` — found" >> "$OUTPUT_FILE"
  else
    echo "- ❌ \`$file\` — **missing**" >> "$OUTPUT_FILE"
  fi
done

echo "" >> "$OUTPUT_FILE"

# ── Check 2: Workflow files present ────────────────────────────
echo "### ⚙️ GitHub Actions Workflows" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

WORKFLOW_COUNT=$(find "$REPO_ROOT/.github/workflows" -name "*.yml" 2>/dev/null | wc -l)
echo "- 🔁 Workflow files found: **$WORKFLOW_COUNT**" >> "$OUTPUT_FILE"

echo "" >> "$OUTPUT_FILE"

# ── Check 3: Last commit info ───────────────────────────────────
echo "### 🕒 Recent Activity" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

LAST_COMMIT_MSG=$(git log -1 --format="%s")
LAST_COMMIT_DATE=$(git log -1 --format="%ci")
LAST_COMMIT_AUTHOR=$(git log -1 --format="%an")
TOTAL_COMMITS=$(git rev-list --count HEAD)

echo "- 📝 Last commit: \`$LAST_COMMIT_MSG\`" >> "$OUTPUT_FILE"
echo "- 📅 Date: $LAST_COMMIT_DATE" >> "$OUTPUT_FILE"
echo "- 👤 Author: $LAST_COMMIT_AUTHOR" >> "$OUTPUT_FILE"
echo "- 🔢 Total commits on this branch: $TOTAL_COMMITS" >> "$OUTPUT_FILE"

echo "" >> "$OUTPUT_FILE"
echo "---" >> "$OUTPUT_FILE"
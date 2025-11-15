#!/bin/bash

# Deployment script for TAF aviation weather web app to Cloudflare Pages
# Usage: ./deploy.sh

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Project configuration
PROJECT_NAME="wx-hisenz"
BRANCH="main"

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  TAF Cloudflare Pages Deployment      ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

# Check if wrangler is available (either globally or via npx)
if command -v wrangler &> /dev/null; then
    WRANGLER_CMD="wrangler"
    echo -e "${GREEN}✓${NC} wrangler found (global)"
elif command -v npx &> /dev/null; then
    WRANGLER_CMD="npx wrangler"
    echo -e "${GREEN}✓${NC} wrangler available via npx"
else
    echo -e "${RED}✗ Error: wrangler is not available${NC}"
    echo -e "${YELLOW}  Install Node.js and run: npm install -g wrangler${NC}"
    exit 1
fi

# Check if we're in a git repository
if [ ! -d .git ]; then
    echo -e "${RED}✗ Error: Not a git repository${NC}"
    exit 1
fi

echo -e "${GREEN}✓${NC} Git repository detected"

# Check for uncommitted changes
if [[ -n $(git status -s) ]]; then
    echo -e "${YELLOW}⚠ Warning: You have uncommitted changes${NC}"
    echo ""
    git status -s
    echo ""
    read -p "Do you want to commit these changes before deploying? (y/n) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${BLUE}→${NC} Committing changes..."
        git add .
        read -p "Enter commit message: " commit_msg
        git commit -m "$commit_msg

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
        echo -e "${GREEN}✓${NC} Changes committed"

        read -p "Push to remote? (y/n) " -n 1 -r
        echo ""
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo -e "${BLUE}→${NC} Pushing to remote..."
            git push
            echo -e "${GREEN}✓${NC} Pushed to remote"
        fi
    fi
fi

# Deploy to Cloudflare Pages
echo ""
echo -e "${BLUE}→${NC} Deploying to Cloudflare Pages..."
echo -e "${BLUE}  Project: ${PROJECT_NAME}${NC}"
echo -e "${BLUE}  Branch:  ${BRANCH}${NC}"
echo ""

$WRANGLER_CMD pages deploy . \
    --project-name="${PROJECT_NAME}" \
    --branch="${BRANCH}" \
    --commit-dirty=true

echo ""
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  Deployment Successful!                ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Production URL:${NC} https://wx.hisenz.com"
echo -e "${BLUE}Pages URL:${NC}      https://wx-hisenz.pages.dev"
echo ""

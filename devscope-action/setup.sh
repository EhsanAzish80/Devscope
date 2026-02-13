#!/bin/bash
set -e

echo "🚀 Devscope Action Setup"
echo "========================"
echo ""

# Check if we're in the right directory
if [ ! -f "action.yml" ]; then
    echo "❌ Error: action.yml not found"
    echo "Please run this script from the devscope-action directory"
    exit 1
fi

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "📦 Initializing git repository..."
    git init
    git add .
    git commit -m "Initial commit: Devscope GitHub Action v1.0.0"
    echo "✅ Git initialized"
else
    echo "✅ Git already initialized"
fi

# Check if remote is set
if ! git remote get-url origin &> /dev/null; then
    echo ""
    echo "🔗 Setting up remote..."
    echo "Enter your GitHub username:"
    read -r GITHUB_USER
    
    REPO_URL="https://github.com/$GITHUB_USER/devscope-action.git"
    git remote add origin "$REPO_URL"
    echo "✅ Remote added: $REPO_URL"
else
    echo "✅ Remote already configured: $(git remote get-url origin)"
fi

# Offer to create GitHub repo
echo ""
echo "📋 Next steps:"
echo ""
echo "1. Create GitHub repository:"
echo "   gh repo create devscope-action --public --source=. --remote=origin"
echo ""
echo "2. Push code:"
echo "   git push -u origin main"
echo ""
echo "3. Create v1 release:"
echo "   git tag -a v1.0.0 -m 'Release v1.0.0'"
echo "   git tag -a v1 -m 'Latest v1.x.x'"
echo "   git push origin v1.0.0 v1"
echo ""
echo "4. Publish to GitHub Marketplace:"
echo "   - Go to: https://github.com/$USER/devscope-action/releases/new"
echo "   - Choose tag: v1.0.0"
echo "   - Check: ☑ Publish this Action to the GitHub Marketplace"
echo "   - Fill in details and publish"
echo ""

# Offer to run setup automatically
echo "Would you like to run these steps automatically? (y/n)"
read -r ANSWER

if [ "$ANSWER" == "y" ]; then
    echo ""
    echo "🔨 Running setup..."
    
    # Check if gh CLI is installed
    if ! command -v gh &> /dev/null; then
        echo "❌ GitHub CLI (gh) not found"
        echo "Install it: https://cli.github.com/"
        exit 1
    fi
    
    # Create repo
    echo "📦 Creating GitHub repository..."
    if gh repo create devscope-action --public --source=. --remote=origin --push; then
        echo "✅ Repository created and pushed"
    else
        echo "⚠️  Repository might already exist, continuing..."
    fi
    
    # Create tags
    echo "🏷️  Creating version tags..."
    git tag -a v1.0.0 -m "Release v1.0.0 - Initial public release" || echo "Tag v1.0.0 exists"
    git tag -fa v1 -m "Latest v1.x.x release" || echo "Tag v1 exists"
    git push origin v1.0.0 v1 --force
    
    echo ""
    echo "✅ Setup complete!"
    echo ""
    echo "📝 Final step: Publish to Marketplace"
    echo "   Visit: https://github.com/$(gh repo view --json nameWithOwner -q .nameWithOwner)/releases/new"
    echo "   1. Select tag: v1.0.0"
    echo "   2. Check: ☑ Publish this Action to the GitHub Marketplace"
    echo "   3. Category: Continuous Integration"
    echo "   4. Create release"
    echo ""
else
    echo ""
    echo "✅ Setup instructions displayed above"
    echo "Run the commands manually when ready"
fi

echo ""
echo "🎉 All done! Your action is ready to use."

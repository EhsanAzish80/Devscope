# Deployment Guide for Devscope Action

This guide explains how to deploy the devscope-action to GitHub and publish it to the GitHub Marketplace.

## 📦 Prerequisites

- GitHub account
- GitHub CLI (`gh`) installed: https://cli.github.com/
- Git configured with your credentials

## 🚀 Quick Deployment

### Option 1: Automated Setup (Recommended)

```bash
cd devscope-action
./setup.sh
```

The script will:
1. Initialize git repository
2. Create GitHub repository
3. Push code
4. Create version tags (v1.0.0, v1)
5. Guide you through Marketplace publishing

### Option 2: Manual Setup

#### Step 1: Initialize Repository

```bash
cd devscope-action
git init
git add .
git commit -m "Initial commit: Devscope GitHub Action v1.0.0"
```

#### Step 2: Create GitHub Repository

```bash
gh repo create devscope-action --public --source=. --remote=origin
```

Or create manually at: https://github.com/new

#### Step 3: Push Code

```bash
git branch -M main
git push -u origin main
```

#### Step 4: Create Version Tags

```bash
# Create specific version tag
git tag -a v1.0.0 -m "Release v1.0.0 - Initial public release"

# Create major version tag (auto-updates)
git tag -a v1 -m "Latest v1.x.x release"

# Push tags
git push origin v1.0.0 v1
```

#### Step 5: Publish to Marketplace

1. Go to: https://github.com/YOUR_USERNAME/devscope-action/releases/new
2. Choose tag: **v1.0.0**
3. Fill in release details:
   - **Title:** `v1.0.0 - Initial Release`
   - **Description:** Copy from CHANGELOG.md
4. Check: ☑ **Publish this Action to the GitHub Marketplace**
5. Select **Primary Category:** Continuous Integration
6. Click **Publish release**

## 🏷️ Versioning Strategy

This action follows semantic versioning:

- **v1.0.0** - Exact version (pinned)
- **v1** - Latest v1.x.x (auto-updated)

### Releasing Updates

**Patch version (v1.0.x):**
```bash
# Bug fixes, no breaking changes
git tag -a v1.0.1 -m "Fix: correct cache invalidation"
git tag -fa v1 -m "Latest v1.x.x"
git push origin v1.0.1 v1 --force
```

**Minor version (v1.x.0):**
```bash
# New features, backward compatible
git tag -a v1.1.0 -m "Add: support for custom output formats"
git tag -fa v1 -m "Latest v1.x.x"
git push origin v1.1.0 v1 --force
```

**Major version (vX.0.0):**
```bash
# Breaking changes
git tag -a v2.0.0 -m "Breaking: redesigned action inputs"
git tag -a v2 -m "Latest v2.x.x"
git push origin v2.0.0 v2
```

**Note:** Always force-update the major version tag (v1, v2) to point to the latest release.

## ✅ Post-Deployment Checklist

- [ ] Repository created on GitHub
- [ ] All files pushed to main branch
- [ ] Version tags created (v1.0.0, v1)
- [ ] Published to GitHub Marketplace
- [ ] Action appears in Marketplace search
- [ ] Test workflow runs successfully
- [ ] Documentation is clear and complete
- [ ] Examples work as expected

## 🧪 Testing the Published Action

After publishing, test it in a real repository:

```yaml
name: Test Devscope Action

on: [push, pull_request]

permissions:
  contents: read
  pull-requests: write

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      
      - uses: YOUR_USERNAME/devscope-action@v1
        with:
          fail-under: B
```

## 🔄 Updating the Action

### For Contributors

1. Fork the repository
2. Make changes in a feature branch
3. Open a Pull Request
4. After merge, maintainers will tag a new release

### For Maintainers

1. Merge PR to main
2. Update CHANGELOG.md
3. Create new version tag
4. Update major version tag
5. Create GitHub release

```bash
# Example: releasing v1.1.0
git checkout main
git pull
git tag -a v1.1.0 -m "Release v1.1.0: Add custom cache keys"
git tag -fa v1 -m "Latest v1.x.x"
git push origin v1.1.0 v1 --force

# Create release on GitHub
gh release create v1.1.0 \
  --title "v1.1.0 - Custom Cache Keys" \
  --notes "See CHANGELOG.md for details"
```

## 🛠️ Marketplace Settings

### Action Metadata

Ensure these fields are correct in `action.yml`:

```yaml
name: 'Devscope Code Health Check'
description: 'Analyze your codebase and post health metrics to PRs automatically'
author: 'devscope contributors'

branding:
  icon: 'activity'
  color: 'green'
```

### Categories

Primary: **Continuous Integration**  
Secondary: **Code Quality**

### Topics

Add these topics to your repository:
- `github-actions`
- `code-quality`
- `continuous-integration`
- `devops`
- `static-analysis`
- `maintainability`

## 📊 Monitoring Usage

After publishing, monitor:

1. **GitHub Insights:**
   - Traffic (views, clones)
   - Stars and forks
   - Dependency graph (who uses it)

2. **Marketplace Analytics:**
   - Unique users
   - Daily active users
   - Total installs

3. **Issues and Discussions:**
   - Bug reports
   - Feature requests
   - User questions

## 🐛 Troubleshooting

### Action not appearing in Marketplace

- Wait 5-10 minutes for indexing
- Ensure release is published (not draft)
- Check `action.yml` syntax is valid
- Verify "Publish to Marketplace" was checked

### Users can't find the action

- Add descriptive topics to repository
- Ensure README has good keywords
- Share in GitHub Discussions and social media

### Version tags not updating

```bash
# Force update major version tag
git tag -fa v1 -m "Latest v1.x.x"
git push origin v1 --force
```

## 📞 Support

- **Questions:** [GitHub Discussions](https://github.com/EhsanAzish80/devscope-action/discussions)
- **Bugs:** [GitHub Issues](https://github.com/EhsanAzish80/devscope-action/issues)
- **Security:** Email privately

## 🎉 Success!

Your action is now live! Users can add it to their workflows:

```yaml
- uses: YOUR_USERNAME/devscope-action@v1
```

Share it with the community! 🚀

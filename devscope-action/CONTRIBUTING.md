# Contributing to Devscope Action

Thank you for your interest in contributing! This guide will help you get started.

## 🚀 Quick Start

1. **Fork the repository**
   ```bash
   gh repo fork EhsanAzish80/devscope-action
   ```

2. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/devscope-action.git
   cd devscope-action
   ```

3. **Create a feature branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```

4. **Make your changes**
   - Edit `action.yml` for action logic
   - Update `README.md` for documentation
   - Add examples to `.github/workflows/`

5. **Test locally**
   ```bash
   # Install act (GitHub Actions simulator)
   brew install act  # macOS
   # or: choco install act  # Windows
   # or: curl -s https://raw.githubusercontent.com/nektos/act/master/install.sh | bash  # Linux
   
   # Test the action
   act pull_request -j test-action
   ```

6. **Commit and push**
   ```bash
   git add .
   git commit -m "feat: add amazing feature"
   git push origin feature/amazing-feature
   ```

7. **Open a Pull Request**
   - Go to GitHub and open a PR
   - Describe your changes
   - Link any related issues

## 📋 Development Guidelines

### Code Style

- **YAML:** Use 2-space indentation
- **Shell scripts:** Follow [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
- **Comments:** Explain non-obvious logic

### Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: add new feature
fix: correct bug in threshold checking
docs: update README with new examples
chore: update dependencies
test: add test for monorepo support
```

### Testing

Before submitting a PR:

1. **Test locally with act**
   ```bash
   act pull_request -j test-action
   ```

2. **Test on real repo**
   - Create a test PR in your fork
   - Verify the action runs correctly
   - Check PR comment formatting

3. **Test all platforms**
   The action should work on:
   - Ubuntu (Linux)
   - macOS
   - Windows

### Documentation

- Update `README.md` if you change behavior
- Add examples for new features
- Update `CHANGELOG.md` with your changes

## 🐛 Reporting Bugs

**Before opening an issue:**
1. Check if it's already reported
2. Try the latest version
3. Test with minimal reproduction

**Include in your bug report:**
- Operating system
- GitHub Actions runner (ubuntu-latest, etc.)
- Action version (v1, v1.0.0, etc.)
- Full error message
- Minimal workflow to reproduce

**Example:**
```yaml
name: Bug Reproduction

on: [push]

jobs:
  reproduce:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: EhsanAzish80/devscope-action@v1
        with:
          fail-under: B
```

## 💡 Requesting Features

**Good feature requests include:**
- Clear use case
- Expected behavior
- Example usage
- Why it's useful

**Example:**
> **Feature:** Support for custom cache keys
> 
> **Use case:** I want to cache per branch to avoid invalidation
> 
> **Proposed usage:**
> ```yaml
> - uses: EhsanAzish80/devscope-action@v1
>   with:
>     cache-key: ${{ github.ref }}
> ```
> 
> **Why:** Improves cache hit rate in monorepos with long-lived feature branches

## 📖 Areas to Contribute

### Easy Wins (Good First Issues)
- Fix typos in documentation
- Add more example workflows
- Improve error messages
- Add tests

### Medium Complexity
- Add new action inputs
- Improve caching strategy
- Add support for new devscope features
- Enhance PR comment formatting

### Advanced
- Multi-architecture support
- Custom action runners
- Integration tests
- Performance optimizations

## 🔍 Code Review Process

1. **Automated checks must pass**
   - Tests run successfully
   - No linting errors
   - Documentation builds

2. **Maintainer review**
   - Code quality
   - Test coverage
   - Documentation completeness

3. **Approval and merge**
   - Squash merge for clean history
   - Automatic version tagging

## 📦 Release Process

Releases are automated:

1. Merge PR to `main`
2. Update `CHANGELOG.md`
3. Create a release on GitHub
4. Tag with semantic version (v1.0.0)
5. Update major version tag (v1)

**Version tags:**
- `v1` → Latest v1.x.x (auto-updated)
- `v1.0.0` → Specific version (pinned)

## 🤝 Code of Conduct

Be respectful and constructive:
- Welcome newcomers
- Give helpful feedback
- Focus on the code, not the person
- Assume good intentions

## 📞 Getting Help

- **Questions:** [GitHub Discussions](https://github.com/EhsanAzish80/devscope-action/discussions)
- **Bugs:** [GitHub Issues](https://github.com/EhsanAzish80/devscope-action/issues)
- **Security:** Email security concerns privately

## 🙏 Recognition

Contributors are recognized:
- Added to GitHub contributors list
- Mentioned in release notes
- Featured in README (for significant contributions)

Thank you for contributing! 🎉

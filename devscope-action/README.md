# Devscope GitHub Action

**Zero-config code health checks for your pull requests** 🚀

Automatically analyze your repository and post maintainability metrics on every PR. No configuration needed — just drop it in your workflow.

[![GitHub release](https://img.shields.io/github/v/release/EhsanAzish80/devscope-action)](https://github.com/EhsanAzish80/devscope-action/releases)
[![Test Action](https://github.com/EhsanAzish80/devscope-action/workflows/test/badge.svg)](https://github.com/EhsanAzish80/devscope-action/actions)

---

## 🎯 Features

- ✅ **Automatic PR comments** with health metrics
- ✅ **Sticky updates** — no comment spam
- ✅ **CI quality gates** with configurable thresholds
- ✅ **Fast caching** — pipx packages cached between runs
- ✅ **Rich outputs** — use metrics in other workflow steps
- ✅ **Zero config** — works out of the box

---

## 🚀 Quick Start

### Basic PR Health Check

Add this to `.github/workflows/devscope.yml`:

```yaml
name: Code Health

on:
  pull_request:
  push:
    branches: [main]

jobs:
  health-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0  # Full history for git metrics
      
      - uses: EhsanAzish80/devscope-action@v1
```

**That's it!** 🎉

On every PR, you'll get a comment like this:

```
📊 Devscope Report

Maintainability: 🟢 B
Risk: 🟢 Low
Onboarding: Easy
⚡ 0.82s

Full summary ▼
───────────────────────────────────────
Devscope: B · Low risk · Easy onboarding · 0.78 tests · 0.82s ⚡

Analyze your repo → pipx install devscope
Updated: Thu, 13 Feb 2026 15:30:00 GMT
```

---

## 📖 Usage Examples

### With CI Quality Gate

Fail the workflow if maintainability drops below B:

```yaml
- uses: EhsanAzish80/devscope-action@v1
  with:
    fail-under: B
    max-risk: Medium
    max-onboarding: Moderate
```

**Exit codes:**
- `0` = All thresholds passed
- `1` = Runtime error
- `2` = Threshold violated (fails CI)

### Analyze Specific Directory

```yaml
- uses: EhsanAzish80/devscope-action@v1
  with:
    path: ./src
```

### Use Outputs in Other Steps

```yaml
- uses: EhsanAzish80/devscope-action@v1
  id: devscope

- name: Check grade
  run: |
    echo "Grade: ${{ steps.devscope.outputs.grade }}"
    echo "Risk: ${{ steps.devscope.outputs.risk }}"
    
    if [ "${{ steps.devscope.outputs.grade }}" == "F" ]; then
      echo "::warning::Code health is critical!"
    fi
```

### Custom GitHub Token

For private repos or fine-grained permissions:

```yaml
- uses: EhsanAzish80/devscope-action@v1
  with:
    github-token: ${{ secrets.CUSTOM_PAT }}
```

---

## 🔧 Configuration

### Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `path` | Directory to analyze | `.` | No |
| `fail-under` | Minimum grade (A, B, C, D, F) | (none) | No |
| `max-risk` | Maximum risk level (Low, Medium, High) | (none) | No |
| `max-onboarding` | Max onboarding difficulty (Easy, Moderate, Hard) | (none) | No |
| `github-token` | GitHub token for PR comments | `${{ github.token }}` | No |

### Outputs

| Output | Description | Example |
|--------|-------------|---------|
| `health` | Overall health score (0-100) | `82.5` |
| `risk` | Risk level | `Low` |
| `onboarding` | Onboarding difficulty | `Easy` |
| `grade` | Maintainability grade | `B` |

---

## 🎨 PR Comment Format

The action posts a beautifully formatted comment on PRs:

**Collapsed view:**
```
📊 Devscope Report

Maintainability: 🟢 B
Risk: 🟢 Low
Onboarding: Easy
⚡ 0.82s
```

**Expanded view:**
```
📊 Devscope Report

Maintainability: 🟢 B
Risk: 🟢 Low
Onboarding: Easy
⚡ 0.82s

Full summary ▼
───────────────────────────────────────
Devscope: B · Low risk · Easy onboarding · 0.78 tests · 0.82s ⚡

Files: 1,247
Lines: 45,892
Languages: Python (45%) · TypeScript (33%) · JavaScript (12%)

Analyze your repo → pipx install devscope
Updated: Thu, 13 Feb 2026 15:30:00 GMT
```

**Features:**
- ✅ Emoji indicators (🟢 green = good, 🔴 red = bad)
- ✅ Sticky updates (same comment, no spam)
- ✅ Collapsible full summary
- ✅ Timestamp tracking

---

## 📊 Example Workflows

### Full CI/CD Pipeline

```yaml
name: Code Quality

on:
  pull_request:
  push:
    branches: [main, develop]

jobs:
  health-check:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      pull-requests: write
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0  # Required for git metrics
      
      - name: Run Devscope
        uses: EhsanAzish80/devscope-action@v1
        id: devscope
        with:
          fail-under: B
          max-risk: Medium
      
      - name: Upload metrics
        if: always()
        run: |
          echo "Health: ${{ steps.devscope.outputs.health }}"
          echo "Grade: ${{ steps.devscope.outputs.grade }}"
          echo "Risk: ${{ steps.devscope.outputs.risk }}"
```

### Monorepo (Multiple Directories)

```yaml
jobs:
  health-check:
    strategy:
      matrix:
        service: [frontend, backend, shared]
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      
      - uses: EhsanAzish80/devscope-action@v1
        with:
          path: ./services/${{ matrix.service }}
          fail-under: C
```

### Different Thresholds by Branch

```yaml
- uses: EhsanAzish80/devscope-action@v1
  with:
    fail-under: ${{ github.ref == 'refs/heads/main' && 'A' || 'B' }}
    max-risk: ${{ github.ref == 'refs/heads/main' && 'Low' || 'Medium' }}
```

---

## ⚡ Performance

This action uses **aggressive caching** for fast runs:

- **First run:** ~15-20s (install devscope)
- **Cached runs:** ~5-8s (deps cached)
- **devscope analysis:** ~0.5-2s (depending on repo size)

**Total:** Most runs complete in **under 10 seconds** ⚡

---

## 🔒 Permissions

### Required Permissions

```yaml
permissions:
  contents: read          # Read repository code
  pull-requests: write    # Post PR comments
```

**Minimal setup:**
```yaml
jobs:
  health-check:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      pull-requests: write
    steps:
      - uses: actions/checkout@v4
      - uses: EhsanAzish80/devscope-action@v1
```

### For Forks

If you want to support PRs from forks:

```yaml
on:
  pull_request_target:  # Use with caution!

permissions:
  contents: read
  pull-requests: write
```

⚠️ **Security note:** `pull_request_target` runs with write access. Only use if you trust fork contributors or implement additional checks.

---

## 🐛 Troubleshooting

### Comment not appearing on PR

**Check permissions:**
```yaml
permissions:
  pull-requests: write
```

**Verify trigger:**
```yaml
on:
  pull_request:  # Must include this
```

### Action fails with "command not found: devscope"

The action installs devscope automatically. If it fails:

1. Check Python version (requires 3.9+)
2. Clear cache: Go to Actions → Caches → Delete all caches
3. Re-run workflow

### Thresholds not enforced

Thresholds only apply on **push events**, not PRs. PRs show metrics but don't fail.

To enforce on PRs:
```yaml
on:
  pull_request:
  push:
    branches: [main]
```

### Slow analysis

Enable caching:
```yaml
- uses: actions/checkout@v4
  with:
    fetch-depth: 0  # Faster git operations
```

---

## 🔄 Versioning

This action follows semantic versioning:

- `@v1` — Latest v1.x.x (recommended, auto-updates)
- `@v1.0.0` — Exact version (pinned, no updates)
- `@main` — Latest commit (unstable, for testing)

**Recommended:**
```yaml
- uses: EhsanAzish80/devscope-action@v1
```

---

## 📦 What's Included

This action:
- Installs [devscope](https://github.com/EhsanAzish80/Devscope) via pipx
- Caches Python dependencies for speed
- Analyzes your codebase (Python, JS, TS, Go, Rust, Java, etc.)
- Posts formatted PR comments
- Enforces quality gates on push events
- Provides structured outputs for custom workflows

---

## 🤝 Contributing

Contributions welcome! Please:

1. Fork the repo
2. Create a feature branch
3. Test locally with [act](https://github.com/nektos/act)
4. Submit a PR

**Local testing:**
```bash
# Install act
brew install act

# Test workflow
act pull_request -j health-check
```

---

## 📄 License

MIT License - see [LICENSE](LICENSE) file.

---

## 🙏 Acknowledgments

Built with:
- [devscope](https://github.com/EhsanAzish80/Devscope) — The analysis engine
- [actions/github-script](https://github.com/actions/github-script) — PR comment management
- [actions/setup-python](https://github.com/actions/setup-python) — Python setup with caching

---

## 📞 Support

- 🐛 [Report a bug](https://github.com/EhsanAzish80/devscope-action/issues)
- 💡 [Request a feature](https://github.com/EhsanAzish80/devscope-action/issues)
- 💬 [Discussions](https://github.com/EhsanAzish80/devscope-action/discussions)

---

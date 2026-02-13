# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-02-13

### Added
- Initial release of devscope-action
- Composite action for fast startup
- Automatic PR comment posting with sticky updates
- CI quality gates with configurable thresholds
- Outputs for grade, risk, onboarding, and health score
- Intelligent caching for pipx and Python dependencies
- Support for custom paths and GitHub tokens
- Cross-platform support (Linux, macOS, Windows)
- Emoji indicators for visual feedback
- Collapsible full summary in PR comments
- Graceful error handling with detailed output
- Example workflows for common use cases
- Comprehensive documentation

### Features
- **Inputs:**
  - `path` - Directory to analyze
  - `fail-under` - Minimum grade threshold
  - `max-risk` - Maximum risk level
  - `max-onboarding` - Maximum onboarding difficulty
  - `github-token` - Custom token for PR comments

- **Outputs:**
  - `health` - Overall health score (0-100)
  - `risk` - Risk level (Low, Medium, High)
  - `onboarding` - Onboarding difficulty (Easy, Moderate, Hard)
  - `grade` - Maintainability grade (A-F)

- **Behavior:**
  - On PRs: Post/update health comment
  - On push: Enforce thresholds if configured
  - Automatic caching for speed
  - Hidden marker for comment deduplication

### Documentation
- Complete README with usage examples
- Example workflows (basic, advanced, monorepo)
- Troubleshooting guide
- Contributing guidelines
- MIT License

[1.0.0]: https://github.com/EhsanAzish80/devscope-action/releases/tag/v1.0.0

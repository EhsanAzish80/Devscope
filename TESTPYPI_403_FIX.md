# 🚨 TestPyPI 403 Forbidden - Setup Required

## Problem
The release workflow failed with:
```
ERROR HTTPError: 403 Forbidden from https://test.pypi.org/legacy/
```

This means **TestPyPI trusted publishing is not configured yet**.

---

## ✅ Solution: Configure TestPyPI Trusted Publishing

### Step 1: Go to TestPyPI Trusted Publishers
**URL**: https://test.pypi.org/manage/account/publishing/

### Step 2: Add Pending Publisher
Click **"Add a new pending publisher"** and fill in:

```
PyPI Project Name:    devscope
Owner:               EhsanAzish80
Repository name:      Devscope          (⚠️ Case-sensitive! Capital D)
Workflow name:        release.yml
Environment name:     testpypi
```

### Step 3: Save
Click **"Add"** to create the pending publisher.

---

## 🔄 After Configuration: Retry Release

Once TestPyPI is configured, you have two options:

### Option A: Delete and Re-Push Tag (Fastest)
```bash
# Delete the tag locally
git tag -d v0.1.0

# Delete the tag on GitHub
git push --delete origin v0.1.0

# Re-create and push the tag
git tag -a v0.1.0 -m "Release v0.1.0 - Initial public release"
git push origin v0.1.0
```

### Option B: Re-run Failed Workflow
1. Go to: https://github.com/EhsanAzish80/Devscope/actions/workflows/release.yml
2. Click on the failed workflow run
3. Click **"Re-run all jobs"** button

---

## 📝 Why This Happens

Trusted publishing requires **pre-configuration** on PyPI/TestPyPI before the first release:

1. ✅ **GitHub Actions** → Generates OIDC token
2. ❌ **TestPyPI** → "I don't know this repo" → **403 Forbidden**
3. ✅ **After config** → TestPyPI trusts the repo → Publish succeeds

The pending publisher tells TestPyPI: *"When this specific GitHub repo pushes via this workflow, trust it and create the project."*

---

## 🎯 Production Release (PyPI)

After TestPyPI works, repeat the setup for production:

**URL**: https://pypi.org/manage/account/publishing/

```
PyPI Project Name:    devscope
Owner:               EhsanAzish80
Repository name:      Devscope
Workflow name:        release.yml
Environment name:     pypi           (⚠️ Different from testpypi!)
```

---

## 🔍 Verification Checklist

Before retrying, confirm:

- [ ] TestPyPI account created: https://test.pypi.org/account/register/
- [ ] Pending publisher added with **exact** values above
- [ ] GitHub environment `testpypi` exists (already created by workflow)
- [ ] Repository name is `Devscope` (capital D - case matters!)

---

## 🚀 Expected Workflow After Config

```
✅ Build distribution packages
✅ Publish to TestPyPI (will succeed after config!)
✅ Publish to PyPI (will succeed after PyPI config)
✅ Create GitHub Release with signed artifacts
```

Then you can test installation:
```bash
pipx install --index-url https://test.pypi.org/simple/ --pip-args="--extra-index-url https://pypi.org/simple/" devscope
```

---

**Next step**: Configure TestPyPI trusted publishing, then retry the release! 🎯

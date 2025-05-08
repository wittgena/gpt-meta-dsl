# ✅ Automated PR Review Execution Guide (Latest Integrated Version)

---

## 🧰 Prerequisites

### 1. Required Tools

Make sure the following are installed:

- `gh` (GitHub CLI)
- `jq` (JSON parser)
- `git` (for commit diff comparison)

```bash
brew install gh jq git
```

### 2. Install Static Review Template

```bash
mkdir -p ~/bin
cp pr-review-template-prompt.md ~/bin/pr-review-template-prompt.md
```

> The template file must contain the placeholder `{{PR_INFO}}`.

---

## 🚀 How to Execute

### 🔁 One-Command Execution

```bash
./run-pr-review.sh <PR_NUMBER>
```

Example:

```bash
./run-pr-review.sh 675
```

---

## 🔧 Workflow Summary

| Step | Description | Output |
|------|-------------|--------|
| Extract PR Info | Retrieves PR title, body, URL, and changed commit range | `template_prompt_<PR>.md` (temporary) |
| Merge Template | Inserts PR info into `{{PR_INFO}}` in static template | `pr-review-prompt-<PR>.md` |
| Zip Changed Files | Archives only changed files from PR | `pr-review-files-<PR>.zip` |
| Cleanup | Deletes temporary info file | -- |

---

## 📂 Output Files Overview

| File | Purpose |
|------|---------|
| `pr-review-prompt-<PR>.md` | Final template to paste into GPT |
| `pr-review-files-<PR>.zip` | Code bundle for GPT review |

---

## 🤖 How to Request GPT Review

1. Open ChatGPT in your browser.
2. Paste the full content of `pr-review-prompt-<PR>.md`.
3. Upload `pr-review-files-<PR>.zip`.
4. Ask GPT:

```
Please review this PR based on the provided template.
```

---

## 🧠 Advanced Commands for GPT

| Command | Purpose |
|---------|---------|
| `+critic:` | Request critique on structure |
| `+eval:` | Request structural/stability/performance evaluation |
| `+refactor:` | Request refactoring suggestions |
| `+simulation:` | Simulate test scenarios or fallbacks |
| `+val:` | Analyze value or reasoning of design choices |
| `+update:` | Re-review after reflecting changes |

---

### 📝 Example Prompts

```
+critic: Analyze whether ProductController has too many responsibilities
+refactor: Convert KeywordFetcher into a Strategy pattern
+simulation: Verify fallback behavior under failure conditions
```

---

## 📌 Notes

- If the `{{PR_INFO}}` placeholder is missing in the template, the final prompt will be empty.
- If no files have changed in the PR, no zip will be generated.
- GitHub CLI must be authenticated. Run `gh auth login` if needed.

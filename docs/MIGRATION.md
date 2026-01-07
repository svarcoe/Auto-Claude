# Migration Guide: OpenSpec-Style Spec Storage

**Last Updated**: 2026-01-07

## Overview

Auto-Claude has transitioned from gitignoring all `.auto-claude/` data to following OpenSpec conventions by committing specs, roadmaps, and work items to version control. This enables team collaboration and transparent AI-driven development.

This guide helps you migrate existing projects from gitignored specs to committed specs.

## What Changed?

### Before (Gitignored Specs)
```
.gitignore:
  .auto-claude/           # Everything gitignored
  .auto-claude-security.json
  .worktrees/
```

### After (OpenSpec-Style)
```
.gitignore:
  # Specs are now COMMITTED
  # Only security files are gitignored:
  .auto-claude-security.json
  .auto-claude-status
  .security-key
  logs/security/
  .auto-claude/**/*.log
  .auto-claude/**/debug/
  .worktrees/
```

## Migration Options

### Option 1: Commit All Existing Specs (Recommended)

**Best for**: Teams wanting full transparency and collaboration

```bash
cd your-project/

# 1. Remove .auto-claude/ from .gitignore
sed -i '/.auto-claude\//d' .gitignore

# 2. Ensure security files are gitignored
echo "# Auto-Claude security files (do not commit)" >> .gitignore
echo ".auto-claude-security.json" >> .gitignore
echo ".auto-claude-status" >> .gitignore
echo ".security-key" >> .gitignore
echo "logs/security/" >> .gitignore
echo ".auto-claude/**/*.log" >> .gitignore
echo ".auto-claude/**/debug/" >> .gitignore

# 3. Review what will be committed
git add .auto-claude/
git status

# 4. Commit specs to repository
git commit -m "feat: commit Auto-Claude specs for team collaboration (OpenSpec-style)

- Specs, roadmaps, and implementation plans now version controlled
- Security files remain gitignored
- Enables team visibility into AI development process"

# 5. Push to remote (if working with a team)
git push origin your-branch
```

### Option 2: Selectively Commit Specs

**Best for**: Projects with mix of public and private specs

```bash
cd your-project/

# 1. Remove .auto-claude/ from .gitignore
sed -i '/.auto-claude\//d' .gitignore

# 2. Add security exclusions
echo ".auto-claude-security.json" >> .gitignore
echo ".auto-claude-status" >> .gitignore
echo ".security-key" >> .gitignore
echo "logs/security/" >> .gitignore
echo ".auto-claude/**/*.log" >> .gitignore
echo ".auto-claude/**/debug/" >> .gitignore

# 3. Gitignore specific specs you want to keep private
echo "# Private specs" >> .gitignore
echo ".auto-claude/specs/001-internal-feature/" >> .gitignore
echo ".auto-claude/specs/002-secret-project/" >> .gitignore

# 4. Commit public specs only
git add .auto-claude/
git status  # Verify only public specs are staged
git commit -m "feat: commit public Auto-Claude specs"
```

### Option 3: Stay with Gitignored Specs

**Best for**: Solo developers or projects requiring complete privacy

```bash
cd your-project/

# Simply keep .auto-claude/ in your .gitignore
# No action needed - existing behavior continues to work
# But you won't get the benefits of team collaboration
```

## Verification

After migration, verify the setup:

```bash
# 1. Check what's tracked by git
git ls-files .auto-claude/

# Should show:
# .auto-claude/specs/001-feature/spec.md
# .auto-claude/specs/001-feature/requirements.json
# .auto-claude/roadmap/roadmap.md
# etc.

# 2. Verify security files are NOT tracked
git ls-files .auto-claude/ | grep security

# Should be empty (no results)

# 3. Verify gitignore entries
cat .gitignore | grep auto-claude

# Should show security files only, NOT .auto-claude/
```

## What Gets Committed?

### ✅ Committed to Repository
- `.auto-claude/specs/*/spec.md` - Feature specifications
- `.auto-claude/specs/*/requirements.json` - Structured requirements
- `.auto-claude/specs/*/context.json` - Codebase context
- `.auto-claude/specs/*/implementation_plan.json` - Implementation plans and QA history
- `.auto-claude/roadmap/` - Project roadmap files
- `.auto-claude/project_index.json` - Detected project capabilities

### 🔒 Gitignored (Security/Runtime Files)
- `.auto-claude-security.json` - Security profile with command allowlists
- `.auto-claude-status` - Runtime status markers
- `.security-key` - Security key file
- `logs/security/` - Security audit logs
- `.auto-claude/**/*.log` - Log files
- `.auto-claude/**/debug/` - Debug directories
- `.worktrees/` - Temporary git worktrees

## Benefits of OpenSpec-Style Storage

### For Teams
- **Visibility**: Everyone sees specs, plans, and QA results
- **Collaboration**: Review and improve AI-generated specs
- **Onboarding**: New team members understand project decisions
- **Documentation**: Specs serve as living documentation

### For Solo Developers
- **History**: Track how specs evolved over time
- **Cross-Device**: Access specs from multiple machines
- **Backup**: Specs backed up with your code
- **Transparency**: Clear record of what AI built and why

## Security Considerations

### ⚠️ What to Watch Out For

1. **Secrets in Specs**: Ensure specs don't contain:
   - API keys or tokens
   - Database passwords
   - Internal URLs or IP addresses
   - Customer data or PII

2. **Proprietary Information**: Be careful if specs contain:
   - Trade secrets
   - Unreleased feature plans
   - Competitive strategies

3. **Security Files**: Never commit:
   - `.auto-claude-security.json` (contains command allowlists)
   - `.security-key`
   - Security audit logs

### ✅ Best Practices

- Review specs before committing (use `git diff .auto-claude/`)
- Use `.gitignore` patterns to exclude sensitive specs
- Consider private repos for projects with sensitive specs
- Regular security audits of committed specs

## Troubleshooting

### Issue: Accidentally Committed Security Files

```bash
# Remove from git but keep file locally
git rm --cached .auto-claude-security.json
git rm --cached .security-key

# Add to gitignore
echo ".auto-claude-security.json" >> .gitignore
echo ".security-key" >> .gitignore

# Commit the fix
git commit -m "fix: remove security files from git tracking"

# Optional: Purge from history (use with caution)
# git filter-branch --force --index-filter \
#   "git rm --cached --ignore-unmatch .auto-claude-security.json" \
#   --prune-empty --tag-name-filter cat -- --all
```

### Issue: Large Spec Files

If your specs are very large and bloating the repository:

```bash
# Use Git LFS for large files
git lfs track ".auto-claude/specs/*/large_file.json"
git add .gitattributes
git commit -m "chore: track large spec files with Git LFS"
```

### Issue: Want to Revert to Gitignored Specs

```bash
# 1. Add .auto-claude/ back to gitignore
echo ".auto-claude/" >> .gitignore

# 2. Remove from git tracking (keeps files locally)
git rm -r --cached .auto-claude/

# 3. Commit the change
git commit -m "chore: revert to gitignored Auto-Claude specs"
```

## FAQ

**Q: Will this break existing Auto-Claude projects?**
A: No. Existing projects with gitignored specs continue to work unchanged. This only affects new projects or projects where you explicitly migrate.

**Q: Can I mix committed and gitignored specs?**
A: Yes! Use `.gitignore` patterns to gitignore specific specs while committing others.

**Q: What about private repositories?**
A: Even in private repos, committing specs enables team collaboration and version history tracking.

**Q: How big will my repository get?**
A: Specs are typically small (10-50KB each). A project with 100 specs adds ~1-5MB to repository size.

**Q: Can I see an example?**
A: Yes! The Auto-Claude repository itself now uses OpenSpec-style committed specs. Check `.auto-claude/` in the repo.

## Support

If you encounter issues during migration:

1. Check the updated [CLAUDE.md](../CLAUDE.md) for current documentation
2. Review [auto-claude/init.py](../apps/backend/init.py) for gitignore logic
3. Open an issue on GitHub with your migration scenario

---

**Related Documentation**:
- [CLAUDE.md](../CLAUDE.md) - Main project documentation
- [README.md](../README.md) - Project overview
- [OpenSpec Documentation](https://github.com/openspec-ai/openspec) - OpenSpec conventions

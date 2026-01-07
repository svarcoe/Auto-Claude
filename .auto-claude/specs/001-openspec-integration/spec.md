# Spec: OpenSpec-Style Spec Storage Integration

**Spec ID**: 001-openspec-integration
**Created**: 2026-01-07
**Status**: In Progress
**Complexity**: Standard

## Overview

Transform Auto-Claude from using private, gitignored specs to OpenSpec-style committed specs that enable team collaboration and transparency. This aligns Auto-Claude with the OpenSpec ecosystem while maintaining security and backward compatibility.

## Background

Currently, Auto-Claude gitignores all `.auto-claude/` data (specs, plans, QA reports, roadmaps). This approach:
- ✅ Keeps specs private
- ✅ Prevents clutter in git history
- ❌ Hinders team collaboration
- ❌ Loses spec evolution history
- ❌ Diverges from OpenSpec conventions

OpenSpec advocates for committing specs to version control for:
- Team visibility into AI development process
- Spec evolution tracking
- Knowledge sharing across team members
- Transparent AI-driven development

## Objectives

1. **Enable Spec Commits**: Allow `.auto-claude/` directory to be committed to repositories
2. **Maintain Security**: Keep security-sensitive files gitignored
3. **Backward Compatibility**: Don't break existing projects with gitignored specs
4. **Documentation**: Update all docs to reflect OpenSpec approach
5. **Migration Path**: Provide guidance for existing users

## Requirements

### Functional Requirements

1. **F1**: New Auto-Claude projects MUST NOT add `.auto-claude/` to `.gitignore` by default
2. **F2**: Security files MUST remain gitignored:
   - `.auto-claude-security.json`
   - `.auto-claude-status`
   - `.security-key`
   - `logs/security/`
   - `.auto-claude/**/*.log`
   - `.auto-claude/**/debug/`
3. **F3**: Worktrees (`.worktrees/`) MUST remain gitignored (temporary build isolation)
4. **F4**: Merge logic MUST safely handle committed specs
5. **F5**: Documentation MUST explain spec storage approach clearly

### Non-Functional Requirements

1. **NF1**: Existing projects with gitignored specs continue to work
2. **NF2**: No breaking changes to spec file formats
3. **NF3**: Clear migration guide for users wanting to commit existing specs
4. **NF4**: Tests verify correct gitignore behavior

## Implementation Plan

### Phase 1: Gitignore Updates ✅ COMPLETED
- [x] Update root `.gitignore` to allow `.auto-claude/` directory
- [x] Keep security files gitignored
- [x] Keep worktrees gitignored

### Phase 2: Initialization Changes
- [ ] Update `apps/backend/init.py`:
  - Remove `.auto-claude/` from `AUTO_CLAUDE_GITIGNORE_ENTRIES`
  - Keep security entries in gitignore list
  - Update `init_auto_claude_dir()` logic
- [ ] Add comment explaining OpenSpec approach in `init.py`

### Phase 3: Documentation Updates
- [ ] Update `CLAUDE.md`:
  - Explain spec storage approach
  - Document what's committed vs gitignored
  - Add OpenSpec alignment section
- [ ] Update `README.md`:
  - Add section on spec storage
  - Explain team collaboration benefits
- [ ] Create `docs/MIGRATION.md`:
  - Guide for committing existing specs
  - Command to remove `.auto-claude/` from gitignore
  - Instructions for selective spec sharing

### Phase 4: Worktree & Merge Safety
- [ ] Review `apps/backend/core/worktree.py`:
  - Verify merge logic handles committed specs
  - Ensure no conflicts when specs exist in both branches
  - Test merge behavior with committed `.auto-claude/`
- [ ] Add safety checks for spec conflicts

### Phase 5: Testing
- [ ] Add test: Verify new projects don't gitignore `.auto-claude/`
- [ ] Add test: Verify security files ARE gitignored
- [ ] Add test: Verify worktrees remain gitignored
- [ ] Add test: Verify merge behavior with committed specs
- [ ] Run full test suite to verify backward compatibility

### Phase 6: User Communication
- [ ] Add release notes
- [ ] Update `.env.example` with comments about spec storage
- [ ] Add FAQ section about spec privacy vs collaboration

## Files to Modify

### Core Files
- `apps/backend/init.py` - Remove `.auto-claude/` from gitignore entries
- `.gitignore` - ✅ Already updated

### Documentation
- `CLAUDE.md` - Add OpenSpec storage section
- `README.md` - Update storage approach explanation
- `docs/MIGRATION.md` - New migration guide

### Testing
- `tests/test_init.py` - Add gitignore behavior tests
- `tests/test_worktree.py` - Add merge safety tests

## Acceptance Criteria

### Must Have
1. ✅ `.auto-claude/` directory is NOT added to `.gitignore` by default
2. ✅ Security files remain gitignored (`.auto-claude-security.json`, `.security-key`, etc.)
3. ✅ `.worktrees/` remains gitignored
4. [ ] `CLAUDE.md` documents spec storage approach
5. [ ] Migration guide exists for existing users
6. [ ] Tests verify gitignore behavior
7. [ ] Existing projects continue to work

### Should Have
8. [ ] FAQ section addresses spec privacy concerns
9. [ ] Example `.gitignore` patterns for selective spec sharing
10. [ ] Release notes explain the change

### Nice to Have
11. [ ] CLI command to migrate existing specs: `--commit-specs`
12. [ ] Ability to opt-out via environment variable: `AUTO_CLAUDE_GITIGNORE_SPECS=true`

## Risks & Mitigation

| Risk | Impact | Mitigation |
|------|--------|------------|
| Users accidentally commit secrets in specs | HIGH | Keep security files gitignored; add docs warning |
| Merge conflicts on specs | MEDIUM | Test merge logic; document resolution process |
| Breaking existing projects | HIGH | Maintain backward compatibility; thorough testing |
| Users want private specs | MEDIUM | Document how to gitignore selectively; add opt-out |

## Testing Strategy

### Unit Tests
- Gitignore entry generation
- Security file filtering
- Init directory creation

### Integration Tests
- New project initialization
- Spec creation with committed storage
- Worktree creation and merge
- Existing project compatibility

### Manual Testing
- Initialize new project, verify spec commit behavior
- Create spec, verify files are committable
- Merge spec into main, verify no conflicts
- Test existing project with gitignored specs

## Migration Guide (Draft)

For users wanting to commit existing gitignored specs:

```bash
# 1. Remove .auto-claude/ from .gitignore
sed -i '/.auto-claude\//d' .gitignore

# 2. Add security exclusions (if not present)
echo ".auto-claude-security.json" >> .gitignore
echo ".auto-claude-status" >> .gitignore
echo ".security-key" >> .gitignore
echo "logs/security/" >> .gitignore

# 3. Review and commit specs
git add .auto-claude/
git status  # Review what will be committed
git commit -m "feat: commit Auto-Claude specs for team collaboration"
```

## Success Metrics

- [ ] All tests pass
- [ ] Documentation updated and reviewed
- [ ] Zero breaking changes for existing users
- [ ] Positive community feedback on OpenSpec alignment

## Related Work

- **OpenSpec Ecosystem**: Aligns Auto-Claude with OpenSpec conventions
- **Issue #XXX**: Request for team collaboration features
- **Roadmap Q1 2026**: Strategic goal for transparent development

---

**Status**: ✅ Phase 1 Complete | ⏳ Phase 2 In Progress
**Last Updated**: 2026-01-07

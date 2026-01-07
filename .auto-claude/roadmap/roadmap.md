# Auto-Claude Roadmap

**Project**: Auto-Claude
**Type**: Multi-agent autonomous coding framework
**Date Created**: 2026-01-07

## Vision

Auto-Claude is an autonomous coding framework that builds software through coordinated AI agent sessions. The goal is to enable transparent, collaborative development where specs, plans, and progress are visible and version-controlled alongside the code.

## Strategic Goals

### 1. **OpenSpec Integration** 🎯 *Current Focus*
- Commit specs and work items to repository (vs gitignoring)
- Enable team collaboration through version-controlled specs
- Align with OpenSpec ecosystem for transparent AI development
- Maintain backward compatibility with existing projects

### 2. **Multi-Agent Orchestration**
- Enhance subagent spawning capabilities
- Add specialized agents (architect, security, performance)
- Enable parallel agent execution for complex tasks
- Implement agent-to-agent communication protocols

### 3. **Enhanced Memory & Context**
- Improve Graphiti integration for cross-session learning
- Add project-wide memory sharing
- Implement pattern recognition across builds
- Enable memory export/import for team sharing

### 4. **Testing & Quality Automation**
- Expand E2E testing capabilities (Electron, web, API)
- Add automated regression testing
- Implement security scanning integration
- Add performance benchmarking agents

### 5. **Developer Experience**
- Improve CLI UX with better progress indicators
- Add interactive spec editing
- Enhance merge conflict resolution
- Build web dashboard for spec management

### 6. **Enterprise Features**
- Multi-repo support
- Advanced git workflow integration
- Custom agent templates
- Audit logging and compliance

## Current Sprint: OpenSpec Integration

### Objective
Transform Auto-Claude from private, gitignored specs to OpenSpec-style committed specs that enable team collaboration and transparency.

### Tasks
1. ✅ Update .gitignore to commit .auto-claude/ directory
2. ⏳ Update init.py to not add .auto-claude/ to gitignore by default
3. ⏳ Update documentation (CLAUDE.md, README.md)
4. ⏳ Add migration guide for existing users
5. ⏳ Update worktree merge logic for committed specs
6. ⏳ Add tests for spec storage behavior
7. ⏳ Validate backward compatibility

### Success Criteria
- New projects commit specs by default
- Security files remain gitignored
- Existing projects continue to work
- Documentation reflects new approach
- Tests verify correct behavior

## Roadmap Timeline

### Q1 2026 (Current)
- **Week 1-2**: OpenSpec Integration
- **Week 3-4**: Multi-agent orchestration foundation
- **Week 5-6**: Documentation & testing improvements

### Q2 2026
- Enhanced memory system
- Specialized agents (security, performance, architect)
- Advanced E2E testing capabilities

### Q3 2026
- Web dashboard for spec management
- Multi-repo support
- Enterprise features (audit logging, compliance)

### Q4 2026
- Community agent marketplace
- Plugin system for custom tools
- Advanced git workflow automation

## Technical Priorities

1. **Reliability**: Ensure builds are reproducible and safe
2. **Transparency**: All decisions and progress visible in specs
3. **Collaboration**: Enable team-based development workflows
4. **Extensibility**: Support custom agents and tools
5. **Security**: Maintain strict sandbox and permission controls

## Community & Ecosystem

- **OpenSpec Alignment**: Follow OpenSpec conventions for spec format
- **Agent SDK Integration**: Leverage Claude Agent SDK for all AI interactions
- **MCP Tools**: Expand MCP server integrations
- **Documentation**: Comprehensive guides for custom agent development

---

*This roadmap is a living document and will be updated as the project evolves.*

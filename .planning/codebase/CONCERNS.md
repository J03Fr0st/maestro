# Codebase Concerns

**Analysis Date:** 2026-01-30

## Documentation Maintenance Risk

**Inconsistent Agent Naming Convention:**
- Issue: Agent files use mixed naming patterns: `maestro-conductor.agent.md`, `alphabeast.agent.md`, `research.agent.md`
- Files: `.github/agents/*.agent.md` (10 agent files)
- Impact: Inconsistent naming increases cognitive load, makes discovery harder, reduces maintainability
- Fix approach: Standardize to single pattern (recommend `{agent-name}.agent.md` format for all agents)

**Large Agent Definition Files:**
- Issue: `alphabeast.agent.md` (580 lines), `maestro-conductor.agent.md` (417 lines), `maestro-planner.agent.md` (362 lines) are monolithic
- Files: `.github/agents/alphabeast.agent.md`, `.github/agents/maestro-conductor.agent.md`, `.github/agents/maestro-planner.agent.md`
- Impact: Difficult to maintain, hard to find specific sections, requires extensive scrolling
- Fix approach: Consider splitting complex agents into modular sections or breaking monolithic sections into separate `.instructions.md` files

## Content Duplication

**Recent Refactoring Indicates Ongoing Issue:**
- Issue: Recent commit `f5a342a` removed 178 lines of duplicate content from agents by referencing skills instead
- Files: `.github/agents/maestro-debugger.agent.md`, `.github/agents/maestro-implementer.agent.md`, `.github/agents/maestro-reviewer.agent.md`
- Impact: Duplicate content creates maintenance burden—changes must be made in multiple places or become inconsistent
- Fix approach: Continue evaluating agent files for redundant methodology sections; consolidate shared patterns into skills library

**Alpha Beast Agent Contains Tool Definitions:**
- Issue: `alphabeast.agent.md` (lines 147-250) contains detailed tool descriptions that duplicate `.github/instructions/` content
- Files: `.github/agents/alphabeast.agent.md`
- Impact: Multiple sources of truth for tool definitions; if tool behavior changes, inconsistency likely
- Fix approach: Reference tool documentation from instructions instead of embedding in agent

## Architecture Fragility

**Skill Dependency Graph Unclear:**
- Issue: Multiple agents reference overlapping skills without documented dependency order (e.g., `test-driven-development`, `code-review`, `verification-before-completion` used across 4+ agents)
- Files: `.github/agents/maestro-implementer.agent.md`, `.github/agents/maestro-reviewer.agent.md`, `.github/agents/maestro-verifier.agent.md`
- Impact: If a skill is modified, unclear which agents are affected; risk of breaking dependent workflows
- Fix approach: Create skill dependency graph or SKILL_DEPENDENCIES.md documenting which agents require which skills and in what order

**Handoff Workflow Not Fully Documented:**
- Issue: `maestro-implementer.agent.md` and `maestro-reviewer.agent.md` define handoffs but no central registry of workflow paths exists
- Files: `.github/agents/maestro-implementer.agent.md` (lines 1-3), `.github/agents/maestro-reviewer.agent.md` (lines 1-3)
- Impact: Creating new agent handoffs without understanding full workflow graph risks breaking orchestration
- Fix approach: Create `WORKFLOW_GRAPH.md` mapping all handoff paths and agent transitions

## Model Specification Inconsistency

**Model Assignment Varies Without Documentation:**
- Issue: Different agents assigned to different models without documented selection criteria:
  - `maestro-conductor`: Claude Sonnet 4.5
  - `maestro-implementer`: Gemini 3 Flash (Preview)
  - `maestro-reviewer`: GPT-5.2
  - `maestro-verifier`: Claude Sonnet 4.5
  - `alphabeast`: Not specified (defaults to system)
- Files: `.github/agents/maestro-conductor.agent.md`, `.github/agents/maestro-implementer.agent.md`, `.github/agents/maestro-reviewer.agent.md`, `.github/agents/maestro-verifier.agent.md`, `.github/agents/alphabeast.agent.md`
- Impact: No rationale for model selection; difficult to choose models for new agents; potential over-provisioning or under-provisioning
- Fix approach: Create MODEL_SELECTION_CRITERIA.md documenting why each agent uses its assigned model based on complexity/cost/speed trade-offs

## Testing Coverage Gaps

**No Test Coverage Defined:**
- Issue: Maestro system is orchestrated workflow system with no visible test framework, test files, or coverage metrics
- Files: No test files found in repository structure
- Impact: Changes to agent behavior, skill definitions, or workflows have no automated verification; regression detection relies on manual testing
- Fix approach: Define test strategy for maestro agents (test agent prompt execution, skill loading, handoff transitions, error cases); implement at minimum smoke tests

**No End-to-End Verification Process:**
- Issue: Agent system has no documented E2E test showing full workflow: Planning → Implementation → Review → Commit
- Files: No E2E test scenarios in repository
- Impact: System cannot be verified as working without manual testing through all phases
- Fix approach: Create `tests/e2e/orchestration.test.md` documenting and automating representative workflows

## Documentation Quality Issues

**Inconsistent Frontmatter Metadata:**
- Issue: Agent files have inconsistent YAML frontmatter structure:
  - Some specify `name`, some don't
  - Some specify `model`, others use default
  - Some specify `target`, others omit
  - Newer agents have `handoffs`, older ones don't
- Files: All `.github/agents/*.agent.md` files
- Impact: Copilot integration behavior unpredictable; missing optional fields may not load agents correctly in all environments
- Fix approach: Create frontmatter validation; enforce required fields and document all optional fields with examples

**Instructions File Organization Unclear:**
- Issue: `.github/instructions/` contains language and tool-specific files without clear metadata or discovery mechanism
- Files: `.github/instructions/angular.instructions.md`, `.github/instructions/dotnet.instructions.md`, `.github/instructions/typescript.instructions.md`, etc.
- Impact: Agents don't know which instructions apply to their task; instructions not discoverable
- Fix approach: Add instruction selector or tag system; document which instructions apply to which agent contexts

## Orchestration Flow Complexity

**Conductor Pause Points May Block Workflows:**
- Issue: `maestro-conductor.agent.md` defines mandatory pause points (Tech Spec approval, Implementation commit approval)
- Files: `.github/agents/maestro-conductor.agent.md` (lines 46-63)
- Impact: Frequent pauses reduce autonomous work efficiency; unclear how long pause windows can be open
- Fix approach: Document expected pause window durations; consider auto-approval logic for low-risk changes

**Subagent Spawn Limits Not Documented:**
- Issue: `alphabeast.agent.md` encourages spawning subagents "aggressively" but no limits, cost tracking, or parallelization strategy defined
- Files: `.github/agents/alphabeast.agent.md` (lines 10-18)
- Impact: Risk of excessive parallel agent spawning consuming resources or hitting rate limits
- Fix approach: Define maximum concurrent subagents, cost budgets, and backpressure mechanisms

## Technical Debt Summary

### Low Priority
- Mixed agent naming conventions (naming consistency issue)
- Large agent files (readability/maintainability)
- Skill dependency graph unclear (complexity management)

### Medium Priority
- Content duplication between agents and skills (maintenance risk)
- Model specification inconsistency (selection criteria missing)
- Inconsistent frontmatter metadata (integration reliability)

### High Priority
- No test coverage for agent orchestration (verification risk)
- No E2E workflow tests (regression risk)
- Orchestration complexity with pause points (workflow efficiency)
- Subagent spawning without limits (resource risk)

---

*Concerns audit: 2026-01-30*

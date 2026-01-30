# Architecture

**Analysis Date:** 2026-01-30

## Pattern Overview

**Overall:** Multi-Agent Orchestration with Role-Based Specialization

**Key Characteristics:**
- Distributed agent architecture with specialized roles (Conductor, Planner, Implementer, Reviewer, Verifier, Mapper, Debugger)
- Hierarchical delegation model where Conductor orchestrates subagents
- Configuration-driven declarative agent definitions using YAML frontmatter + Markdown
- Skill-based knowledge encapsulation following Agent Skills specification
- Goal-backward planning (defining observable truths before tasks)
- Structured workflow gates (planning approval → implementation → review → verification)

## Layers

**Orchestration Layer:**
- Purpose: Coordinate multi-agent workflows and enforce quality gates
- Location: `.github/agents/maestro-conductor.agent.md`
- Contains: Conductor agent definition, workflow coordination rules, skill integration guidance
- Depends on: Subagent invocation capability, plan file system
- Used by: End users initiating development workflows

**Planning Layer:**
- Purpose: Investigate codebase context and generate implementation specifications
- Location: `.github/agents/maestro-planner.agent.md`
- Contains: Context gathering methodology, goal-backward planning approach, Tech Spec generation rules
- Depends on: Codebase introspection tools, writing-plans skill
- Used by: Conductor for creating executable Tech Specs

**Implementation Layer:**
- Purpose: Execute implementation tasks using strict Test-Driven Development
- Location: `.github/agents/maestro-implementer.agent.md`
- Contains: TDD workflow enforcement, command execution rules, deviation handling (auto-fix bugs, scope management)
- Depends on: Test execution tools, build verification, code quality tools
- Used by: Conductor to realize plans into working code

**Review Layer:**
- Purpose: Validate implementations against Tech Specs, check quality and security
- Location: `.github/agents/maestro-reviewer.agent.md`
- Contains: Two-stage review protocol (spec compliance then quality), verdict system (APPROVED/NEEDS_REVISION/FAILED)
- Depends on: Code quality tools, code-review skill
- Used by: Conductor to gate code before commit

**Verification Layer:**
- Purpose: Verify phase goals achieved (not just tasks completed), validate observable truths
- Location: `.github/agents/maestro-verifier.agent.md`
- Contains: Must-haves extraction (truths, artifacts, key links), artifact substantiveness checking, wiring validation
- Depends on: verification-before-completion skill, code introspection
- Used by: Conductor to confirm goal achievement before moving forward

**Analysis Layer:**
- Purpose: Explore codebase and create structured analysis documents
- Location: `.github/agents/maestro-mapper.agent.md`
- Contains: Analysis type specifications (STACK, ARCHITECTURE, CONVENTIONS, TESTING, CONCERNS), document format guidance
- Depends on: Read, search, execute tools
- Used by: Planner, Implementer, and other agents for codebase context

**Debugging Layer:**
- Purpose: Systematic root cause investigation using scientific method
- Location: `.github/agents/maestro-debugger.agent.md`
- Contains: Systematic debugging methodology, hypothesis testing workflow
- Depends on: systematic-debugging skill
- Used by: Conductor for investigating failures

**Autonomous Layer:**
- Purpose: Autonomous problem-solving with aggressive parallelization
- Location: `.github/agents/alphabeast.agent.md`, `.github/agents/betabeast.agent.md`
- Contains: Parallel task execution, subagent spawning, continuous problem-solving
- Depends on: Full toolset access, subagent capabilities
- Used by: Power users for complex autonomous tasks

## Data Flow

**Planning Phase:**
1. Conductor asks user for requirements
2. User provides feature description
3. Conductor invokes Planner subagent
4. Planner gathers context from codebase
5. Planner loads codebase analysis documents (from .planning/codebase/)
6. Planner generates Tech Spec with must-haves (observable truths, artifacts, key links)
7. Tech Spec saved to `/plan/` directory
8. Conductor reviews with user and seeks approval

**Implementation Phase:**
1. Conductor invokes Implementer with Tech Spec path
2. Implementer executes TDD cycle per phase
3. Tests written first (RED), then implementation (GREEN)
4. Implementer automatically runs tests and checks for build errors
5. Implementation checked against phase requirements
6. Implementer reports completion status

**Review Phase:**
1. Conductor invokes Reviewer with implementation details
2. Reviewer validates against Tech Spec acceptance criteria
3. Two-stage review: (1) Spec compliance, (2) Code quality/security
4. Review notes appended to Tech Spec file
5. Reviewer returns verdict: APPROVED | NEEDS_REVISION | FAILED
6. If NEEDS_REVISION, Conductor can invoke Implementer again

**Verification Phase:**
1. Verifier loads Tech Spec and extracts must-haves
2. Verifies observable truths are achievable through artifacts
3. Checks artifact existence, substantiveness (not stubs), and wiring
4. Compares line counts to minimums to detect stubs
5. Confirms integration points between components
6. Reports verification status

**State Management:**
- Plan files (Tech Specs) stored in `/plan/` directory - single source of truth
- Codebase analysis documents stored in `.planning/codebase/` - context for all agents
- Agent definitions stored in `.github/agents/` - declarative specifications
- Skills stored in `.github/skills/` - progressive disclosure knowledge
- Instructions stored in `.github/instructions/` - coding standards by language/context

## Key Abstractions

**Agent:**
- Purpose: Autonomous specialization with specific role and constraints
- Examples: `maestro-conductor.agent.md`, `maestro-implementer.agent.md`, `maestro-reviewer.agent.md`
- Pattern: YAML frontmatter (metadata, tools, model) + Markdown body (identity, responsibilities, workflow)

**Tech Spec:**
- Purpose: Executable specification with requirements, acceptance criteria, testing strategy
- Examples: `/plan/[feature-name].md` (generated by Planner)
- Pattern: Goal statement, must-haves section, task breakdown with file paths, acceptance criteria

**Skill:**
- Purpose: Encapsulated domain knowledge with progressive disclosure
- Examples: `test-driven-development`, `code-review`, `writing-plans`
- Pattern: YAML metadata + main instructions + optional reference materials

**Instruction:**
- Purpose: Language/context-specific coding standards
- Examples: `typescript.instructions.md`, `angular.instructions.md`, `testing.instructions.md`
- Pattern: Markdown guidelines applied automatically based on file type

**Prompt:**
- Purpose: Reusable task template with variable placeholders
- Examples: `commit.prompt.md`, `review.prompt.md`, `planning.prompt.md`
- Pattern: YAML frontmatter + Markdown body with variables (${input:*}, ${selection}, ${file})

**Codebase Analysis Document:**
- Purpose: Structured context about target codebase for planning and implementation
- Examples: STACK.md, ARCHITECTURE.md, CONVENTIONS.md, TESTING.md, CONCERNS.md
- Pattern: Analysis date, prescriptive guidance with file paths, patterns with examples

## Entry Points

**Conductor Agent:**
- Location: `.github/agents/maestro-conductor.agent.md`
- Triggers: User invokes in VS Code Copilot Chat or GitHub Copilot Chat
- Responsibilities: Ask clarifying questions, delegate to specialized agents, enforce quality gates, save plan files

**Individual Agents (as Subagents):**
- Location: `.github/agents/maestro-*.agent.md`
- Triggers: Conductor invokes via agent tool, or user invokes directly
- Responsibilities: Execute specialized role (planning, implementing, reviewing, verifying)

**Mapper Agent:**
- Location: `.github/agents/maestro-mapper.agent.md`
- Triggers: User invokes `/gsd:map-codebase` command with focus area
- Responsibilities: Analyze codebase, write ARCHITECTURE.md, STRUCTURE.md, STACK.md, INTEGRATIONS.md, CONVENTIONS.md, TESTING.md, or CONCERNS.md to `.planning/codebase/`

**Autonomous Agents:**
- Location: `.github/agents/alphabeast.agent.md`, `.github/agents/betabeast.agent.md`
- Triggers: User invokes directly for complex autonomous tasks
- Responsibilities: Parallelize work, spawn subagents, resolve complex problems without interruption

## Error Handling

**Strategy:** Explicit verdict system with escalation

**Patterns:**
- Implementer: Auto-fix obvious bugs, document deviations in report
- Reviewer: Return APPROVED/NEEDS_REVISION/FAILED verdicts with actionable feedback
- Verifier: Fail verification if must-haves not met, report specific missing artifacts
- All agents: Document findings in structured files (Tech Spec annotations, analysis documents)

## Cross-Cutting Concerns

**Logging:** Agents log findings in plan files (Tech Spec) and analysis documents (ARCHITECTURE.md, TESTING.md, etc.)

**Validation:**
- Planner uses goal-backward planning to validate scope before implementation
- Implementer validates code via TDD
- Reviewer validates against Tech Spec acceptance criteria
- Verifier validates observable truths

**Authentication & Authorization:**
- Agents inherit user's authentication context
- Conductor enforces mandatory approval gates
- Agents constrained by handoff definitions and tool access controls

---

*Architecture analysis: 2026-01-30*

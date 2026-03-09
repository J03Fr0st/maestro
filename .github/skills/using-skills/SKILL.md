---
name: using-skills
description: >
  Check and invoke skills when starting tasks that might benefit from specialized
  workflows. Triggers: beginning a new task, planning an approach, exploring the
  codebase, writing code, debugging, refactoring, or any work where project
  conventions matter.
---

# Using Skills

Skills encode hard-won project conventions, prevent common mistakes, and provide
tested workflows. Skipping a relevant skill means rediscovering lessons the team
already learned — or worse, introducing bugs the skill was written to prevent.

## How to Access Skills

**In Claude Code:** Use the `Skill` tool. Invoking a skill loads its content for
you to follow directly. Do not use the Read tool on skill files — the Skill tool
handles loading.

**In other environments:** Check your platform's documentation for how skills are
loaded.

## Skill Check Process

Follow these steps when you receive a new task:

1. **Scan available skills** — review the skill list for anything related to the
   task at hand (even tangentially).
2. **Invoke matching skills** — if a skill might apply, invoke it. If it turns
   out to be irrelevant after reading, move on. The cost of checking is low; the
   cost of skipping is high.
3. **Announce your choice** — tell the user which skill you are applying and why
   (e.g., "Using the TDD skill because this task adds new functionality").
4. **Follow the skill** — if the skill includes a checklist, track each item.
   Apply the skill's guidance throughout the task, not just at the start.

## Skill Priority

When multiple skills could apply, load process skills first, then implementation
skills:

- **Process skills** (brainstorming, debugging, TDD) determine *how* to approach
  the task. Load these first because they shape the entire workflow.
- **Implementation skills** (language patterns, framework conventions) guide
  execution within that workflow.

Example: "Build feature X" — load brainstorming first, then implementation
skills. "Fix this bug" — load debugging first, then domain-specific skills.

## Matching Skills to Tasks

Quick guidance for common situations:

- **"Add a feature" / "Build X"** — check for brainstorming, architecture, and
  relevant language/framework skills.
- **"Fix a bug" / "Debug this"** — check for debugging and testing skills.
- **"Refactor" / "Clean up"** — check for code-quality and pattern skills.
- **"Write tests"** — check for TDD or testing skills.
- **"Explore the codebase"** — skills often describe *how* to explore
  effectively. Check before diving in.
- **Clarifying questions** — check for skills even before asking follow-up
  questions. A skill may tell you exactly what context to gather.

## Skill Types

**Rigid skills** (TDD, debugging): Follow the prescribed steps exactly. These
skills exist because deviation leads to known failure modes.

**Flexible skills** (patterns, conventions): Adapt the principles to context.
The skill itself indicates which type it is.

## Relationship Between Skills and User Instructions

User instructions define *what* to do ("Add feature X", "Fix bug Y"). Skills
define *how* to do it well. A direct user instruction does not override the
workflow a skill provides — apply both together.

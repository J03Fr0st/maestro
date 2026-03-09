---
name: brainstorming
description: >
  Use when users want to brainstorm, explore options, design before building,
  discuss approaches, weigh trade-offs, or ask "what's the best way to..."
  Trigger phrases: "brainstorm", "explore options", "let's design", "discuss
  approaches", "what are our options", "help me think through", "before we
  build", "architecture discussion", "pros and cons".
---

# Brainstorming Ideas Into Designs

## Overview

Help turn ideas into fully formed designs through collaborative dialogue. Understand the project context, ask questions to refine the idea, then present a design for approval.

The depth of this process should scale to the complexity of the request. A config change might need two questions and a paragraph. A new subsystem might need a full design document.

## Why Design Before Implementation

Jumping straight to code feels productive, but unexamined assumptions cause rework. Even "simple" changes benefit from a brief pause to confirm the approach — a few sentences of design thinking can save hours of going down the wrong path. The design can be as short as the situation warrants.

## Process

1. **Explore project context** — check files, docs, recent commits to understand the current state
2. **Ask clarifying questions** — one at a time, understand purpose, constraints, and success criteria
3. **Propose 2-3 approaches** — with trade-offs and your recommendation
4. **Present design** — in sections scaled to complexity, get user approval after each section
5. **Optionally write a design doc** — for non-trivial designs, save to `docs/plans/YYYY-MM-DD-<topic>-design.md` and commit
6. **Transition to implementation** — if the writing-plans skill is available, suggest using it to create an implementation plan; otherwise, move directly to implementation

## Understanding the Idea

- Check out the current project state first (files, docs, recent commits)
- Ask questions one at a time to refine the idea
- Prefer multiple choice questions when possible, but open-ended is fine too
- Only one question per message — if a topic needs more exploration, break it into multiple questions
- Focus on understanding: purpose, constraints, success criteria

## Exploring Approaches

- Propose 2-3 different approaches with trade-offs
- Present options conversationally with your recommendation and reasoning
- Lead with your recommended option and explain why

## Presenting the Design

- Once you believe you understand what you're building, present the design
- Scale each section to its complexity: a few sentences if straightforward, up to 200-300 words if nuanced
- Ask after each section whether it looks right so far
- Cover as appropriate: architecture, components, data flow, error handling, testing
- Be ready to go back and clarify if something doesn't make sense

## After the Design

**Documentation (for non-trivial designs):**
- Write the validated design to `docs/plans/YYYY-MM-DD-<topic>-design.md`
- Commit the design document to git

**Implementation:**
- If the writing-plans skill is available, suggest using it to create a detailed implementation plan
- If writing-plans isn't available, proceed with implementation directly, breaking work into logical steps

## Key Principles

- **One question at a time** — don't overwhelm with multiple questions
- **Multiple choice preferred** — easier to answer than open-ended when possible
- **YAGNI ruthlessly** — remove unnecessary features from all designs
- **Explore alternatives** — propose 2-3 approaches before settling
- **Incremental validation** — present design, get approval before moving on
- **Scale to complexity** — a one-paragraph design is fine for simple changes
- **Be flexible** — go back and clarify when something doesn't make sense

## Example: Simple Change

**User:** "What's the best way to add rate limiting to our API?"

1. Check existing middleware, framework, and API structure
2. Ask: "Are you looking to limit per-user, per-endpoint, or globally?"
3. Propose: token bucket vs. sliding window vs. fixed window, with trade-offs
4. Present: recommended approach in a few paragraphs
5. On approval: move to implementation

## Example: Complex Feature

**User:** "Let's brainstorm a notification system"

1. Explore existing infrastructure (message queues, email services, database)
2. Ask a series of questions: channels needed? real-time vs. batched? user preferences?
3. Propose architectural options with diagrams if helpful
4. Present design in sections (data model, delivery pipeline, preference management, failure handling)
5. Write design doc and commit
6. Suggest creating an implementation plan

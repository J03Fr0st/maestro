---
name: brainstorming
description: Interactive design exploration before implementation. Use before any creative work - creating features, building components, or modifying behavior.
---

# Brainstorming Ideas Into Designs

Help turn ideas into fully formed designs through collaborative dialogue.

## When to Use

**Always before:**
- Creating new features
- Building new components
- Modifying existing behavior
- Any creative work

## The Process

### Understanding the Idea

1. **Check project context first** - files, docs, recent commits
2. **Ask questions one at a time** - don't overwhelm
3. **Prefer multiple choice** when possible
4. **Focus on:** purpose, constraints, success criteria

### Exploring Approaches

1. **Propose 2-3 different approaches** with trade-offs
2. **Lead with your recommendation** and explain why
3. **Present options conversationally**

### Presenting the Design

1. **Break into sections** of 200-300 words
2. **Ask after each section** if it looks right
3. **Cover:** architecture, components, data flow, error handling, testing
4. **Be ready to go back** and clarify

## After the Design

**Documentation:**
- Write validated design to `docs/plans/YYYY-MM-DD-<topic>-design.md`
- Commit the design document

**Implementation (if continuing):**
- Ask: "Ready to set up for implementation?"
- Create detailed implementation plan

## Key Principles

| Principle | Description |
|-----------|-------------|
| One question at a time | Don't overwhelm |
| Multiple choice preferred | Easier to answer |
| YAGNI ruthlessly | Remove unnecessary features |
| Explore alternatives | Always propose 2-3 approaches |
| Incremental validation | Present design in sections |
| Be flexible | Go back when unclear |

## Example Flow

```
You: "What problem does this solve?"
User: "Users can't track their spending"

You: "Two approaches:
1. Simple list view (recommended - fastest)
2. Dashboard with charts (more visual)

I'd recommend option 1 because..."
User: "Option 1"

You: "Here's the component structure: [200 words]
Does this look right so far?"
User: "Yes"

You: "Here's the data flow: [200 words]..."
```

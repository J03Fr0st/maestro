# Plan Template

Use this template when creating implementation plans.

## Full Plan Template

```markdown
# [Feature Name] Implementation Plan

**Goal:** [One sentence describing what this builds]

**Architecture:** [2-3 sentences about approach]

**Tech Stack:** [Key technologies]

---

## Task 1: [Component Name]

**Files:**
- Create: `exact/path/to/file.py`
- Modify: `exact/path/to/existing.py:123-145`
- Test: `tests/exact/path/to/test.py`

**Step 1: Write the failing test**

```python
# tests/exact/path/to/test.py
def test_feature_does_something():
    result = feature_function(input)
    assert result == expected_output
```

**Step 2: Run test to verify it fails**

Run: `pytest tests/path/test.py::test_feature_does_something -v`
Expected: FAIL with "function not defined" or similar

**Step 3: Write minimal implementation**

```python
# src/exact/path/to/file.py
def feature_function(input):
    # Minimal implementation to pass the test
    return expected_output
```

**Step 4: Run test to verify it passes**

Run: `pytest tests/path/test.py::test_feature_does_something -v`
Expected: PASS

**Step 5: Commit**

```bash
git add tests/path/test.py src/path/file.py
git commit -m "feat: add specific feature"
```

---

## Task 2: [Next Component Name]

**Files:**
- Create: `exact/path/to/next_file.py`
- Test: `tests/exact/path/to/next_test.py`

**Step 1: Write the failing test**

[Complete test code]

**Step 2: Run test to verify it fails**

Run: `[exact command]`
Expected: FAIL with "[specific error]"

**Step 3: Write minimal implementation**

[Complete implementation code]

**Step 4: Run test to verify it passes**

Run: `[exact command]`
Expected: PASS

**Step 5: Commit**

```bash
git add [files]
git commit -m "feat: add next feature"
```

---

## Task N: [Final Component]

[Continue pattern...]

---

## Final Verification

**Run full test suite:**
```bash
pytest tests/ -v
```
Expected: All tests PASS

**Build verification (if applicable):**
```bash
[build command]
```
Expected: Build succeeds with no errors
```

## Template Rules

1. **Header is required** - Goal, Architecture, Tech Stack
2. **One action per step** - Never combine actions
3. **Complete code blocks** - No "add validation here" placeholders
4. **Exact file paths** - Include line numbers for modifications
5. **Exact commands** - With expected output
6. **Commit after each task** - With conventional commit message

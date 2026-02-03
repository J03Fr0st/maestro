# Python Rules

Complete rule catalog for Python.

---

## Python-Specific Examples

### S5806: Class methods should reference self
```python
# Non-compliant
class MyClass:
    def process(self):
        return compute()  # self not used

# Compliant - use @staticmethod
class MyClass:
    @staticmethod
    def process():
        return compute()
```

### S5719: Instance and class methods should have at least one positional parameter
```python
# Non-compliant
class MyClass:
    def process():  # Missing self!
        pass

# Compliant
class MyClass:
    def process(self):
        pass
```

### S5857: Mutable objects should not be default arguments
```python
# Non-compliant
def add_item(item, items=[]):  # Mutable default!
    items.append(item)
    return items

# Compliant
def add_item(item, items=None):
    if items is None:
        items = []
    items.append(item)
    return items
```

### S5724: Bare "except" clauses should not be used
```python
# Non-compliant
try:
    risky_operation()
except:  # Catches everything including KeyboardInterrupt
    pass

# Compliant
try:
    risky_operation()
except Exception as e:
    log_error(e)
```

---

## Bugs

| Rule | Name | Severity |
|------|------|----------|
| S930 | Functions should be called with the correct number of arguments | Blocker |
| S1481 | Unused local variables should be removed | Minor |
| S1763 | All code should be reachable | Major |
| S1764 | Identical expressions should not be used on both sides of operators | Major |
| S2159 | Silly identity should not be tested | Major |
| S2190 | Recursion should not be infinite | Blocker |
| S2201 | Return values should not be ignored | Major |
| S2734 | "else" should not be used after "return" | Minor |
| S2757 | "=+" should not be used instead of "+=" | Critical |
| S3403 | Strict equality operators should not be used with dissimilar types | Minor |
| S3516 | Functions returns should not be invariant | Major |
| S3699 | The output of functions that don't return anything should not be used | Major |
| S3862 | "iteritems()" should not be called directly on dict keys | Major |
| S5607 | Packages should not be imported with "*" | Minor |
| S5632 | Arguments to "assert" should not be tuples | Blocker |
| S5704 | The "self" argument should be the first argument of instance methods | Major |
| S5707 | Exceptions should derive from BaseException | Critical |
| S5708 | Only legal exceptions should be caught | Critical |
| S5709 | Exception chaining should be used | Minor |
| S5714 | Boolean values should not be used in exception raising | Major |
| S5719 | Instance and class methods should have at least one positional parameter | Critical |
| S5722 | "__init__" should not return value | Major |
| S5724 | Bare "except" clauses should not be used | Major |
| S5727 | Comparison to None should use the "is" operator | Major |
| S5754 | Exceptions should not be silently swallowed | Major |
| S5756 | Non-empty containers should be evaluated as true | Major |
| S5781 | Iterable unpacking should match target variables | Major |
| S5795 | "TypedDict" keys should be valid | Major |
| S5796 | "TypedDict" definitions should be valid | Major |
| S5799 | Instance methods should access "self" | Major |
| S5806 | "cls" should be the first argument for class methods | Major |
| S5807 | "cls" should not be reassigned | Major |
| S5841 | File descriptors should be explicitly closed | Major |
| S5842 | Regular expressions should be syntactically valid | Blocker |
| S5845 | Arguments should not be unpacked into "pass" | Major |
| S5855 | Walrus operator should not be used in comprehensions | Major |
| S5856 | Regular expressions should be syntactically valid | Blocker |
| S5857 | Mutable objects should not be default arguments | Major |
| S5864 | Unhashable objects should not be added to sets | Major |
| S5868 | Regex flags should not be nested | Minor |
| S5886 | "asyncio.sleep(0)" should not be used | Minor |
| S5905 | All branches of an assertion should be tested | Major |
| S5914 | Comparisons involving length should not be written with negative numbers | Major |
| S5915 | Range should not be empty | Major |
| S6540 | ClassVar should be used | Minor |

## Vulnerabilities

| Rule | Name | Severity |
|------|------|----------|
| S1523 | Code should not be dynamically evaluated | Critical |
| S2068 | Credentials should not be hard-coded | Blocker |
| S2076 | OS commands should not be vulnerable to injection attacks | Blocker |
| S2077 | SQL queries should not be vulnerable to injection attacks | Blocker |
| S2245 | Pseudorandom number generators should not be used in security contexts | Critical |
| S2631 | Regular expressions should not be vulnerable to denial of service attacks | Critical |
| S3649 | Database queries should not be vulnerable to injection attacks | Blocker |
| S4423 | Weak SSL protocols should not be used | Critical |
| S4426 | Cryptographic keys should be robust | Critical |
| S4502 | CSRF protections should not be disabled | Critical |
| S4507 | Debug features should not be activated in production | Critical |
| S4787 | Encrypting data is security-sensitive | Critical |
| S4790 | Hashing data is security-sensitive | Critical |
| S4792 | Configuring logging is security-sensitive | Minor |
| S4830 | Server certificates should be verified | Critical |
| S5042 | Expanding archives is security-sensitive | Critical |
| S5144 | Server-side requests should not be vulnerable to forging attacks | Critical |
| S5146 | Open redirects are security-sensitive | Major |
| S5247 | Cross-site scripting should be prevented | Critical |
| S5334 | DOM updates should be sanitized | Critical |
| S5445 | Insecure temporary file creation is security-sensitive | Major |
| S5527 | Server certificates should be verified | Critical |
| S5547 | Cipher algorithms should be robust | Critical |
| S5659 | JWT signatures should be verified | Critical |
| S5689 | HTTP response headers should not reveal server information | Minor |
| S5713 | Bad syntax in "assert" should not be used | Major |
| S5720 | "os.chmod" should not set unsafe permissions | Major |
| S5725 | "xml" libraries should be used carefully | Critical |
| S5732 | Cookies should be secure | Major |
| S5734 | Referer policy should be restrictive | Minor |
| S5739 | Secure protocol should be used | Major |
| S5753 | Allowing browsers to sniff MIME types is security-sensitive | Minor |
| S5757 | Sensitive data should not be logged | Major |
| S5852 | Regular expressions should not be vulnerable to denial of service | Critical |
| S6105 | Disabling certificate validation is security-sensitive | Critical |

## Code Smells

| Rule | Name | Severity |
|------|------|----------|
| S100 | Function names should comply with a naming convention | Minor |
| S101 | Class names should comply with a naming convention | Minor |
| S103 | Lines should not be too long | Minor |
| S104 | Files should not have too many lines of code | Major |
| S107 | Functions should not have too many parameters | Major |
| S108 | Nested blocks of code should not be left empty | Major |
| S112 | Generic exceptions should not be raised | Major |
| S113 | Files should contain trailing newlines | Minor |
| S117 | Local variable names should comply with a naming convention | Minor |
| S125 | Sections of code should not be commented out | Major |
| S134 | Control flow statements should not be nested too deep | Critical |
| S139 | Comments should not be located at the end of lines of code | Minor |
| S905 | Non-empty statements should change control flow | Major |
| S930 | Functions should be called with the correct number of arguments | Blocker |
| S1066 | Collapsible "if" statements should be merged | Major |
| S1110 | Redundant pairs of parentheses should be removed | Minor |
| S1116 | Empty statements should be removed | Minor |
| S1134 | Track uses of "FIXME" tags | Major |
| S1135 | Track uses of "TODO" tags | Info |
| S1144 | Unused functions should be removed | Major |
| S1172 | Unused function parameters should be removed | Major |
| S1186 | Functions should not be empty | Major |
| S1192 | String literals should not be duplicated | Critical |
| S1481 | Unused local variables should be removed | Minor |
| S1542 | Functions should not be named "lambda" | Major |
| S1656 | "==" should not be used instead of "=" | Blocker |
| S1716 | "pass" should not be used needlessly | Minor |
| S1763 | All code should be reachable | Major |
| S1764 | Identical expressions should not be used on both sides of operators | Major |
| S1854 | Dead stores should be removed | Major |
| S1871 | Two branches in a conditional structure should not have the same implementation | Major |
| S1940 | Boolean checks should not be inverted | Minor |
| S2159 | Silly identity should not be tested | Major |
| S2190 | Recursion should not be infinite | Blocker |
| S2201 | Return values should not be ignored | Major |
| S2208 | Wildcard imports should not be used | Major |
| S2589 | Boolean expressions should not be gratuitous | Major |
| S2711 | "yield" statement should not return values | Major |
| S2712 | "yield from" should only be used with iterables | Major |
| S2734 | "else" should not be used after "return" | Minor |
| S2757 | "=+" should not be used instead of "+=" | Critical |
| S3257 | Redundant statements should not be used | Minor |
| S3358 | Ternary operators should not be nested | Major |
| S3403 | Strict equality operators should not be used with dissimilar types | Minor |
| S3516 | Functions returns should not be invariant | Major |
| S3626 | Jump statements should not be redundant | Minor |
| S3699 | The output of functions that don't return anything should not be used | Major |
| S3776 | Cognitive Complexity of functions should not be too high | Critical |
| S3862 | "iteritems()" should not be called directly on dict keys | Major |
| S4144 | Functions should not have identical implementations | Major |
| S5445 | Insecure temporary file creation is security-sensitive | Major |
| S5603 | "staticmethod" should not be used | Minor |
| S5607 | Packages should not be imported with "*" | Minor |
| S5632 | Arguments to "assert" should not be tuples | Blocker |
| S5704 | The "self" argument should be the first argument of instance methods | Major |
| S5707 | Exceptions should derive from BaseException | Critical |
| S5708 | Only legal exceptions should be caught | Critical |
| S5709 | Exception chaining should be used | Minor |
| S5714 | Boolean values should not be used in exception raising | Major |
| S5717 | Default argument values should not be changed | Major |
| S5719 | Instance and class methods should have at least one positional parameter | Critical |
| S5720 | "os.chmod" should not set unsafe permissions | Major |
| S5722 | "__init__" should not return value | Major |
| S5724 | Bare "except" clauses should not be used | Major |
| S5727 | Comparison to None should use the "is" operator | Major |
| S5754 | Exceptions should not be silently swallowed | Major |
| S5756 | Non-empty containers should be evaluated as true | Major |
| S5781 | Iterable unpacking should match target variables | Major |
| S5795 | "TypedDict" keys should be valid | Major |
| S5796 | "TypedDict" definitions should be valid | Major |
| S5797 | Methods of type stubs should not have implementations | Minor |
| S5799 | Instance methods should access "self" | Major |
| S5806 | "cls" should be the first argument for class methods | Major |
| S5807 | "cls" should not be reassigned | Major |
| S5841 | File descriptors should be explicitly closed | Major |
| S5842 | Regular expressions should be syntactically valid | Blocker |
| S5843 | Regular expressions should not be too complicated | Critical |
| S5845 | Arguments should not be unpacked into "pass" | Major |
| S5850 | Alternatives in regular expressions should be grouped | Minor |
| S5852 | Regular expressions should not be vulnerable to denial of service | Critical |
| S5855 | Walrus operator should not be used in comprehensions | Major |
| S5856 | Regular expressions should be syntactically valid | Blocker |
| S5857 | Mutable objects should not be default arguments | Major |
| S5864 | Unhashable objects should not be added to sets | Major |
| S5868 | Regex flags should not be nested | Minor |
| S5886 | "asyncio.sleep(0)" should not be used | Minor |
| S5905 | All branches of an assertion should be tested | Major |
| S5914 | Comparisons involving length should not be written with negative numbers | Major |
| S5915 | Range should not be empty | Major |
| S6327 | Union types should not include redundant types | Minor |
| S6540 | ClassVar should be used | Minor |

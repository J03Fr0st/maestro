# TypeScript/JavaScript Rules

Complete rule catalog for TypeScript and JavaScript.

---

## React-Specific Examples

### S6754: React hooks should be called correctly
```typescript
// Non-compliant
function Component({ condition }) {
  if (condition) {
    const [state, setState] = useState(); // Conditional hook!
  }
}

// Compliant
function Component({ condition }) {
  const [state, setState] = useState();
}
```

### S6582: Optional chaining should be preferred
```typescript
// Non-compliant
const name = user && user.profile && user.profile.name;

// Compliant
const name = user?.profile?.name;
```

### S6598: Arrow functions should be preferred for callbacks
```typescript
// Non-compliant
items.map(function(item) { return item.name; });

// Compliant
items.map(item => item.name);
```

---

## Bugs

| Rule | Name | Severity |
|------|------|----------|
| S1862 | Related "if/else if" statements should not have the same condition | Major |
| S2137 | Special identifiers should not be bound or assigned | Critical |
| S2189 | Loops should not be infinite | Blocker |
| S2201 | Return values from functions without side effects should not be ignored | Major |
| S2259 | Null pointers should not be dereferenced | Major |
| S2310 | Loop counters should not be assigned within the loop body | Critical |
| S2392 | Variables should be used in the blocks where they are declared | Minor |
| S2583 | Conditionally executed code should be reachable | Major |
| S2589 | Boolean expressions should not be gratuitous | Major |
| S2737 | "catch" clauses should do more than rethrow | Major |
| S2871 | "compareFunction" should be passed to Array.sort() | Major |
| S3358 | Ternary operators should not be nested | Major |
| S3699 | The output of functions that don't return anything should not be used | Major |
| S3757 | Arithmetic operations should not result in "NaN" | Major |
| S3758 | Values not convertible to numbers should not be used in numeric comparisons | Major |
| S3798 | Variables and functions should not be redeclared | Major |
| S3799 | Destructuring patterns should not be empty | Major |
| S3812 | Results of bitwise operations on number should be used | Major |
| S3972 | Conditionals should start on new lines | Major |
| S3981 | Collection sizes should be compared correctly | Major |
| S3984 | Exception should not be created without being thrown | Major |
| S4030 | Collection and array contents should be used | Major |
| S4043 | Array-mutating methods should not be called on readonly arrays | Major |
| S4123 | "await" should only be used with promises | Major |
| S4143 | Collection elements should not be replaced unconditionally | Major |
| S4275 | Getters and setters should access the expected fields | Major |
| S4327 | "this" should not be assigned to variables | Major |
| S4619 | "in" operator should not be used on arrays | Major |
| S4621 | "in" should not make false assertions | Major |
| S5247 | Vue templates should pass props correctly | Critical |
| S5842 | Regular expressions should be syntactically valid | Blocker |
| S5856 | Regular expressions should be syntactically valid | Blocker |
| S6268 | Angular component inputs should not be set to undefined | Major |
| S6441 | Unnecessary character escapes should be removed | Major |
| S6478 | React components should not directly manipulate the DOM | Major |
| S6481 | React JSX should not use new object/array instances | Major |
| S6544 | Floating promises should be handled | Major |
| S6571 | Exclude should only be used with union types | Major |
| S6594 | String.prototype.match should be used with named groups | Minor |
| S6598 | Non-arrow function callbacks should not reference "this" | Major |
| S6606 | Nullish coalescing should be used | Minor |
| S6635 | Optional properties should only be used when appropriate | Minor |
| S6637 | Redundant double negation should be avoided | Minor |
| S6638 | Type checking calls should be valid | Major |
| S6644 | Promise rejections should not be caught | Major |
| S6645 | Unhandled exceptions should not exist in async | Major |
| S6647 | Prefer await to then callbacks | Minor |
| S6654 | Void expressions should only be used in statement position | Major |
| S6657 | Array forEach should not return a value | Major |
| S6660 | Do not pass children as props | Major |
| S6661 | Template literal placeholders should be meaningful | Major |
| S6666 | Destructuring should be preferred | Minor |
| S6671 | Void should only be used as a return type | Major |
| S6676 | Calls to ".call()" and ".apply()" should not be made with no effect | Major |
| S6679 | "new" operators should be used with appropriate objects | Major |
| S6747 | JSX elements should be self-closing if they have no children | Minor |
| S6749 | React Fragments should not have a single child | Minor |
| S6754 | React hooks should be called correctly | Critical |
| S6756 | Redundant React fragments should not be used | Minor |
| S6757 | React state hook values should not be directly mutated | Critical |
| S6759 | TypeScript type assertions should not be redundant | Minor |
| S6763 | React rendering should not depend on array indexes | Major |
| S6767 | UseState initializer should not return undefined | Major |
| S6770 | UseCallback and useMemo deps should include all variables | Major |
| S6774 | Type predicates should be accurate | Major |
| S6788 | Type guards should use correct types | Major |
| S6793 | Map and Set constructors should accept iterables | Major |

## Vulnerabilities

| Rule | Name | Severity |
|------|------|----------|
| S1523 | Code should not be dynamically evaluated | Critical |
| S2068 | Credentials should not be hard-coded | Blocker |
| S2076 | OS commands should not be vulnerable to injection attacks | Blocker |
| S2077 | SQL queries should not be vulnerable to injection attacks | Blocker |
| S2245 | Pseudorandom number generators should not be used in security contexts | Critical |
| S2631 | Regular expressions should not be vulnerable to denial of service attacks | Critical |
| S3330 | "HttpOnly" attribute should be set on cookies | Critical |
| S4423 | Weak SSL protocols should not be used | Critical |
| S4426 | Cryptographic keys should be robust | Critical |
| S4502 | CSRF protections should not be disabled | Critical |
| S4507 | Debug features should not be activated in production | Critical |
| S4787 | Encrypting data is security-sensitive | Critical |
| S4790 | Hashing data is security-sensitive | Critical |
| S4829 | Reading stdin is security-sensitive | Minor |
| S5042 | Expanding archives is security-sensitive | Critical |
| S5122 | CORS policy should be restrictive | Major |
| S5131 | Endpoints should not be vulnerable to SSRF | Critical |
| S5144 | Server-side requests should not be vulnerable to forging attacks | Critical |
| S5146 | Open redirects are security-sensitive | Major |
| S5148 | Response should include all security headers | Major |
| S5247 | Cross-site scripting should be prevented | Critical |
| S5334 | DOM updates should be sanitized | Critical |
| S5527 | Server certificates should be verified | Critical |
| S5547 | Cipher algorithms should be robust | Critical |
| S5659 | JWT signatures should be verified | Critical |
| S5689 | HTTP response headers should not reveal server information | Minor |
| S5693 | Request body should have size limits | Major |
| S5696 | Statically-served files should not have execution permissions | Major |
| S5728 | Content-Security-Policy header should be set | Major |
| S5730 | MIME types should be checked | Major |
| S5732 | Cookies should be secure | Major |
| S5734 | Referer policy should be restrictive | Minor |
| S5739 | HTTPS should be used | Major |
| S5742 | X-Content-Type-Options header should be set | Major |
| S5743 | X-Frame-Options header should be set | Major |
| S5753 | Allowing browsers to sniff MIME types is security-sensitive | Minor |
| S5757 | Sensitive data should not be logged | Major |
| S5852 | Regular expressions should not cause DoS | Critical |
| S6096 | Allowing requests with excessive content length is security-sensitive | Minor |
| S6105 | Disabling certificate validation is security-sensitive | Critical |
| S6245 | S3 buckets should not be publicly accessible | Critical |
| S6249 | S3 buckets should enforce encryption | Critical |
| S6252 | S3 buckets should have server-side encryption enabled | Critical |
| S6265 | S3 bucket grants should not be publicly accessible | Critical |
| S6270 | AWS IAM policies should limit access | Critical |
| S6275 | EBS volumes should be encrypted | Critical |
| S6281 | S3 bucket policies should not allow public access | Critical |
| S6302 | OpenSearch domains should be encrypted | Critical |
| S6303 | SQS queues should be encrypted | Critical |
| S6308 | SNS topics should be encrypted | Critical |
| S6317 | IAM policies should not allow privilege escalation | Critical |
| S6319 | SageMaker notebook instances should be encrypted | Critical |
| S6321 | Security groups should restrict ingress traffic | Critical |
| S6327 | SNS topics should not be publicly accessible | Critical |
| S6329 | EC2 instances should use encrypted storage | Critical |
| S6330 | SNS subscriptions should be encrypted | Critical |
| S6331 | ElastiCache clusters should be encrypted | Critical |
| S6332 | Redshift clusters should be encrypted | Critical |
| S6333 | Public IPs should not be assigned to cloud resources | Major |

## Code Smells

| Rule | Name | Severity |
|------|------|----------|
| S100 | Function and method names should comply with a naming convention | Minor |
| S101 | Class names should comply with a naming convention | Minor |
| S103 | Lines should not be too long | Minor |
| S104 | Files should not have too many lines of code | Major |
| S105 | Tabulation characters should not be used | Minor |
| S106 | Standard outputs should not be used directly to log | Major |
| S107 | Functions should not have too many parameters | Major |
| S108 | Nested blocks of code should not be left empty | Major |
| S109 | Magic numbers should not be used | Minor |
| S113 | Files should contain trailing newlines | Minor |
| S117 | Local variable and function parameter names should comply with a naming convention | Minor |
| S121 | Control structures should use curly braces | Minor |
| S122 | Statements should be on separate lines | Minor |
| S125 | Sections of code should not be commented out | Major |
| S126 | "if ... else if" constructs should end with "else" clauses | Minor |
| S128 | Switch cases should end with an unconditional "break" statement | Critical |
| S131 | "switch" statements should have "default" clauses | Major |
| S134 | Control flow statements should not be nested too deep | Critical |
| S138 | Functions should not have too many lines of code | Major |
| S878 | Comma operator should not be used | Major |
| S881 | Increment and decrement operators should not be mixed with other operators | Major |
| S888 | Equality operators should not be used in for loop termination conditions | Critical |
| S1066 | Collapsible "if" statements should be merged | Major |
| S1067 | Expressions should not be too complex | Critical |
| S1105 | An open curly brace should be located at the end of a line | Minor |
| S1110 | Redundant pairs of parentheses should be removed | Minor |
| S1116 | Empty statements should be removed | Minor |
| S1117 | Local variables should not shadow class fields | Major |
| S1119 | Labels should not be used | Major |
| S1121 | Assignments should not be made from within sub-expressions | Major |
| S1125 | Boolean literals should not be redundant | Minor |
| S1126 | Return of boolean expressions should not be wrapped into an "if-then-else" statement | Minor |
| S1128 | Unnecessary imports should be removed | Minor |
| S1134 | Track uses of "FIXME" tags | Major |
| S1135 | Track uses of "TODO" tags | Info |
| S1143 | "return" statements should not occur in "finally" blocks | Blocker |
| S1154 | Results of "substring" should be used | Major |
| S1172 | Unused function parameters should be removed | Major |
| S1186 | Methods should not be empty | Major |
| S1192 | String literals should not be duplicated | Critical |
| S1219 | "switch" statements should not contain non-case labels | Critical |
| S1226 | Destructured function parameters should be used | Minor |
| S1264 | A "while" loop should be used instead of a "for" loop | Minor |
| S1301 | "switch" statements should have at least 3 "case" clauses | Minor |
| S1314 | Octal values should not be used | Critical |
| S1321 | "with" statements should not be used | Major |
| S1438 | "===" and "!==" should be used instead of "==" and "!=" | Major |
| S1440 | "===" and "!==" should be used instead of "==" and "!=" | Major |
| S1441 | Quotes for attributes in JSX should be consistent | Minor |
| S1444 | "public static" fields should be constant | Major |
| S1451 | Track lack of copyright and license headers | Info |
| S1479 | "switch" statements should not have too many "case" clauses | Major |
| S1481 | Unused local variables should be removed | Minor |
| S1515 | Functions should not be defined inside loops | Major |
| S1516 | Block scope variables should not be accessed before they are assigned | Major |
| S1517 | Functions should not use destructuring arguments with default parameter values | Minor |
| S1526 | Variables declared with "var" should be declared before they are used | Major |
| S1529 | Bitwise operators should not be used in boolean contexts | Major |
| S1530 | Function declarations should not be made within blocks | Major |
| S1533 | "wrapper objects" should not be used | Major |
| S1534 | Duplicate properties should not be set on object | Critical |
| S1535 | "for...in" loops should filter properties before acting on them | Major |
| S1536 | Function argument names should be unique | Major |
| S1539 | "strict" mode should be activated | Major |
| S1541 | Functions should not have identical implementations | Major |
| S1751 | Loops should have at least one iteration | Major |
| S1764 | Identical expressions should not be used on both sides of operators | Major |
| S1821 | "switch" statements should not have more than one case for each branch | Critical |
| S1848 | Objects should not be created to be dropped immediately | Major |
| S1854 | Dead stores should be removed | Major |
| S1871 | Two branches in a conditional structure should not have the same implementation | Major |
| S1940 | Boolean checks should not be inverted | Minor |
| S2004 | File names should comply with a naming convention | Minor |
| S2094 | Classes should not be empty | Minor |
| S2123 | Values should not be uselessly incremented | Critical |
| S2137 | Named function expressions and arrow functions should not use the identifier | Major |
| S2138 | "undefined" should not be assigned | Minor |
| S2187 | TestCases should contain tests | Major |
| S2201 | Return values from functions without side effects should not be ignored | Major |
| S2228 | Console logging should not be used | Major |
| S2234 | Parameters should be passed in the right order | Major |
| S2251 | A "for" loop update clause should move the counter in the right direction | Blocker |
| S2259 | Null pointers should not be dereferenced | Major |
| S2260 | Properties and methods should not share the same name | Major |
| S2392 | Variables should be used in the blocks where they are declared | Minor |
| S2428 | Object literal shorthand syntax should be used | Minor |
| S2583 | Conditionally executed code should be reachable | Major |
| S2685 | "arguments.caller" and "arguments.callee" should not be used | Major |
| S2688 | "NaN" should not be used in comparisons | Major |
| S2692 | "indexOf" checks should not be for positive numbers | Minor |
| S2699 | Tests should include assertions | Major |
| S2703 | Variables should be declared explicitly | Major |
| S2737 | "catch" clauses should do more than rethrow | Major |
| S2757 | "=+" should not be used instead of "+=" | Critical |
| S2814 | Variables and functions should not be redeclared | Major |
| S2819 | Cross-origin resource sharing should be restricted | Major |
| S2870 | "delete" should not be used on arrays | Major |
| S2871 | "compareFunction" should be passed to Array.sort() | Major |
| S2898 | "document.domain" should not be used | Minor |
| S2930 | Function calls made on non-functions should not be made | Major |
| S2966 | Optional chaining should be preferred for nullable properties | Minor |
| S2990 | "this" should not be used outside of classes | Major |
| S2999 | "new" operators should be used with functions | Major |
| S3001 | "delete" should be used only with object properties | Major |
| S3003 | Comparison operators should not be used with strings | Minor |
| S3317 | Unnecessary semicolons should be removed | Minor |
| S3353 | Unchanged variables should be marked "readonly" | Minor |
| S3358 | Ternary operators should not be nested | Major |
| S3403 | Strict equality operators should not be used with dissimilar types | Minor |
| S3498 | Object literal property shorthand syntax should be used | Minor |
| S3512 | Template strings should be used instead of concatenation | Minor |
| S3513 | "arguments" should not be accessed directly | Major |
| S3514 | Destructuring assignment should be used | Minor |
| S3516 | Functions returns should not be invariant | Major |
| S3524 | Braces should be omitted from arrow function body when returning object literal | Minor |
| S3525 | Class methods should be used instead of "prototype" assignments | Minor |
| S3533 | "import" should be preferred over "require" | Minor |
| S3579 | Array indexes should be numeric | Major |
| S3616 | Comma and logical OR operators should not be used in switch cases | Critical |
| S3626 | Jump statements should not be redundant | Minor |
| S3686 | Functions should be called consistently with or without "new" | Major |
| S3696 | Errors should not be created without being thrown | Major |
| S3699 | The output of functions that don't return anything should not be used | Major |
| S3735 | "void" should not be used | Major |
| S3757 | Arithmetic operations should not result in "NaN" | Major |
| S3758 | Values not convertible to numbers should not be used in numeric comparisons | Major |
| S3760 | Arithmetic operators should only have numbers as operands | Major |
| S3776 | Cognitive Complexity of functions should not be too high | Critical |
| S3782 | Argument types should match | Minor |
| S3785 | "in" should not be used with primitive types | Major |
| S3786 | Template literal placeholders should not be empty | Major |
| S3796 | Callbacks of array methods should have return statements | Major |
| S3799 | Destructuring patterns should not be empty | Major |
| S3801 | Functions should use "return" consistently | Major |
| S3802 | The global "this" object should not be used | Major |
| S3827 | Variables should be defined before being used | Major |
| S3854 | Super constructors should be called | Blocker |
| S3863 | "arguments" should not be reassigned | Critical |
| S3923 | All branches in a conditional structure should not have exactly the same implementation | Major |
| S3972 | Conditionals should start on new lines | Major |
| S3973 | Comparison operator should not be confused with assignment operator | Major |
| S3981 | Collection sizes should be compared correctly | Major |
| S3984 | Exception should not be created without being thrown | Major |
| S4023 | Interfaces should not be empty | Minor |
| S4030 | Collection and array contents should be used | Major |
| S4043 | Array-mutating methods should not be used misleadingly | Major |
| S4084 | Media elements should have captions | Minor |
| S4138 | "for of" should be used with Iterables | Minor |
| S4139 | "in" should only be used on objects | Major |
| S4140 | "instanceof" should be used | Major |
| S4143 | Collection elements should not be replaced unconditionally | Major |
| S4144 | Functions should not have identical implementations | Major |
| S4156 | "readonly" should be specified for interfaces | Minor |
| S4157 | Types should be used | Minor |
| S4158 | Empty collections should not be accessed or iterated | Major |
| S4275 | Getters and setters should access the expected fields | Major |
| S4322 | Type aliases should be used | Minor |
| S4323 | Type intersections should be replaced by "extends" | Minor |
| S4324 | Primitive return types should be used | Minor |
| S4325 | Type assertions should not be redundant | Minor |
| S4326 | Promises should not be returned when in "async" functions | Minor |
| S4327 | "await" should only be used with promises | Major |
| S4328 | Dependencies should be explicit | Blocker |
| S4335 | "parseInt" should not be called without a radix | Minor |
| S4524 | "switch" statements should have "default" clauses | Minor |
| S4619 | "in" operator should not be used on arrays | Major |
| S4621 | "in" should not make false assertions | Major |
| S4622 | Union and intersection types should not include duplicated constituents | Major |
| S4623 | "undefined" should not be passed as argument | Minor |
| S4624 | Template strings should not be unnecessary | Minor |
| S4634 | Shorthand properties should be grouped at the beginning or end | Minor |
| S4798 | Optional properties should only be used when appropriate | Minor |
| S5254 | HTML5 should be used | Minor |
| S5261 | JSX elements should have unique keys when in a list | Major |
| S5264 | Elements should have accessible names | Major |
| S5332 | Clear-text protocols should not be used | Major |
| S5443 | Publicly-accessible methods should not call "eval" or "setTimeout" | Blocker |
| S5604 | Permissions should be requested only when needed | Minor |
| S5659 | JWT should be verified | Critical |
| S5725 | The "head" tag should have a "title" tag | Minor |
| S5734 | Referer policy should be restrictive | Minor |
| S5739 | Secure protocol should be used | Major |
| S5753 | Allowing browsers to sniff MIME types is security-sensitive | Minor |
| S5757 | Sensitive data should not be logged | Major |
| S5842 | Regular expressions should be syntactically valid | Blocker |
| S5843 | Regular expressions should not be too complicated | Critical |
| S5850 | Alternatives in regular expressions should be grouped | Minor |
| S5852 | Regular expressions should not be vulnerable to denial of service | Critical |
| S5856 | Regular expressions should be syntactically valid | Blocker |
| S5863 | "typeof" operators should be compared with existing types | Major |
| S5868 | Unicode characters should not be used when describing regular expressions | Minor |
| S5869 | Character classes should accept only specific characters | Major |
| S6019 | Unnecessary "return await" should be removed | Minor |
| S6035 | Single character alternatives in regular expressions should be in character classes | Minor |
| S6092 | Tests should test something | Major |
| S6268 | Angular components inputs should not be set | Major |
| S6299 | "bypassSecurityTrustUrl" and related should not be used | Major |
| S6303 | "ng-template" should not be used in "ng-container" | Minor |
| S6308 | Structural directives should not be duplicated | Major |
| S6324 | Regular expressions using Unicode character classes should enable Unicode flag | Major |
| S6326 | Regex literals should not contain multiple consecutive spaces | Minor |
| S6328 | Replacement strings should reference existing groups | Major |
| S6329 | "this" should not be returned from React components | Major |
| S6332 | Regular expressions should not be empty | Major |
| S6333 | Regex should not contain empty alternatives | Major |
| S6351 | Regular expressions with the global flag should be used correctly | Major |
| S6353 | Regular expressions should not contain control characters | Minor |
| S6395 | Unicode escapes should be specified as 4-digit hex | Minor |
| S6397 | Regex character class elements should follow ascending order | Minor |
| S6418 | Hardcoded IP address should not be used | Major |
| S6426 | Variable declarations should not be assigned intermediate values | Minor |
| S6435 | Resource cleanup should be handled properly | Major |
| S6439 | React hooks should properly return from async functions | Critical |
| S6440 | CSS should not be set through JavaScript | Minor |
| S6441 | Unnecessary character escapes should be removed | Major |
| S6443 | Spreading arguments in array should not be redundant | Minor |
| S6477 | JSX list elements should have keys | Major |
| S6478 | React components should not directly manipulate the DOM | Major |
| S6479 | JSX list elements should have a "key" | Major |
| S6480 | React components should not duplicate state | Major |
| S6481 | React JSX should not use new object/array instances | Major |
| S6486 | React state should be immutable | Major |
| S6509 | Object spread syntax should be used instead of Object.assign | Minor |
| S6523 | Redux state selectors should not be called inside useEffect | Major |
| S6534 | Promise rejections should be resolved | Major |
| S6535 | React should not re-fetch data that doesn't change | Major |
| S6544 | Floating promises should be handled | Major |
| S6550 | Indexed string type should not be used | Minor |
| S6551 | Type aliases should be used | Minor |
| S6556 | Type definitions should be exported | Minor |
| S6557 | "isNaN" should be used to check for "NaN" value | Major |
| S6558 | Object.hasOwn should be used instead of Object.prototype.hasOwnProperty | Minor |
| S6564 | String includes should be used | Minor |
| S6565 | Assignment to the "exports" variable should be avoided | Major |
| S6568 | Object.entries should be used instead of Object.keys().forEach | Minor |
| S6569 | Array.isArray should be used | Minor |
| S6571 | Exclude should only be used with union types | Major |
| S6572 | Enum members should be initialized | Minor |
| S6578 | Array.toSorted should be used | Minor |
| S6579 | RegExp exec should be used | Minor |
| S6580 | String includes should be used | Minor |
| S6582 | Optional chaining should be preferred | Minor |
| S6583 | Nullish coalescing should be used | Minor |
| S6590 | Array.prototype.at should be used | Minor |
| S6594 | String.prototype.match should be used with named groups | Minor |
| S6598 | Arrow functions should be preferred for callbacks | Minor |
| S6606 | Nullish coalescing should be used | Minor |
| S6627 | Generic type constraints should be used | Minor |
| S6631 | Type intersection should be valid | Major |
| S6635 | Optional properties should only be used when appropriate | Minor |
| S6636 | Using "as" to cast types should be avoided | Minor |
| S6637 | Redundant double negation should be avoided | Minor |
| S6638 | Type checking calls should be valid | Major |
| S6643 | Branded types should not use the type | Minor |
| S6644 | Promise rejections should not be caught | Major |
| S6645 | Unhandled exceptions should not exist in async | Major |
| S6647 | Prefer await to then callbacks | Minor |
| S6650 | Inferred types should be explicit | Minor |
| S6654 | Void expressions should only be used in statement position | Major |
| S6657 | Array forEach should not return a value | Major |
| S6660 | Do not pass children as props | Major |
| S6661 | Template literal placeholders should be meaningful | Major |
| S6666 | Destructuring should be preferred | Minor |
| S6671 | Void should only be used as a return type | Major |
| S6676 | Calls to ".call()" and ".apply()" should not be made with no effect | Major |
| S6679 | "new" operators should be used with appropriate objects | Major |
| S6714 | Default exports should be named | Minor |
| S6747 | JSX elements should be self-closing if they have no children | Minor |
| S6749 | React Fragments should not have a single child | Minor |
| S6754 | React hooks should be called correctly | Critical |
| S6756 | Redundant React fragments should not be used | Minor |
| S6757 | React state hook values should not be directly mutated | Critical |
| S6759 | TypeScript type assertions should not be redundant | Minor |
| S6763 | React rendering should not depend on array indexes | Major |
| S6766 | React components should not have extra closing tags | Minor |
| S6767 | UseState initializer should not return undefined | Major |
| S6770 | UseCallback and useMemo deps should include all variables | Major |
| S6774 | Type predicates should be accurate | Major |
| S6788 | Type guards should use correct types | Major |
| S6793 | Map and Set constructors should accept iterables | Major |

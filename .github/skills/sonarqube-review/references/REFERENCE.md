# SonarQube Rules Reference

Complete rule catalog organized by language and category.

---

## Rule Index by Language

| Language | Bugs | Vulnerabilities | Code Smells | Security Hotspots |
|----------|------|-----------------|-------------|-------------------|
| TypeScript/JavaScript | 45+ | 30+ | 80+ | 25+ |
| Python | 35+ | 25+ | 60+ | 20+ |
| C# | 40+ | 25+ | 70+ | 20+ |
| Java | 50+ | 35+ | 90+ | 30+ |
| Go | 25+ | 20+ | 40+ | 15+ |

---

# TypeScript/JavaScript Rules

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

---

# Python Rules

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

---

# C# Rules

## Bugs

| Rule | Name | Severity |
|------|------|----------|
| S1048 | Virtual events should not be raised | Major |
| S1656 | Property assignments should be correct | Blocker |
| S1751 | Loops should have at least one iteration | Major |
| S1764 | Identical expressions should not be used on both sides of operators | Major |
| S1854 | Dead stores should be removed | Major |
| S1862 | Related "if/else if" statements should not have the same condition | Major |
| S1871 | Branches should have different implementations | Major |
| S2123 | Values should not be uselessly incremented | Critical |
| S2178 | Short-circuit logic should be used in boolean contexts | Major |
| S2183 | Integral numbers should not be shifted by values outside the valid range | Major |
| S2184 | Results of integer division should not be assigned to floating point variables | Major |
| S2190 | Recursion should not be infinite | Blocker |
| S2201 | Return values should not be ignored | Major |
| S2219 | Runtime type checking should be simplified | Major |
| S2222 | Locks should be released | Blocker |
| S2223 | Non-constant static fields should not be visible | Major |
| S2225 | "ToString()" should not throw | Major |
| S2234 | Parameters should be passed in the right order | Major |
| S2251 | Loop counters should move in the right direction | Blocker |
| S2252 | Loop conditions should be true at least once | Major |
| S2259 | Null pointers should not be dereferenced | Major |
| S2275 | Format strings should be passed the correct number of arguments | Major |
| S2278 | Neither DES (Data Encryption Standard) nor DESede (3DES) should be used | Critical |
| S2291 | Enumerable.Sum should not be called on infinite sequences | Blocker |
| S2302 | Loop conditions should be invariant | Major |
| S2306 | Method parameters should not be reassigned | Minor |
| S2328 | GetHashCode should not return mutable | Major |
| S2344 | Enumeration type names should not have "Flag" or "Flags" suffixes | Minor |
| S2345 | Flags enumerations should explicitly initialize all their members | Major |
| S2357 | Fields should be private | Major |
| S2365 | Properties should not be based on array | Major |
| S2386 | Mutable fields should not be "public static" | Critical |
| S2437 | Silly bit operations should not be performed | Major |
| S2551 | Shared resources should not be used for locking | Major |
| S2583 | Conditionally executed code should be reachable | Major |
| S2589 | Boolean expressions should not be gratuitous | Major |
| S2674 | The stream reading should not return a value smaller than the minimum expected | Blocker |
| S2681 | Multiline blocks should be enclosed in curly braces | Major |
| S2688 | "NaN" should not be used in comparisons | Major |
| S2696 | Instance members should not write to "static" fields | Critical |
| S2757 | "=+" should not be used instead of "+=" | Critical |
| S2925 | Thread.Sleep should not be used for timing | Major |
| S2930 | "IDisposable" resources should be properly disposed | Major |
| S2931 | Classes with "IDisposable" members should implement "IDisposable" | Major |
| S2933 | Fields that are only assigned in constructor should be readonly | Minor |
| S2934 | Property assignments should not be used in boolean expressions | Minor |
| S2953 | Methods named "Dispose" should implement "IDisposable.Dispose" | Major |
| S2955 | Generic parameters not constrained to reference types should not be compared to "null" | Major |
| S2971 | "IEnumerable" LINQs should be simplified | Major |
| S2995 | "Object.ReferenceEquals" should not be used for value types | Major |
| S2996 | "ThreadStatic" fields should not be initialized | Major |
| S2997 | "IDisposables" created in a "using" statement should not be returned | Blocker |
| S3005 | "ThreadStatic" should not be used on non-static fields | Major |
| S3010 | Static fields should not be updated in constructors | Major |
| S3168 | "async" methods should not return "void" | Major |
| S3172 | Delegates should not be subtracted | Major |
| S3217 | "Explicit" conversions of "foreach" loops should not fail | Major |
| S3237 | Exception properties should be accessible | Major |
| S3249 | Classes directly extending "object" should not call "base" methods | Major |
| S3256 | "string.IsNullOrEmpty" should be used | Minor |
| S3264 | Events should be invoked | Major |
| S3265 | Non-flags enums should not be used in bitwise operations | Major |
| S3329 | Cryptographic operations should not use weak IVs | Critical |
| S3346 | Exceptions should not be explicitly rethrown | Minor |
| S3353 | Unchanged local variables should be readonly | Minor |
| S3358 | Ternary operators should not be nested | Major |
| S3376 | "partial" method parameter names should match | Minor |
| S3397 | "base.Equals" should not be used | Major |
| S3427 | Method overloads with default parameter values should not overlap | Major |
| S3433 | Test method signatures should be correct | Minor |
| S3451 | Sensitive API keys should not be hard-coded | Blocker |
| S3453 | Classes should not have only "private" constructors | Major |
| S3458 | Empty "case" clauses should be merged with the "default" one | Minor |
| S3466 | Optional parameters should be passed explicitly | Minor |
| S3532 | Empty "default" clause should do nothing | Minor |
| S3598 | One-way "OperationContract" should not return value | Major |
| S3600 | "params" should be used on overrides | Minor |
| S3603 | Methods should not check their own calls | Minor |
| S3604 | Collection and array contents should be used | Major |
| S3610 | "this" or "base" should not be called in constructor parameters | Major |
| S3655 | Nullable value types should be properly accessed | Major |
| S3717 | Track lack of copyright and license headers | Info |
| S3776 | Cognitive Complexity of functions should not be too high | Critical |
| S3869 | "SafeHandle.DangerousGetHandle" should not be called | Critical |
| S3871 | Exception types should be "public" | Major |
| S3874 | "out" and "ref" parameters should not be used | Minor |
| S3875 | "==" should not be used with a value type | Major |
| S3876 | Strings or integral types should be used for indexers | Minor |
| S3877 | Exceptions should not be thrown from unexpected methods | Major |
| S3880 | Finalizers should call "base.Finalize()" | Critical |
| S3884 | "CoSetProxyBlanket" and "CoInitializeSecurity" should not be used | Blocker |
| S3885 | "Assembly.Load" should be used | Minor |
| S3889 | "Thread.Suspend" and "Thread.Resume" should not be used | Major |
| S3897 | Classes that provide "Equals(<T>)" or "Equals(Object)" should also implement "IEquatable<T>" | Major |
| S3898 | Value types should implement "IEquatable<T>" | Minor |
| S3900 | Arguments of public methods should be validated | Major |
| S3902 | "assembly" or "type" attributes should be declared | Minor |
| S3903 | Types should be defined in named namespaces | Major |
| S3904 | Assemblies should have version information | Minor |
| S3908 | Generic event handlers should be used | Minor |
| S3909 | Collections should implement the generic interface | Minor |
| S3923 | All branches in a conditional structure should not have exactly the same implementation | Major |
| S3925 | "ISerializable" should be implemented correctly | Critical |
| S3926 | Deserialization methods should be provided | Critical |
| S3927 | Serialization event handlers should be implemented correctly | Critical |
| S3928 | Parameter names should match with "ArgumentException" | Minor |
| S3937 | Number patterns should be regular | Minor |
| S3949 | Calculations should not overflow | Major |
| S3956 | "GenericType.IEnumerable" should not be used | Minor |
| S3962 | "static readonly" constants should be "const" instead | Minor |
| S3963 | "static" fields should be initialized inline | Minor |
| S3966 | Objects should not be disposed more than once | Major |
| S3967 | Multi-dimensional arrays should not be used | Minor |
| S3971 | "GC.SuppressFinalize" should not be called | Major |
| S3972 | Conditionals should start on new lines | Major |
| S3973 | A conditionally executed single line should be denoted by indentation | Minor |
| S3981 | Collection sizes should be compared correctly | Major |
| S3984 | Exception should not be created without being thrown | Major |
| S3990 | Assemblies should be marked as CLS-compliant | Minor |
| S3992 | Assemblies should explicitly specify COM visibility | Minor |
| S3993 | Custom attributes should be marked with "System.AttributeUsageAttribute" | Minor |
| S3994 | URI properties should not be strings | Minor |
| S3995 | URI return values should not be strings | Minor |
| S3996 | URI properties should not be strings | Minor |
| S3997 | String URI overloads should call "System.Uri" overloads | Minor |
| S3998 | Threads should not lock on objects with weak identity | Critical |
| S4000 | Pointers to unmanaged memory should not be visible | Critical |
| S4002 | Disposable types should declare finalizers | Major |
| S4004 | Collection properties should be readonly | Major |
| S4005 | "System.Uri" arguments should be used instead of strings | Minor |
| S4015 | Inherited member visibility should not be decreased | Critical |
| S4016 | Enumeration members should not be named "Reserved" | Minor |
| S4017 | Type names should not match namespaces | Minor |
| S4018 | Generic methods should provide type parameters | Minor |
| S4019 | Base class methods should not be hidden | Major |
| S4022 | Enumerations should have "Int32" storage | Minor |
| S4023 | Interfaces should not be empty | Minor |
| S4025 | Child class fields should not shadow parent class fields | Major |
| S4026 | Assemblies should be marked with "NeutralResourcesLanguageAttribute" | Minor |
| S4027 | Exceptions should provide standard constructors | Minor |
| S4035 | Classes implementing "IEquatable<T>" should be sealed | Major |
| S4036 | Path delimiters should not be hardcoded | Major |
| S4039 | Interface methods should be callable by derived types | Major |
| S4041 | Type names should not match keywords | Minor |
| S4047 | Generic "KeyValuePair" should be used | Minor |
| S4049 | Consider using "readonly" keyword | Minor |
| S4050 | Operators should be overloaded consistently | Minor |
| S4052 | Types should not extend outdated base types | Minor |
| S4055 | Literals should not be passed as localized parameters | Minor |
| S4056 | Overloads with "CultureInfo", "IFormatProvider" or string comparison parameters should be preferred | Minor |
| S4057 | Localization should be done properly | Minor |
| S4058 | Overloads with "StringComparison" parameter should be used | Minor |
| S4059 | Property names should not match get methods | Minor |
| S4060 | Non-abstract attributes should be sealed | Minor |
| S4061 | "params" should be used | Minor |

---

# Quality Profile Recommendations

## Sonar Way Profile (Default)

The "Sonar Way" profile is the default quality profile that includes:
- All Blocker rules
- All Critical rules
- Most Major rules
- Selected Minor rules for common issues

## Recommended Custom Profile

For strict code quality, enable these additional rules:

### Enable
- All unused code detection
- Cognitive complexity checks
- Naming convention rules
- Security hotspot rules

### Disable (if noise is too high)
- S1135 (TODO tracking) - Info level
- S109 (Magic numbers) - If constants are impractical
- S1451 (Copyright headers) - If not required

---

# Integration with CI/CD

## Quality Gate Configuration

```yaml
# Example quality gate
quality_gate:
  conditions:
    - metric: blocker_violations
      operator: GT
      threshold: 0
    - metric: critical_violations
      operator: GT
      threshold: 0
    - metric: major_violations
      operator: GT
      threshold: 3
    - metric: coverage
      operator: LT
      threshold: 80
    - metric: duplicated_lines_density
      operator: GT
      threshold: 3
```

## Severity Mapping

| SonarQube Severity | GitHub Actions | Azure DevOps |
|--------------------|----------------|--------------|
| Blocker | error | Error |
| Critical | error | Error |
| Major | warning | Warning |
| Minor | notice | Note |
| Info | notice | Note |

# C# / .NET Rules

Complete rule catalog for C# and .NET.

---

## C#-Specific Examples

### S2933: Fields that are only assigned in constructor should be readonly
```csharp
// Non-compliant
private string _name;

public MyClass(string name) {
    _name = name;
}

// Compliant
private readonly string _name;

public MyClass(string name) {
    _name = name;
}
```

### S3925: ISerializable should be implemented correctly
```csharp
// Non-compliant - missing protected constructor
[Serializable]
public class MyException : Exception, ISerializable { }

// Compliant
[Serializable]
public class MyException : Exception, ISerializable {
    protected MyException(SerializationInfo info, StreamingContext context)
        : base(info, context) { }
}
```

### S2696: Instance members should not write to "static" fields
```csharp
// Non-compliant
private static int _counter;

public void Process() {
    _counter++; // Instance method modifying static field
}

// Compliant
private static int _counter;

public static void IncrementCounter() {
    _counter++;
}
```

### S3168: "async" methods should not return "void"
```csharp
// Non-compliant
public async void ProcessAsync() {
    await DoWorkAsync();
}

// Compliant
public async Task ProcessAsync() {
    await DoWorkAsync();
}
```

---

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

## Quality Profile Recommendations

### Sonar Way Profile (Default)

The "Sonar Way" profile is the default quality profile that includes:
- All Blocker rules
- All Critical rules
- Most Major rules
- Selected Minor rules for common issues

### Recommended Custom Profile

For strict code quality, enable these additional rules:

**Enable:**
- All unused code detection
- Cognitive complexity checks
- Naming convention rules
- Security hotspot rules

**Disable (if noise is too high):**
- S1135 (TODO tracking) - Info level
- S109 (Magic numbers) - If constants are impractical
- S1451 (Copyright headers) - If not required

---

## Integration with CI/CD

### Quality Gate Configuration

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

### Severity Mapping

| SonarQube Severity | GitHub Actions | Azure DevOps |
|--------------------|----------------|--------------|
| Blocker | error | Error |
| Critical | error | Error |
| Major | warning | Warning |
| Minor | notice | Note |
| Info | notice | Note |

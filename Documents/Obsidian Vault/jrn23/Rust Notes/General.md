## Naming Conventions
Constant names must always be uppercase with underscore between words.

## Concepts
- Constants must be only to a constant expression, not the result of a value that could only be computed at runtime.
- Constants must always have their type annotated. For example :
```rust
const THREE_HOURS_IN_SECONDS: u32 = 60 * 60 * 3;
```
- ==Shadowing== is when you declare/create a new variable with the same name as a previous variable (eg let x = x + 1). We must always use `let` keyword to do that.
- Because we create a new variable when ==shadowing==, we can also change the type of the new variable to something else.
- We cannot change the type of a variable when it is a mutable variable, thus we are not allowed to mutate a variable's type.
### If expressions
```rust
fn main() {
    let number = 3;

    if number < 5 {
        println!("condition was true");
    } else {
        println!("condition was false");
    }
}
```

The condition must always be a *bool*. Else we get an error. Example:
```rust
fn main() {
    let number = 3;

    if number {
        println!("number was three");
    }
}
```

```console
$ cargo run
   Compiling branches v0.1.0 (file:///projects/branches)
error[E0308]: mismatched types
 --> src/main.rs:4:8
  |
4 |     if number {
  |        ^^^^^^ expected `bool`, found integer
```

You can also have multiple conditions by combining `if` and `else` in an `else if` epxression.
```rust
fn main() {
    let number = 6;

    if number % 4 == 0 {
        println!("number is divisible by 4");
    } else if number % 3 == 0 {
        println!("number is divisible by 3");
    } else if number % 2 == 0 {
        println!("number is divisible by 2");
    } else {
        println!("number is not divisible by 4, 3, or 2");
    }
}
```

If you have too many `else if` expressions it can clutter your code. In that case you might want to use another branching construct called `match`.

Because `if` is an expression, we can also use it on the right side of a `let` statement.
```rust
fn main() {
    let condition = true;
    let number = if condition { 5 } else { 6 };

    println!("The value of number is: {}", number);
}
```

Remember that blocks of code evaluate to the last expression in them, and numbers by themselves are also expressions. When we do such a thing as the above code suggests, the values that have the potential to be results must of the same type. Otherwise we get an error.
```rust
fn main() {
    let condition = true;

    let number = if condition { 5 } else { "six" };

    println!("The value of number is: {}", number);
}
```

```console
$ cargo run
   Compiling branches v0.1.0 (file:///projects/branches)
error[E0308]: `if` and `else` have incompatible types
 --> src/main.rs:4:44
  |
4 |     let number = if condition { 5 } else { "six" };
  |                                 -          ^^^^^ expected integer, found `&str`
  |                                 |
  |                                 expected because of this
```

### Repetitions with Loops
It's often useful to execute a block of code more than once. For this task, Rust provides several *loops*. Rust has 3 kinds of loops: `loop`, `while` and `for`.

#### Repeating code with `loop`
The `loop` keyword tells Rust to execute code over and over again forever or until you explicitly tell it to stop.
```rust
fn main() {
    loop {
        println!("again!");
    }
}
```

Rust also provides a way to break out of a loop from code. You can place the `break` keyword within the loop to tell the program to stop executing the loop and break out of it. 
There is also the `continue` keyword within a loop, which tells the program to skip over any remaining code in this iteration of the loop and go to the next iteration.
If you have nested loops, `break` and `continue` apply to the innermost loop at that point. You can optionally specify a *loop label* on a loop and then use the label with `break` and `continue` to have those keywords applied to the labeled loop instead of the innermost loop.
```rust
fn main() {
    let mut count = 0;
    'counting_up: loop {
        println!("count = {}", count);
        let mut remaining = 10;

        loop {
            println!("remaining = {}", remaining);
            if remaining == 9 {
                break;
            }
            if count == 2 {
                break 'counting_up;
            }
            remaining -= 1;
        }

        count += 1;
    }
    println!("End count = {}", count);
}
```

#### Returning values from Loops
You can also return values from loops. To do this, you can add the value you want returned after the `break` expression you use to stop the loop. That value will be returned out of the loop so you can use it.
```rust
fn main() {
    let mut counter = 0;

    let result = loop {
        counter += 1;

        if counter == 10 {
            break counter * 2;
        }
    };

    println!("The result is {}", result);
}
```

Notice that after the loop, we use a semicolon to end the statement that assigns the value to *result*. 

#### Conditionals Loops with `while`
It's often useful for a program to evaluate a condition within a loop. While the condition is true, the loop runs. When it ceases to be true, the program calls `break`, stopping the loop. You can use a `while` loop to do that. 
```rust
fn main() {
    let mut number = 3;

    while number != 0 {
        println!("{}!", number);

        number -= 1;
    }

    println!("LIFTOFF!!!");
}
```

This way you can eliminate a lot of nesting that would be necessary if you used `loop`, `if`, `else` and `break` if you wanted to implement it that way and it's also clearer. 

#### Looping through a Collection with `for`
You could use the `while` construct to loop over the elements of a collection, such as an array. For example:
```rust
fn main() {
    let a = [10, 20, 30, 40, 50];
    let mut index = 0;

    while index < 5 {
        println!("the value is: {}", a[index]);

        index += 1;
    }
}
```

#important 
But this approach is *error prone*. We could cause the program to panic if the index value or test condition are incorrect. It's also slow, because the compiler adds runtime code to perform the conditional check of whether the index is within the bounds of the array on every iteration through the loop. 
A more concise alternative would be to use a `for` loop to execute some code for each item in a collection. It looks like this:
```rust
fn main() {
    let a = [10, 20, 30, 40, 50];

    for element in a {
        println!("the value is: {}", element);
    }
}
```

We've now eliminated the chance of bugs that might result from going beyond the end of the array or not going far enough and missing some items.
The safety and conciseness of `for` loops makes them the most commonly used loop construct in Rust. Even in situations where you want to run some code a certain number of times, you can use a *Range*, which is a type provided by the standard library that generates all numbers in sequence starting from one number and ending before another number. 
```rust
fn main() {
    for number in (1..4).rev() {
        println!("{}!", number);
    }
    println!("LIFTOFF!!!");
}
```

Here we also use the `rev` method to reverse the order of the *Range*.
For starters, we will focus on 2 subsets: scalar and compound.
Always make sure that there is no ambiguity as far as data types are concerned. If there is any, we must explicitly add a type annotation.

## Scalar Types
A scalar type represents a single value. There are four primary scalar types: integers, floating-point numbers, Booleans and characters.
	
### Integer Type
| Length  | Signed | Unsigned |
|:-------:|:------:|:--------:|
|  8-bit  |   i8   |    u8    |
| 16-bit  |  i16   |   u16    |
| 32-bit  |  i32   |   u32    |
| 64-bit  |  i64   |   u64    |
| 128-bit |  i128  |   u128   |
|  arch   | isize  |  usize   |

You should use isize/usize when indexing some sort of collection.
- <u>Integer Overflow:</u>
	`Integer Overflow` can occur when you try to change the variable to a value outside of the range the type of the variable can actually hold. 
	- When you compile in debug mode, the rust compiler will panic if there is integer overflow.
	- When you compile in release mode, the rust compiler does not include checks for integer overflow that cause panic. Instead, if overflow occurs, Rust performs 2's complement wrapping. Values greater than the maximum value the type can hold "wrap around" to the minimum of values the type can hold. In the case of `u8`, 256 becomes 0, 257 becomes 1, and so on. Thus the variable will have a value that probably is not what you expect and you should never rely on integer overflow's wrapping behavior as it is considered an error. #important 

	Ways to handle `Integer Overflow` :
	- Wrap in all modes with the `wrapping_*` methods, such as `wrapping_add`
	- Return the value `None` if there is an overflow with the `checked_*` methods
	- Return the value and a boolean indicating whether there was an overflow with the `overflowing_*` methods
	- Saturate at the value's minimum or maximum values with the `saturating_*` methods

### Floating-Point Types
Rust has two primitive types for `floating-point` numbers, which are numbers with decimal points. There are `f32` and `f64` for 32 bits and 64 bits respectively. Default is `f64`. `f32` is single-precision float, while `f64` is double-precision.
		
	- Numeric Operations: Integer division rounds down to the nearest integer.

### Boolean Type
Boolean type in Rust are `true` and `false`. For example:
```rust
fn main() {
let t = true;

let f: bool = false; // with explicit type annotation
}
```

### Character Type
	- Char literals are specified with single quotes, as opposed to string literals, which use double quotes.
	- Rust's char type is four bytes in size and represents a Unicode Scalar Value, which means it can represent a lot more than just ASCII. 

## Compound Types
Compound types can group multiple values into one type. Rust has 2 primitive compound types: tuples and arrays.

### Tuple Type
A tuple is a generic way of grouping together a number of values with a variety of types into one compound type. Tuples have fixed length, they cannot grow or shrink. 

```rust
fn main() {
	let tup: (i32,f64,u8) = (500, 6.4, 1);
}
```

The variable `tup` binds to the whole tuple, because a tuple is considered a single compound element.
To get individual values of tuple, we do this: 
```rust
fn main() {
    let tup = (500, 6.4, 1);

    let (x, y, z) = tup;

    println!("The value of y is: {}", y);
}
```
This uses pattern matching with `let` to take `tup` and turn it into three seperate values. This is called *destructuring*, because it breaks the tuple into three parts.
Or we can access a tuple element directly by using a period ( . ) followed by the index of the element. For example:
```rust
fn main() {
	let x: (i32, f64, u8) = (500, 6.4, 1);

	let five_hundred = x.0;

	let six_point_four = x.1;

	let one = x.2;
}
```
Starting index for tuples is 0.
The tuple without any values, (), is a special type that has only one value (). The type is called the *unit type* and the value is called the *unit value*. It is used when there is no other meaningful value that could be returned. Functions without a 
`-> ...` implicitly have return type ().

### Array Type
Unlike a tuple, every element in an array must have the same type. Unlike other programming languages, arrays in Rust have fixed length, like tuples.
```rust
fn main() {
    let a = [1, 2, 3, 4, 5];
	let a: [i32; 5] = [1, 2, 3, 4, 5];
	let a = [3; 5]; // Initial value followed by semicolon and length
	let first = a[0];
	let second = a[1];
}
```
Arrays are useful when you want your data allocated on the stack rather than the heap or when you want to ensure you always have a fixed number of elements. If you want a flexible collection that allows growing/shrinking use vector instead. Starting index of array at 0.
When you attempt to access an element using indexing, Rust will check to see if the index is not out of bounds of the array's size. If it's out of bounds, Rust will panic.
## Naming Conventions
Identifier names (variables, functions, macros, etc) can use:  
   - lowercase and uppercase letters (characters) and digits
   - do not use special characters like @ # & " ...
   - do not use accented characters like é è à ...
   - do not start with a digit
   - start only with a letter or underscore(_)
   - spaces are forbidden
   - _ may be used instead of a space in the name of the variable
   - YouCanUseUppercaseLettersBetweenWordsInsteadOf or _fsajdfgsGREAA
 
## Conversion Specifiers
Following are most commonly used in the form of %m.pX (the meaning of p depends on the conversion specifier):
   - d -> Displays an integer in decimal form. p means number of zeros added to the beginning of number
   - e -> Displays a floating point number in exponential form. p indicates how many digits should appear after the decimal point
   - f -> Displays floating point number in decimal form. p indicates how many digits should appear after the decimal point
   - g -> Displays floating point number either in exponential or decimal form(depends on the size of number). p indicates the maximum number of significant digits (not digits after the decimal point) to be displayed. It decides which form to use based on number of fewer characters to display.
 
## Input/Output
- Many programmers avoid the use of `scanf`, instead reading data in  character form and converting it to numeric later if needed.
- `scanf` skips unnecessary white-space characters as it searches for the beginning of a number or data item in general (spaces, new lines, tabs, etc)
- `scanf` peeks at the final new-line character without actually reading it. This new-line will be consumed as the fist character to read by the next call of `scanf` (Beware of this when using `scanf` in loops) #important 
- When `scanf` reads a character that can't be part of the current item, it puts the character back to be read again during the scanning of the next input item or during the next call of `scanf`. This is the problem with new-line as last character as stated in the entry above.
- <span class="red"><u>Other characters:</u></span>
When `scanf` encounters a non-white-space character in a format string, `scanf` compares it with the next input character. If it's a match `scanf` disregards it and moves along to the next character in the format string. If it's not a match, `scanf` puts the offending character back into the input, then aborts without further processing the format string, leaving it to be read by the next call of `scanf`. Consider following examples of string formats and inputs: 
   - "%d/%d" with input 5/ 96
   - "%d/%d" with input 5 / 96 (if we want a whitespace after the first number, we must also include it in the string format -> "%d /%d")
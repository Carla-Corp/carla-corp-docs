# Introduction

Carla is a general-purpose systems programming language and toolchain designed to deliver low-level control closer to the metal than C, while maintaining modern ergonomics and a fast, extensible compilation model.

Carla treats the machine as the primary target. It was conceived as a thin, explicit wrapper over assembly with first-class support for concepts that are often hidden behind compiler attributes, flags, or toolchain conventions in C. This includes naked functions, fine-grained control over memory layout, sections, alignment, and calling conventions.

The language deliberately minimizes unnecessary abstractions. Struct layout is predictable and raw, with no implicit padding surprises. Memory management is based on arenas combined with defer for scoped automatic cleanup, while still allowing full manual allocation when desired.

# Hello World

Here is a simple Hello World made in Carla using `puts`.

```carla
@_start
void main = () {
  puts "Hello, world";
}
```

# Declarations

Carla declarations are composed by a type, an identifier and an operator.  
Being `;` a hopeless definition, and `=` a hopeful definition.

```carla
int32 identifier;
```

# Functions

Carla function declarations consist of a declaration, two code blocks, and optionally one or more behavioral keywords.

The first code block must contain declarations separated by commas. The second code block may contain any syntactically valid content.

```carla
int32 identifier = (int8 argument1, int16 argument2) {}
```

Of course, all functions can have a return value. Like in most programming languages, Carla uses the `return` keyword to specify the value that a function should return.

```carla
int32 identifier = () {
  return 14;
};
```

# Puts

`puts` is a built-in statement in Carla used to print static strings to standard output (stdout).

Unlike a regular library function, `puts` is a language keyword. It accepts only string literals or any compile-time constant string expression immediately after it. The compiler directly emits the most efficient system-specific mechanism to write the string — typically a direct syscall such as `write` on Unix-like systems — without any runtime formatting or unnecessary overhead.

```carla
puts "Hello, world";
```
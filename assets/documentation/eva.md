# Introduction

EVA is a human readable declarative configuration language focused on simplicity, composition and readability.

It was designed to provide a cleaner and more expressive alternative for application configuration, while remaining easy to parse, write and maintain.


```eva 
@project
name: "project name"
description: "that is an awesome project"
version: "3.20"

@author
name: "Jane Doe"\
contact: {
    phone: "00 999 000000"
    email: "xxx@xxx.com"
}
```


# How does EVA work?

Like TOML, YAML and other declarative languages such as TOON, EVA is designed to store structured data that can later be read and processed by applications.

However, while languages like TOON focus on token optimization and TOML focuses on readability and simplicity, EVA aims to provide both a clean configuration format and lightweight runtime data interpretation.

This allows applications to dynamically resolve values, execute utility functions and compose data during initialization, making configuration management more practical and expressive for developers.

## What do I mean by practicality?

EVA provides built in utility functions that simplify common configuration tasks.

For example:

```eva
@paths
home: env("HOME")
```

In this example, EVA resolves the user's `HOME` environment variable and stores the result inside `home` when the application starts.


# Namespaces

Namespaces are delimiters that you put into your EVA code to split your fields into different contexts. For example:


```eva
@target
name: "my-program"

@author
name: "Jane Doe"
```

When you try to get "Jane Doe", you need to look inside the `@author` namespace. See another example in TypeScript:


```typescript
const name = await config.get<string>("author", "name");
```

# Available types

In EVA, you have 5 types in total: `string`, `number`, `boolean`, `map`, and `list`.

Different language abstractions may treat these types differently. For example, C++ uses `eva::list` for lists instead of a native STL type like `std::vector` or `std::array`, and the same applies to maps with `eva::map`.

# JIT functions

EVA provides a collection of utility functions designed to remain simple and easy to use.

These functions can be used to work with dynamic data, access environment variables, and create formatted strings, among other common tasks.

Entendido! Segue a versão corrigida com nomes genéricos em inglês.

# absolute

Returns the absolute and normalized version of a filesystem path. This is useful when working with configuration files, imports, or assets and you want to ensure the path is consistent regardless of where the script is being executed.

Parameters:
- path (`string`) - Relative or absolute path

Returns: `string` - The normalized absolute path

Example:
You are in a project located at /home/user/myproject and need to access a folder called config inside the project. Using absolute("./config"), the function looks at the current directory (which is /home/user/myproject) and returns /home/user/myproject/config. Now you have a complete path that can be used anywhere in the code without depending on where the script was called.

```eva
absolute("./config")
' Returns: "/home/user/myproject/config"
```

# basename

Extracts and returns only the file name from a full path, removing any directory structure that comes before it. This is very useful when you need to display just the file name to the user or when you want to process files without caring about the folder they are in.

Parameters:
- path (`string`) - Full path to a file

Returns: `string` - Only the file name

Example:
You received a full file path like "/home/user/documents/photo.jpg" but only want to show the user the name "photo.jpg". Using basename("/home/user/documents/photo.jpg"), the function removes everything before the last slash and returns only "photo.jpg".

```eva
basename("/home/user/documents/photo.jpg")
' Returns: "photo.jpg"
```

# clamp

Restricts a numeric value so it does not go below a minimum nor above a maximum. This is useful when adjusting controls like volume, brightness, or any value that needs to stay within a specific range.

Parameters:
- value (`number`) - The value to be clamped
- min (`number`) - The minimum allowed limit
- max (`number`) - The maximum allowed limit

Returns: `number` - The value adjusted within the limits

Example:
Imagine you have a volume control that the user can adjust, but the system only accepts values between 0 and 100. The user tried to set the volume to 150. Using clamp(volume, 0, 100) with volume = 150, the function returns 100 because the value exceeded the maximum. If the user sets -10, the function returns 0 because the value fell below the minimum.

```eva
clamp(150, 0, 100)
' Returns: 100

clamp(-10, 0, 100)
' Returns: 0

clamp(75, 0, 100)
' Returns: 75
```

# coalesce

Analyzes a list of values and returns the first one that is not null, ignoring any null values that come before it. This is very useful when you have multiple sources for the same data and want to use the first one available.

Parameters:
- ...values (`any`) - A sequence of values to check

Returns: `any` - The first non-null value found

Example:
You are trying to get the port where a server will run. There are three possible sources: an environment variable, a configuration file, or a default value. If the environment variable is null, the configuration is null, but the default value is 8080. Using coalesce(env_port, config_port, default_port), the function returns 8080 because it was the first non-null value found.

```eva
coalesce(null, null, 8080)
' Returns: 8080

coalesce(3000, null, 8080)
' Returns: 3000

coalesce(null, "active", "inactive")
' Returns: "active"
```

# contains

Checks whether a value exists inside a string or an array. Returns true if the value is found, false otherwise. This is useful for validating if an item is present before processing it.

Parameters:
- collection (`string` or `array`) - Where to search
- value (`any`) - The value to look for

Returns: `boolean` - true if the value exists, false otherwise

Example:
You have a list of fruits and need to check if an apple is available before placing an order. Using contains(items, "apple") with items = ["banana", "apple", "orange"], the function returns true because "apple" is in the list. If you searched for "grape", it would return false.

```eva
items: ["banana", "apple", "orange"]
contains(items, "apple")
' Returns: true

contains(items, "grape")
' Returns: false

contains("hello world", "world")
' Returns: true
```

# debug

Prints or exposes the value passed to it for inspection purposes. The function does not transform the value; it simply returns the exact same value that was passed in, while also printing debug information internally. This is useful when you need to inspect the content of variables during development.

Parameters:
- value (`any`) - The value to be debugged

Returns: `any` - The exact same value that was passed

Example:
You are developing a feature and a variable is behaving strangely. You want to see what it contains without changing its behavior. Using debug(my_var), the function prints information about the variable but also returns the original value, so you can continue using it in expressions.

```eva
debug("potato")
' Prints: "potato"
' Returns: "potato"

debug(42)
' Prints: 42
' Returns: 42

result: debug(calculate_value())
' The debugged value is printed, but also stored in 'result'
```

# deepmerge

Merges two maps recursively. If there are nested maps inside the main maps, they will also be merged instead of being overwritten. This is useful when you have configurations with deep structures and want to combine them without losing data.

Parameters:
- target (`map`) - The base map
- source (`map`) - The map with values to be merged

Returns: `map` - The new map resulting from the recursive merge

Example:
You have a base configuration and a user configuration. The user defined only some options, but you want to preserve the rest. Using deepmerge(base, user), the function combines both maps. If both have the same key that contains another map, the inner values are merged rather than one completely replacing the other.

```eva
base: { a: 1 b: { x: 10 } }
user: { b: { y: 20 } c: 3 }
deepmerge(base, user)
```

Result:

```json
{
  "a": 1,
  "b": {
    "x": 10,
    "y": 20
  },
  "c": 3
}
```

# else

Returns a fallback value if the first value provided is null. Works similarly to coalesce, but for only two values. This is useful when you have an optional value and want to ensure a default.

Parameters:
- value (`any`) - The primary value
- fallback (`any`) - The alternative value if the primary is null

Returns: `any` - The original value if it is not null, or the fallback otherwise

Example:
You are reading a server port from a variable that might be null. If it is null, you want to use 8080 as the default. Using else(port, 8080), if port is null, the function returns 8080. If port is 3000, it returns 3000.

```eva
else(null, 8080)
' Returns: 8080

else(3000, 8080)
' Returns: 3000

else("text", "default")
' Returns: "text"
```

# endswith

Checks whether a string ends with a given suffix. Returns true if the string ends exactly with the specified suffix, false otherwise. This is useful for validating file extensions or text formats.

Parameters:
- text (`string`) - The string to check
- suffix (`string`) - The expected ending

Returns: `boolean` - true if the string ends with the suffix, false otherwise

Example:
You have a file name and need to know if it is a PNG image to process it correctly. Using endswith(name, ".png") with name = "photo.png", the function returns true because the string ends with ".png". If the file was named "photo.jpg", it would return false.

```eva
endswith("photo.png", ".png")
' Returns: true

endswith("photo.jpg", ".png")
' Returns: false

endswith("final_report.pdf", ".pdf")
' Returns: true
```

# entries

Returns all key-value pairs from a map as a list of pairs. Each pair is an array with two elements: the key and the corresponding value. This is useful when you need to iterate over a map or transform its data.

Parameters:
- map (`map`) - The map to convert

Returns: `array` - A list containing [key, value] pairs for each entry

Example:
You have a map with user information and need to send this data to an API that expects a list of pairs. Using entries(user), the function transforms the map into a list where each item is a two-element array.

```eva
user: { name: "Alex" age: 30 }
entries(user)
```

Result:

```json
[
  ["name", "Alex"],
  ["age", 30]
]
```

# env

Reads the value of an environment variable from the operating system. This is very useful for accessing sensitive configuration like passwords, API keys, or environment-specific settings without hardcoding them.

Parameters:
- name (`string`) - The name of the environment variable

Returns: `string` - The value of the environment variable, or null if it does not exist

Example:
You need to access the current user's home directory to save a configuration file. Using env("HOME") on a Linux or Mac system, the function returns "/home/user". On Windows, you would use env("USERPROFILE") to get "C:\Users\User". If the variable does not exist, it returns null.

```eva
env("HOME")
' Returns: "/home/user"

env("USERPROFILE")
' Returns: "C:\\Users\\User"

env("NONEXISTENT_VARIABLE")
' Returns: null
```

# extname

Extracts and returns the extension of a file name, including the dot. If the file has no extension, it returns an empty string. This is useful for filtering files by type or validating formats.

Parameters:
- path (`string`) - The file path or name

Returns: `string` - The file extension (including the dot), or an empty string if there is no extension

Example:
You are processing a list of files and want to separate only the images. Using extname("photo.png"), the function returns ".png". For a file called "document" with no dot, it returns "" (empty string). For "backup.tar.gz", the function returns only ".gz" (the last part), not ".tar.gz".

```eva
extname("photo.png")
' Returns: ".png"

extname("document")
' Returns: ""

extname("backup.tar.gz")
' Returns: ".gz"
```

# format

Formats a string by replacing placeholders with the provided values. Placeholders are typically indicated by {} or {0}, {1} depending on the implementation. This is useful for building dynamic messages or URLs.

Parameters:
- template (`string`) - The string with placeholders
- ...values (`any`) - The values to insert

Returns: `string` - The formatted string

Example:
You want to create a personalized welcome message for each user. Using format("Hello, {}", name) with name = "Alex", the function replaces {} with "Alex" and returns "Hello, Alex". You can also use multiple placeholders like format("{} + {} = {}", a, b, a+b).

```eva
format("Hello, {}", "Alex")
' Returns: "Hello, Alex"

format("{} + {} = {}", 2, 3, 5)
' Returns: "2 + 3 = 5"
```

# if

Returns one of two values based on a boolean condition. If the condition is true, returns the first value; if false, returns the second. This is a shorter alternative to simple conditional structures.

Parameters:
- condition (`boolean`) - The condition to evaluate
- trueValue (`any`) - Returned if condition is true
- falseValue (`any`) - Returned if condition is false

Returns: `any` - The value corresponding to the condition result

Example:
You have a debug variable that controls whether the system should show detailed information. Using if(debug, "yes", "no"), if debug is true, the function returns "yes"; if debug is false, it returns "no".

```eva
if(true, "yes", "no")
' Returns: "yes"

if(false, "yes", "no")
' Returns: "no"

if(10 > 5, "greater", "smaller")
' Returns: "greater"
```

# important

Marks a value or section as important, typically used to prevent it from being overwritten by other operations like merges or default values. The function returns the same value but with an internal marker that protects it.

Parameters:
- value (`any`) - The value to mark as important

Returns: `any` - The same value, but marked as important

Example:
You are merging configurations and want to ensure an authentication token is not replaced by a default value. Using important(token), the function returns the token with protection. When another merge tries to overwrite this value, the operation will be ignored.

```eva
token: "abc123"
important(token)
' Returns: "abc123" (marked as important)

' In a later merge, this token will not be overwritten
```

# keys

Returns all keys from a map as a list (array). This is useful when you need to know which properties exist in an object, or when you want to iterate only over the keys.

Parameters:
- map (`map`) - The map to inspect

Returns: `array` - A list containing all keys from the map

Example:
You have a configuration and need to list all available options to display in an interface. Using keys(config) with config containing host, port, and ssl, the function returns ["host", "port", "ssl"].

```eva
config: { host: "localhost" port: 8080 ssl: true }
keys(config)
' Returns: ["host", "port", "ssl"]
```

# lower

Converts all characters in a string to lowercase. Characters that are already lowercase remain unchanged, and accents are typically preserved. This is useful for standardizing text before comparisons or searches.

Parameters:
- text (`string`) - The text to convert

Returns: `string` - The text entirely in lowercase

Example:
You are implementing a search that should not be case-sensitive. Using lower(name) with name = "John Smith", the function returns "john smith". Now you can compare it with another text that has also been converted to lowercase.

```eva
lower("John Smith")
' Returns: "john smith"

lower("HELLO WORLD")
' Returns: "hello world"

lower("MiXeD CaSe")
' Returns: "mixed case"
```

# merge

Merges two maps shallowly, meaning only the first level is merged. If there are nested keys, they will be completely overwritten instead of merged. This is useful when you have simple structures and want to combine configurations.

Parameters:
- target (`map`) - The base map
- source (`map`) - The map with values to be merged

Returns: `map` - The new map resulting from the shallow merge

Example:
You have a base configuration and a user configuration. The user defined only some options. Using merge(base, user), the function combines both maps. If both have the same key, the user's value replaces the base's value. If that key contains another map, it is completely replaced, not merged.

```eva
base: { a: 1 b: { x: 10 } }
user: { b: { y: 20 } c: 3 }
merge(base, user)
```

Result:

```json
{
  "a": 1,
  "b": {
    "y": 20
  },
  "c": 3
}
```

Note that the original value `b: { x: 10 }` was completely lost and replaced by `b: { y: 20 }`.

# ref

References local values inside the same namespace, allowing you to reuse previously defined values. This is useful for avoiding duplication and maintaining consistency across different parts of a configuration.

Parameters:
- name (`string`) - The name of the reference

Returns: `any` - The referenced value

Example:
You are defining a configuration and have a home value that is used in several places. Instead of repeating the same value, you can use ref(home) to reference it. If the original value changes, all places using ref will be updated automatically.

```eva
home: "/home/user"
cache: ref(home) + "/.cache"
config: ref(home) + "/.config"
' cache and config both use the same home base value
```

# startswith

Checks whether a string starts with a given prefix. Returns true if the string starts exactly with the specified prefix, false otherwise. This is useful for validating paths, protocols, or text formats.

Parameters:
- text (`string`) - The string to check
- prefix (`string`) - The expected beginning

Returns: `boolean` - true if the string starts with the prefix, false otherwise

Example:
You have a path and need to check if it is inside the home directory for security reasons. Using startswith(path, "/home") with path = "/home/user/documents", the function returns true because the string starts with "/home". If the path was "/etc/config", it would return false.

```eva
startswith("/home/user/documents", "/home")
' Returns: true

startswith("/etc/config", "/home")
' Returns: false

startswith("https://google.com", "https")
' Returns: true
```

# trim

Removes all whitespace, tabs, and line breaks from the beginning and end of a string. Internal spaces between words remain intact. This is useful for cleaning user input or data coming from files.

Parameters:
- text (`string`) - The text to clean

Returns: `string` - The string without surrounding whitespace

Example:
A form submitted a name field with extra spaces at the beginning and end, like "   John Smith   ". Using trim(input), the function removes those spaces and returns "John Smith". Now the name can be stored cleanly.

```eva
trim("   John Smith   ")
' Returns: "John Smith"

trim("\n\tText with spaces\n")
' Returns: "Text with spaces"

trim("no spaces on edges")
' Returns: "no spaces on edges"
```

# upper

Converts all characters in a string to uppercase. Characters that are already uppercase remain unchanged, and accents are typically preserved. This is useful for standardizing text like codes or identifiers.

Parameters:
- text (`string`) - The text to convert

Returns: `string` - The text entirely in uppercase

Example:
You need to display a product code always in uppercase to maintain the database standard. Using upper(code) with code = "abc-123", the function returns "ABC-123".

```eva
upper("abc-123")
' Returns: "ABC-123"

upper("John Smith")
' Returns: "JOHN SMITH"

upper("hello WORLD")
' Returns: "HELLO WORLD"
```

# values

Returns all values from a map as a list (array), ignoring the keys. This is useful when you only need the values for processing, like summing numbers or displaying a list.

Parameters:
- map (`map`) - The map to inspect

Returns: `array` - A list containing all values from the map

Example:
You have a map with student grades and want to calculate the average of just the values, without worrying about the names. Using values(grades) with grades = { "StudentA": 8.5, "StudentB": 7.0, "StudentC": 9.0 }, the function returns [8.5, 7.0, 9.0]. Now you can sum them and divide easily.

```eva
grades: { StudentA: 8.5 StudentB: 7.0 StudentC: 9.0 }
values(grades)
' Returns: [8.5, 7.0, 9.0]

config: { host: "localhost" port: 8080 }
values(config)
' Returns: ["localhost", 8080]
```
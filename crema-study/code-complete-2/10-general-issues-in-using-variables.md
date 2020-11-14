## Ch10 General Issues in Using Variables

### 10.1 Data Literacy




### 10.2 Making Variable Declarations Easy

- Use naming conventions: Establish a naming convention for common suffixes such as *Num* and *No*. (More on chapter 11.5)




### 10.3 Guidelines for Initializing Variables

- Problems of improper variable declaration
  - No / partial assignment
  - Outdated value
- Solutions
  - Principle of Proximity
    - Initialize variables as they are declared / close to where they are declared.
      - `final` or `const`: prevent re-assignment.
    - Ideally, initialize variables close to where they are first **used**.
  - Some other things to consider... (10.8)
    - Detect non-initialized / unused variables if you can
      - Initialize working memory at the beginning of your program
    - Do not reuse variables unless you absolutely have to



### 10.4-5 Scope, Persistence

- Minimize the scope <=> Keep the variable life span (persistence) short
  - One reason to avoid global variables
- Group related statements (mental scope?)
- Intellectual manageability.
- Be suspicious about variables of which you cannot find the declarations



### 10.6 Binding Time

- Following are the times a variable can be bound to a value
  - Coding time (magic numbers)
  - **Compile time (use of a named constant)**
  - Load time (reading a value from an external source such as the Windows registry file or a Java properties file)
  - Object instantiation time (such as reading the value each time a window is created)
  - Just in time (such as reading the value each time the window is drawn)
- First option is not recommended
- The earlier the binding time, the lower the flexibility and the lower the complexity.



### 10.7 Relationship Between Data Types and Control Structures

- ???



### 10.8 Using Each Variable for Exactly One Purpose

- Use each variable for one purpose only
- Avoid variables with hidden meanings
  - e.g. Don't assign negative numbers to `pageCount` to indicate some other status.. Use separate boolean varible instead
- Make sure that all declared variables are used



### 10.9 Summary

- Rule of thumb in using variables
  - Make its name descriptive. (More on chapter 11)
  - Keep its scope as short as possible.
  - Use one variable for one and only one purpose


## Ch32 Self-Documenting Code

### 32.1 External Documentation

> Code as if whoever maintains your program is a violent psychopath who knows where you live.



- Unit development folders
  - Contains notes used by a developer during construction
- Detailed-design document
  - class-level or routine-level design decisions




### 32.2 Programming Style as Documentation

- good program structure, use of straightforward and easily understandable approaches, good variable names, good routine names, use of named constants instead of literals, clear layout, and minimization of control-flow and data-structure complexity...
- An example: code finding prime numbers
- CHECKLIST: Self-Documenting Code




### 32.3 To Comment or Not to Comment

- Moral of story: Use comments, if and only if they add something to the code!



### 32.4 Keys to Effective Comments

- Kinds of comments
  - Repeat of the Code
  - Explanation of the Code
  - Marker in the Code
    - `TODO`
  - **Summary of the Code**
  - **Description of the Code’s Intent**
  - Information That Cannot Possibly Be Expressed by the Code Itself
    - Copyright notices, confidentiality notices, version numbers, and other housekeeping details
- Commenting Efficiently
  - Use styles that don’t break down or discourage modification
  - Use the Pseudocode Programming Process to reduce commenting time
  - Integrate commenting into your development style (Rethink about your code design)



### 32.5 Commenting Techniques

- Commenting Individual Lines
  - Generally bad
  - When to Use Endline Comments
    - Annotate data declarations
- Commenting Paragraphs of Code
  - Write comments at the level of the code’s intent
  - Focus your documentation efforts on the code itself (self-documenting code!)
  - Focus paragraph comments on the why rather than the how
    - If focused on "how", the comment tends to repeat the code itself.
  - Use comments to prepare the reader for what is to follow
  - Document surprises
    - Explanations for unusual choices
  - Don’t comment tricky code; rewrite it
    - Don't produce tricky (difficult, unreadable) code in the first place
- Commenting Data Declarations
  - annotations on data are even more important than annotations on the processes in which the data is used
  - Comment the units of numeric data
    - Alternative: better variable names.
  - Comment the range of allowable numeric values
  - Comment coded meanings
    - Alternative: Enums.
  - Comment limitations on input data
    - Alternative: Assertions.
  - Document flags to the bit level
  - Document global data
    - Alternative: naming conventions.
- Commenting Control Structures
  - *Loop*s and *If*s often demand explanations
    - Clarify the purpose of the structure
- Commenting Routines
  - Describe each routine in one or two sentences at the top of the routine
  - Document parameters where they are declared
  - Take advantage of code documentation utilities such as Javadoc
  - Differentiate between input and output data
  - Document interface assumptions
    - Code's Intent
  - Comment on the routine’s limitations
  - Document the routine’s global effects
  - Document the source of algorithms that are used
  - Use comments to mark parts of your program
- Commenting Classes, Files, and Programs
  - Alternative: make good use of commit messages!


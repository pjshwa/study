- DRY(Don't Repeat Yourself): Try to hide instance variables into accessor methods, so that you can always redefine what the variable is meant to be without modifying several portions of code.

- Provide a reasonable interface when using complex data structures(i.e. 2d array), rather than directly accessing it. This is because if you have to change the data structure later, you can just modify the interface.

- Like classes, methods should also handle single responsibility. This boosts reusability and portability of code.

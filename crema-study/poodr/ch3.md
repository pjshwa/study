- Dependency of one class A to another class B exists when:
  - A knows B's name.
  - A knows what methods B's instance is able to respond to.
  - A knows what parameters B takes to initialize, and the order the parameters should be passed.

- Dependency injection: A's dependency to a particular class is not set until runtime. What A knows before runtime is now just what method it has to call on instance of whatever class (including B) given to it.

- If dependency injection is impossible due to complexity, isolate the code portions of A that is dependent to B. This makes dependency more clear.

- Isolate dangerous outbound calls inside wrapper methods.

- Use a 'hash of options' as an initializing parameter of class, to remove order dependency.

- Use 'Hash#fetch' instead of '||' operator when setting defaults. This allows setting 'false' or 'nil' values as default.

- To be general, isolate all dangerous portions that are subject to change by changes outside self.

- Factory: instance responsible to create other instances. i.e. A wrapper to some function in an external library.

- Reverse the direction of dependency. Depend on something that is less likely to change than self. Abstract classes are less likely to change, than concrete classes. i.e. it is better to make your class dependent to ruby's 'Array' class in its standard library, than making 'Array' dependent on yours, since your class is far more likely to change than class 'Array'.

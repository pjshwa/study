## Ch11 Working with Classes and Interfaces

### Using Constructor Functions

- Creates objects with given properties

```typescript
type Person = {
  id: string,
  name: string,
  city: string
};

let Employee = function(id: string, name: string, dept: string, city: string) {
  this.id = id;
  this.name = name;
  this.dept = dept;
  this.city = city;
};

Employee.prototype.writeDept = function() {
  console.log(`${this.name} works in ${this.dept}`);
};

let salesEmployee = new Employee("fvega", "Fidel Vega", "Sales", "Paris");
let data: (Person | Employee )[] = [
  { id: "bsmith", name: "Bob Smith", city: "London" },
  { id: "ajones", name: "Alice Jones", city: "Paris" },
  { id: "dpeters", name: "Dora Peters", city: "New York" },
  salesEmployee
];

data.forEach(item => {
  if (item instanceof Employee) {
    item.writeDept();
  } else {
    console.log(`${item.id} ${item.name}, ${item.city}`);
  }
});
```

- Above code produces compiler errors
- Typescript treats variable names and type names separately, so it still doesn't recognize `Employee` as a type


```typescript
type Person = {
  id: string,
  name: string,
  city: string
};

type Employee = {
  id: string,
  name: string,
  dept: string,
  city: string,
  writeDept: () => void
};

let Employee = function(id: string, name: string, dept: string, city: string) {
  this.id = id;
  this.name = name;
  this.dept = dept;
  this.city = city;
};

Employee.prototype.writeDept = function() {
  console.log(`${this.name} works in ${this.dept}`);
};

let salesEmployee = new Employee("fvega", "Fidel Vega", "Sales", "Paris");
let data: (Person | Employee )[] = [
  { id: "bsmith", name: "Bob Smith", city: "London" },
  { id: "ajones", name: "Alice Jones", city: "Paris" },
  { id: "dpeters", name: "Dora Peters", city: "New York" },
  salesEmployee
];

data.forEach(item => {
  if ("dept" in item) {
    item.writeDept();
  } else {
    console.log(`${item.id} ${item.name}, ${item.city}`);
  }
});
```

- Can match shape of `salesEmployee` object to `Employee` type
- But still does not recognize `salesEmployee` as an instance of `Employee`.



### Using Classes

- A way to handle above discrepancy

```typescript
type Person = {
  id: string,
  name: string,
  city: string
};

class Employee {
  id: string;
  name: string;
  dept: string;
  city: string;

  constructor(id: string, name: string, dept: string, city: string) {
    this.id = id;
    this.name = name;
    this.dept = dept;
    this.city = city;
  }
  writeDept() {
    console.log(`${this.name} works in ${this.dept}`);
  }
}
let salesEmployee = new Employee("fvega", "Fidel Vega", "Sales", "Paris");
let data: (Person | Employee )[] =
  [{ id: "bsmith", name: "Bob Smith", city: "London" },
  { id: "ajones", name: "Alice Jones", city: "Paris"},
  { id: "dpeters", name: "Dora Peters", city: "New York"},
  salesEmployee];

data.forEach(item => {
  if (item instanceof Employee) {
    item.writeDept();
  } else {
    console.log(`${item.id} ${item.name}, ${item.city}`);
  }
});
```

- Can use `instanceof` keyword to objects created from classes
- May be useful to check how typescript code compiles to pure javascript
  - Namely, type signatures are removed since they are only for compile time checks



#### Access Control

- public, private, protected
- Typescript only feature (compile time check)



#### ReadOnly

- Another Typescript only feature
- Prevents re-assignment of attribute



### Simplifying Class Constructors

- Can omit assignment of properties, if access control keywords are attached to parameters

```typescript
type Person = {
  id: string,
  name: string,
  city: string
};
class Employee {
  constructor(public readonly id: string, public name: string,
    private dept: string, public city: string) {
    // no statements required
  }
  writeDept() {
    console.log(`${this.name} works in ${this.dept}`);
  }
}
let salesEmployee = new Employee("fvega", "Fidel Vega", "Sales", "Paris");
salesEmployee.writeDept();
```



### Class Inheritance

```typescript
class Person {
  constructor(public id: string, public name: string, public city: string) {}
}
class Employee extends Person {
  constructor(
    public readonly id: string,
    public name: string,
    private dept: string,
    public city: string
  ) {
    super(id, name, city);
  }
  writeDept() {
    console.log(`${this.name} works in ${this.dept}`);
  }
}
let data = [
  new Person("bsmith", "Bob Smith", "London"),
  new Employee("fvega", "Fidel Vega", "Sales", "Paris"),
];
data.forEach((item) => {
  console.log(`Person: ${item.name}, ${item.city}`);
  if (item instanceof Employee) {
    item.writeDept();
  }
});
```

- `Person` type alias is replaced by class
- Caution: Typescript compiler may wrongly assume type when subclasses are mixed

```typescript
class Person {
  constructor(public id: string, public name: string, public city: string) {}
}
class Employee extends Person {
  constructor(
    public readonly id: string,
    public name: string,
    private dept: string,
    public city: string
  ) {
    super(id, name, city);
  }
  writeDept() {
    console.log(`${this.name} works in ${this.dept}`);
  }
}
class Customer extends Person {
  constructor(
    public readonly id: string,
    public name: string,
    public city: string,
    public creditLimit: number
  ) {
    super(id, name, city);
  }
}
class Supplier extends Person {
  constructor(
    public readonly id: string,
    public name: string,
    public city: string,
    public companyName: string
  ) {
    super(id, name, city);
  }
}
let data = [
  new Employee("fvega", "Fidel Vega", "Sales", "Paris"),
  new Customer("ajones", "Alice Jones", "London", 500),
];
data.push(new Supplier("dpeters", "Dora Peters", "New York", "Acme"));
data.forEach((item) => {
  console.log(`Person: ${item.name}, ${item.city}`);
  if (item instanceof Employee) {
    item.writeDept();
  } else if (item instanceof Customer) {
    console.log(`Customer ${item.name} has ${item.creditLimit} limit`);
  } else if (item instanceof Supplier) {
    console.log(`Supplier ${item.name} works for ${item.companyName}`);
  }
});
```

- `data`'s type is assumed as `Employee | Customer` here
- To prevent this, you must explicitly specify the intended type of `data`, which is `Person[]`

```typescript
class Person {
  constructor(public id: string, public name: string, public city: string) {}
}
class Employee extends Person {
  constructor(
    public readonly id: string,
    public name: string,
    private dept: string,
    public city: string
  ) {
    super(id, name, city);
  }
  writeDept() {
    console.log(`${this.name} works in ${this.dept}`);
  }
}
class Customer extends Person {
  constructor(
    public readonly id: string,
    public name: string,
    public city: string,
    public creditLimit: number
  ) {
    super(id, name, city);
  }
}
class Supplier extends Person {
  constructor(
    public readonly id: string,
    public name: string,
    public city: string,
    public companyName: string
  ) {
    super(id, name, city);
  }
}
let data: Person[] = [
  new Employee("fvega", "Fidel Vega", "Sales", "Paris"),
  new Customer("ajones", "Alice Jones", "London", 500),
];
data.push(new Supplier("dpeters", "Dora Peters", "New York", "Acme"));
data.forEach((item) => {
  console.log(`Person: ${item.name}, ${item.city}`);
  if (item instanceof Employee) {
    item.writeDept();
  } else if (item instanceof Customer) {
    console.log(`Customer ${item.name} has ${item.creditLimit} limit`);
  } else if (item instanceof Supplier) {
    console.log(`Supplier ${item.name} works for ${item.companyName}`);
  }
});
```



### Abstract Classes

- Typescript only feature

```typescript
abstract class Person {
  constructor(public id: string, public name: string, public city: string) {}
  getDetails(): string {
    return `${this.name}, ${this.getSpecificDetails()}`;
  }
  abstract getSpecificDetails(): string;
}
class Employee extends Person {
  constructor(
    public readonly id: string,
    public name: string,
    private dept: string,
    public city: string
  ) {
    super(id, name, city);
  }

  getSpecificDetails() {
    return `works in ${this.dept}`;
  }
}
class Customer extends Person {
  constructor(
    public readonly id: string,
    public name: string,
    public city: string,
    public creditLimit: number
  ) {
    super(id, name, city);
  }
  getSpecificDetails() {
    return `has ${this.creditLimit} limit`;
  }
}
class Supplier extends Person {
  constructor(
    public readonly id: string,
    public name: string,
    public city: string,
    public companyName: string
  ) {
    super(id, name, city);
  }
  getSpecificDetails() {
    return `works for ${this.companyName}`;
  }
}
let data: Person[] = [
  new Employee("fvega", "Fidel Vega", "Sales", "Paris"),
  new Customer("ajones", "Alice Jones", "London", 500),
];
data.push(new Supplier("dpeters", "Dora Peters", "New York", "Acme"));
data.forEach((item) => console.log(item.getDetails()));
```

- Can be used with `instanceof` keyword

```typescript
abstract class Person {
  constructor(public id: string, public name: string, public city: string) {}
  getDetails(): string {
    return `${this.name}, ${this.getSpecificDetails()}`;
  }
  abstract getSpecificDetails(): string;
}
class Employee extends Person {
  constructor(
    public readonly id: string,
    public name: string,
    private dept: string,
    public city: string
  ) {
    super(id, name, city);
  }

  getSpecificDetails() {
    return `works in ${this.dept}`;
  }
}
class Customer {
  constructor(
    public readonly id: string,
    public name: string,
    public city: string,
    public creditLimit: number
  ) {}
}
let data: (Person | Customer)[] = [
  new Employee("fvega", "Fidel Vega", "Sales", "Paris"),
  new Customer("ajones", "Alice Jones", "London", 500),
];
data.forEach((item) => {
  if (item instanceof Person) {
    console.log(item.getDetails());
  } else {
    console.log(`Customer: ${item.name}`);
  }
});
```



### Using Interfaces

- Similar to abstract classes, but does not implement constructors or methods

```typescript
interface Person {
  name: string;
  getDetails(): string;
}
class Employee implements Person {
  constructor(
    public readonly id: string,
    public name: string,
    private dept: string,
    public city: string
  ) {
    // no statements required
  }
  getDetails() {
    return `${this.name} works in ${this.dept}`;
  }
}
class Customer implements Person {
  constructor(
    public readonly id: string,
    public name: string,
    public city: string,
    public creditLimit: number
  ) {
    // no statements required
  }
  getDetails() {
    return `${this.name} has ${this.creditLimit} limit`;
  }
}
let data: Person[] = [
  new Employee("fvega", "Fidel Vega", "Sales", "Paris"),
  new Customer("ajones", "Alice Jones", "London", 500),
];
data.forEach((item) => console.log(item.getDetails()));
```

- Can be used to annotate type, like `Person[]` in above example
- One class can implement many interfaces

```typescript
interface Person {
  name: string;
  getDetails(): string;
}
interface DogOwner {
  dogName: string;
  getDogDetails(): string;
}
class Employee implements Person {
  constructor(
    public readonly id: string,
    public name: string,
    private dept: string,
    public city: string
  ) {
    // no statements required
  }
  getDetails() {
    return `${this.name} works in ${this.dept}`;
  }
}
class Customer implements Person, DogOwner {
  constructor(
    public readonly id: string,
    public name: string,
    public city: string,
    public creditLimit: number,
    public dogName
  ) {
    // no statements required
  }
  getDetails() {
    return `${this.name} has ${this.creditLimit} limit`;
  }
  getDogDetails() {
    return `${this.name} has a dog named ${this.dogName}`;
  }
}
let alice = new Customer("ajones", "Alice Jones", "London", 500, "Fido");
let dogOwners: DogOwner[] = [alice];
dogOwners.forEach((item) => console.log(item.getDogDetails()));
let data: Person[] = [
  new Employee("fvega", "Fidel Vega", "Sales", "Paris"),
  alice,
];
data.forEach((item) => console.log(item.getDetails()));
```

- One interface can extend another interface, just like class inheritance

```typescript
interface Person {
  name: string;
  getDetails(): string;
}
interface DogOwner extends Person {
  dogName: string;
  getDogDetails(): string;
}
```

- Interfaces can be used interchangeably with shape types

```typescript
type Person = {
  name: string;
  getDetails(): string;
};
class Employee implements Person {
  ...
```

```typescript
type NamedObject = {
  name: string;
};
interface Person extends NamedObject {
  getDetails(): string;
};
```

- Optional properties and methods can be added to Interfaces

```typescript
interface Person {
  name: string;
  getDetails(): string;
  dogName?: string;
  getDogDetails?(): string;
}
data.forEach(item => {
  console.log(item.getDetails());
  if (item.getDogDetails) {
    console.log(item.getDogDetails());
  }
});
```

- Abstract classes can implement interfaces, and may choose to implement some methods

```typescript
interface Person {
  name: string;
  getDetails(): string;
  dogName?: string;
  getDogDetails?(): string;
}
abstract class AbstractDogOwner implements Person {
  abstract name: string;
  abstract dogName?: string;
  abstract getDetails();
  getDogDetails() {
    if (this.dogName) {
      return `${this.name} has a dog called ${this.dogName}`;
    }
  }
}
```

#### Type Guarding an Interface

- Interface is a typescript only feature, so `instanceof` is not available
- Can only be type guarded by checking one or more properties that are defined by the interface



### Dynamically Creating Properties

- Typescript can allow dynamically created properties while preserving type safety
- Called *Index Signatures*
- Contains info about property's name and value types

```typescript
interface Product {
  name: string;
  price: number;
}
class SportsProduct implements Product {
  constructor(
    public name: string,
    public category: string,
    public price: number
  ) {
    // no statements required
  }
}
class ProductGroup {
  constructor(...initialProducts: [string, Product][]) {
    initialProducts.forEach((p) => (this[p[0]] = p[1]));
  }
  [propertyName: string]: Product;
}
let group = new ProductGroup([
  "shoes",
  new SportsProduct("Shoes", "Running", 90.5),
]);
group.hat = new SportsProduct("Hat", "Skiing", 20);
Object.keys(group).forEach((k) => console.log(`Property Name: ${k}`));
```

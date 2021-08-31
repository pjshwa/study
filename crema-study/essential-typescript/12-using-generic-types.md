## Ch12 Using Generic Types


### Creating Generic Classes

- Understand the problem: what if I want to create a collection class to handle either `Person` or `Product` class, but not both?
- Generic type parameters allow classes to be written that operate on a specific type without knowing what that type will be in advance

```typescript
import { Person, Product } from "./dataTypes";
let people = [
  new Person("Bob Smith", "London"),
  new Person("Dora Peters", "New York"),
];
class DataCollection<T> {
  private items: T[] = [];
  constructor(initialItems: T[]) {
    this.items.push(...initialItems);
  }
  add(newItem: T) {
    this.items.push(newItem);
  }
//   getNames(): string[] {
//     return this.items.map((item) => item.name);
//   }
  getItem(index: number): T {
    return this.items[index];
  }
}
let peopleData = new DataCollection<Person>(people);
let firstPerson = peopleData.getItem(0);
console.log(`First Person: ${firstPerson.name}, ${firstPerson.city}`);
```

- class `DataCollection` is currently running on `Person` type, but it can as well handle `Product` type.

```typescript
let productData = new DataCollection<Product>(products);
let firstProduct = productData.getItem(0);
console.log(`First Product: ${firstProduct.name}, ${firstProduct.price}`);
```

### Constraining Generic Type Values

- `getNames()` method was commented out, because by default generic classes assume `any` type, so we do not know whether `name` property will be available to the given type in advance.
- This can be resolved by constraining generic type values such that all possible type values contain `name` property

```typescript
class DataCollection<T extends (Person | Product)> 
```

- For `DataCollection` class, three possible types are allowed: `Person`, `Product`, or `Person | Product`.

### Constraining Generic Types Using a Shape

```typescript
class DataCollection<T extends { name: string }>
```

- Now, `DataCollection<T>` class can be instantiated using any type that has a name property that returns a string.

### Defining Multiple Type Parameters

```typescript
class DataCollection<T extends { name: string }, U>
```

### Applying a Type Parameter to a Method

```typescript
collate<U>(targetData: U[], itemProp: string, targetProp: string): (T & U)[] {
  let results = [];
  this.items.forEach((item) => {
    let match = targetData.find((d) => d[targetProp] === item[itemProp]);
    if (match !== undefined) {
      results.push({ ...match, ...item });
    }
  });
  return results;
}
```

- Call this method like this:

```typescript
peopleData.collate<City>(cities, "city", "name");
peopleData.collate<Employee>(employees, "name", "name");
```

- Or like this (compiler can infer type from the first argument):

```typescript
peopleData.collate(cities, "city", "name");
peopleData.collate(employees, "name", "name");
```

### Extending Generic Classes

- Adding functionality while maintaining generic type

```typescript
class SearchableCollection<T extends { name: string }> extends DataCollection<T>
```

- Adding functionality and narrowing down type

```typescript
class SearchableCollection extends DataCollection<Employee>
```

- Can be narrowed down to multiple types

```typescript
class SearchableCollection<T extends Employee | Person> extends DataCollection<T>
```

### Type Guarding Generic Types

- Generic types are a typescript only feature, so a definition of method like below is not possible

```typescript
filter<V extends T>(): V[]
```

- Thus, you should call this function with a predicate function parameter

```typescript
filter<V extends T>(predicate: (target) => target is V): V[]
```

### Defining a Static Method on a Generic Class

```typescript
static reverse<ArrayType>(items: ArrayType[]): ArrayType[] {
  return items.reverse();
}
```

```typescript
DataCollection.reverse<City>(cities);
```


### Defining Generic Interfaces

```typescript
type shapeType = { name: string };
interface Collection<T extends shapeType> {
  add(...newItems: T[]): void;
  get(name: string): T;
  count: number;
}
```

- Generic interfaces can also be extended

```typescript
interface Collection<T extends shapeType> {
  add(...newItems: T[]): void;
  get(name: string): T;
  count: number;
}
```

- Implementing a Generic Interface

```typescript
import { City, Person, Product, Employee } from "./dataTypes";
type shapeType = { name: string };
interface Collection<T extends shapeType> {
  add(...newItems: T[]): void;
  get(name: string): T;
  count: number;
}
class ArrayCollection<DataType extends shapeType>
  implements Collection<DataType>
{
  private items: DataType[] = [];
  add(...newItems): void {
    this.items.push(...newItems);
  }
  get(name: string): DataType {
    return this.items.find((item) => item.name === name);
  }
  get count(): number {
    return this.items.length;
  }
}
let peopleCollection: Collection<Person> = new ArrayCollection<Person>();
peopleCollection.add(
  new Person("Bob Smith", "London"),
  new Person("Dora Peters", "New York")
);
console.log(`Collection size: ${peopleCollection.count}`);
```

- Type Restriction

```typescript
class PersonCollection implements Collection<Person> 
```

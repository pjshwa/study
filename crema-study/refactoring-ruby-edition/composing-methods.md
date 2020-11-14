## Ch6 Composing Methods

- 거의 모든 코드의 문제는 method length 가 너무 긴 데에서부터 발생.



### Extract Method

- long method 의 code chunk 를 떼어서 별도의 method 를 만들고자 시도해 보자.
- 만들어진 별도의 method 는 하는 일을 굉장히 잘 표현해 주도록 naming 해야 한다.
- local-scope variable 이 해당 code chunk 에 의해 변경될 경우 **Split Temporary Variable** 혹은 **Replace Temp With Query** 를 사용해 보자.
- 아무리 해도 안 될 것 같으면 **Replace Method with Method Object** 를 사용하자.



### Inline Method

- **Extract Method** 와 반대의 motivation
- method body 가 method name 만큼 clear 한 경우, pointless indirection 을 줄이고 싶다.

- 안 좋은 코드를 모두 한 곳에 모았다가 다시 refactoring 하고 싶은 경우에도 사용



### Inline Temp

- 간단한 expression 의 result 가 담긴 temp variable 을 expression 자체로 replace



### Replace Temp with Query

- temp 는 long method 를 만들도록 유도하기 때문에, 가능하면 피하고 싶다.
- **Inline Temp** 와 같이, temp variable 을 만들지 않고 expression result 를 접근하고 싶다는 욕구(?) 에서 기인.
- **Extract Method** 실행하기 전 local variable 이 문제가 되는 경우가 있으므로, 보통 이 step 을 먼저 실행한다.



### Replace Temp with Chain

- chainable method 를 사용하여 temp 할당을 없앤다.
- **Inline Temp**, **Replace Temp with Query** 와 Motivation 은 동일함.



### Introduce Explaining Variable

- expression 이 이해하기 힘든 경우, variable name 으로 expression 을 설명하는 temp variable 을 도입할 수 있다.
- `is_mac_os = platform.upcase.index("MAC")`
- 하지만 가능하다면 항상 **Extract Method** 사용하자. temp 는 하나의 method 안에서만 접근 가능하지만 method 는 class 전체적으로 접근 가능하기 때문이다.



### Split Temporary Variable

- local variable 에 대한 할당 (assignment) 를 1회로 줄이려고 노력해보자.
- local variable name 을 앞에서부터 차근차근 변경
- collecting temp variable 일 경우, 이 방법을 쓸 수 없다.



### Remove Assignments to Parameters

- Ruby language 의 특성에 기인한 discussion
- Ruby 는 method parameter 를 *pass by value* 한다 ...?



### Replace Method with Method Object

- method name &rarr; class name, method local variables &rarr; class instance variables
- 이렇게 하면 temp variable 에 대해 신경쓰지 않고 자유롭게 method splitting 이 가능.



### Substitute Algorithm

- 더 좋은 알고리즘이 있으면 ... 그걸 사용해라? 띠용?



### Replace Loop with Collection Closure Method

- loop 을 돌면서 하는 반복적인 작업은 대부분 ruby 에서 제공하는 collection closure method 를 사용하여 간단하게 줄일 수 있다.
- code 가 이해하기 쉬워지고 ... 무엇보다 ruby 의 native 구현을 쓸 수 있다!



### Extract Surrounding Method

- 2개 이상의 method 가 share 하는 code chunk 가 있는데, 차이점이 method 중간에 있다?
- ex) Connection 실패 rescue 처리가 되어 있는 method.
- 이럴 땐 yield block 사용하여 빼내 보자.



### Introduce Class Annotation

- class 별로 common 한 method logic 의 경우, class annotation method 로 빼는 것을 고려해 보자.



### Introduce Named Parameter

### Remove Named Parameter



### Remove Unused Default Parameter

- default 값을 사용하지 않는 default parameter 가 있을 경우, default 값 할당을 제거
- 당연한 이야기



### Dynamic Method Definition

- metaprogramming territory
- `#define_method` 사용하여 반복적인 method 선언을 단순하게 표현 가능.



### Replace Dynamic Receptor with Dynamic Method Definition

- `#method_missing` 사용하는 class 의 경우 debugging 이 고통스럽다
- 가능한 case 에 대해서 dynamic 하게 method define 을 하면 좋다



### Isolate Dynamic Receptor



### Move Eval from Runtime to Parse Time



## Ch10 Making Method Calls Simpler



### Separate Query from Modifier

- method 의 query 부분과 modifier 부분을 나눠서 side effect 를 줄이고자 한다.


# Chapter 7. Gilded Rose

For each desired change, make the change easy (warning: this may be hard), then make the easy change.

*- Kent Beck*



1. 수정하기 가장 쉬운 것부터 찾아서 수정 합시다. 수정하고 난 뒤에는 그 다음으로 가장 쉬운 것을 찾아서 또 수정 합시다. [Dijkstra's Algorithm](https://ko.wikipedia.org/wiki/%EB%8D%B0%EC%9D%B4%ED%81%AC%EC%8A%A4%ED%8A%B8%EB%9D%BC_%EC%95%8C%EA%B3%A0%EB%A6%AC%EC%A6%98)



### Gilded Rose: A Refactoring Kata.

- Codebase Link: https://github.com/bparanj/gildie
  - 위 코드베이스에는 test 가 포함되어 있지만, test 가 없는 코드를 수정해야 할 일이 생길 수도 있습니다.
  - 이 경우 먼저 test 를 작성 합시다. [RailsConf 2015 - Getting a Handle on Legacy Code](https://www.youtube.com/watch?v=lsFFjFp7mEE)
  - Test 는 refactoring 과정에서의 실수를 방지하기 위한 safety network 같은 것입니다.
  - 지금 작성하는 Test 가 아름다울 필요는 없습니다. Refactoring 에 실수가 없었는지 확신할 수 있게만 해주면 됩니다.
    - 위의 1. 을 참고합시다.

- 미래에 있을 변화에 가장 신속하게 대응할 수 있도록 리팩토링을 하는 것이 옳다고 생각 합니다
- 지금 같은 경우, 모든 item 에 `quality` 속성이 있고, item 의 종류에 따라 quality 가 어떻게 변하는지가 다릅니다. 따라서 item 종류별로 class 를 만들어, 각 class 마다 handling logic 을 지정해 준다면 괜찮은 수정이 될 것입니다
- 가장 해보기 간단한 것은 `GildedRose#update_quality` 의 가독성을 좀 더 좋게 만드는 것입니다. 이것부터 시작해 봅시다.
  - 위의 1. 을 참고합시다.



### Refactoring the structure

- 코드를 보기 가장 힘든 이유는 한 item 에 적용되는 logic 이 여기저기 흩어져 있기 때문으로, 한 item 종류를 처리하는 logic 을 한 block 에 묶어두기만 해도 훨씬 가독성이 좋아질 것입니다.
    - 이 과정에서 생기는 duplication 에 대해서는 일단은 걱정 하지 맙시다. [AHA Programming](https://kentcdodds.com/blog/aha-programming)
- Method name 을 적절히 활용하여 작성자의 intent 를 표출해 주면 좋습니다.



### Tell-Don’t-Ask Principle

- Item 종류별로 class 를 만들어, 각 class 마다 handling logic 을 지정해 줍니다.



### Implementing the New Feature

- 새로운 Item class 를 만들면 됩니다.
- TDD 정신에 입거 테스트부터 수정 합시다.



### Retrospective

- The key takeaway of this kata is that we need to first focus on improving the form and structure before looking at doing object-oriented design. Form and structure provide the big picture. The refactorings that are related to lower-level details will fit the outline provided by the earlier refactorings that improved the form and structure of the code.
  - Item name 으로 block 을 구분하는 것과 class 로 구분하는 것이 비슷한 아이디어라고 생각이 드네요.



### 같이 보면 좋은 글

- TDD 의 장단점? https://dublin-java.tistory.com/54
- Another approach to Gilded Rose refactoring https://dev.to/lomig/a-walk-through-the-gilded-rose-kata-pt-1-do-not-break-anything-23b1
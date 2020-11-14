- 통계의 두 부류: parameter 가 constant 인가? 의 여부.
- Bayesian: 그 고정되었다는 constant 를 통계적으로 estimate 하려고 한다. → 근데 몰라! 모르는 건 정확한 게 아니다. → 이건 Random variable 이다. (== 전혀 모르겠다, 전혀 모르겠으니 flat 한 분포를 가정한다.(uniform))
- 대학생의 평균 키? 전혀 모르겠다? 혹은 적어도 150 이하이거나 190 이상이 아닐 건 안다. 그렇다면 weighted 분포를 가정한다.
- Bayesian 통계는, 데이터를 보기 전 parameter 의 성질을 가정한다. 이 성질의 가정은 사람에 따라 달라질 수 있다. 평균 키 고수는(평균 키만 측정해 왔던 사람) 더 좁은 range 를 가지고 예측할 수 있다.
- 전통적인 통계 모델에서는 parameter 가 같은, 같은 분포를 가지고 통계적 분석을 한다. Bayesian 모델에서는 사람에 따라 모수와 분포가 달라질 수 있으므로, 분석의 결과도 다르다.
- (내 생각) + (Data) => (Updated 생각)
- 생각과 Data 를 더하는 역할을 Bayes Theorem 이 수행함. .. 다른 theorem 을 절대로 사용하면 안 된다? 왜? 기독교 신자의 성경급, 불교 신자의 팔만 대장경급.
- Frequentist 는 모수의 추정 통계량을 세우기 위해 여러 가지 성질을 사용: unbiased, consistent, efficient/sufficient, maximum likelihood…
- 하지만 Bayesian 은 bayes theorem 만 쓴다.
- 그렇다면 하나밖에 없으니, 배울 게 더 적으냐? 아니 …

- 보험 회사에서 보험 금액을 측정한다
	- (내 생각) + (Data) => (Updated 생각) + (올해 Data) => (내년 Updated 생각) …
	- 한번 사용된 Data 에서의 모든 parameter 에 대한 정보는 exploit 된다. (Updated 생각에 다 들어 있다는 소리) 따라서 내년 같은 분석을 할 때 다시 끄집어 내 올 필요가 없다.
- Frequentists: parameters are unknown but constant
- Bayesians: parameters are unknown and hence random.

- Principles of subjective probability
- [well-shuffled card deck example] My SUBJECTIVE degree of belief that the top card of a well-shuffled card deck is the ace of hearts, is 1/52.
- What is a principle? 맞다고 증명할 수는 없지만, 각자가 가지고 있는 믿음? 옳다고 생각하는 것?
- *First principle of subjective probability*
	- Probability is not a predetermined value fixed by nature.
	- We can calculate probability of events which can only occur once. (통일될 확률? 문재인이 생각하길, 10년 내 통일될 확률? 김정은이? 홍준표가?)

- *Second principle of subjective probability*
	- Anything which you do not know is random. ex) parameter.
	- Anything which you do know is fixed, and should be used as info in evaluating probabilities. (Use any info about a parameter as a prior distribution)
	- Latin: *a priori* (before experiment/data), *a posteriori* (after)
	- (내 생각): prior distn, (Data): Likelihood.

- Bayes’ rule: Theta based on data, can be made from prior distn of parameter + data based on theta. (곱씹어 보자.)
	- posterior is proportional to prior * likelihood.

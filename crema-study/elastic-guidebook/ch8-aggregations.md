## Ch8 Aggregations

- Data we'll be using throughout this chapter

```PUT my_stations/_bulk
{"index": {"_id": "1"}}
{"date": "2019-06-01", "line": "1호선", "station": "종각", "passangers": 2314}
{"index": {"_id": "2"}}
{"date": "2019-06-01", "line": "2호선", "station": "강남", "passangers": 5412}
{"index": {"_id": "3"}}
{"date": "2019-07-10", "line": "2호선", "station": "강남", "passangers": 6221}
{"index": {"_id": "4"}}
{"date": "2019-07-15", "line": "2호선", "station": "강남", "passangers": 6478}
{"index": {"_id": "5"}}
{"date": "2019-08-07", "line": "2호선", "station": "강남", "passangers": 5821}
{"index": {"_id": "6"}}
{"date": "2019-08-18", "line": "2호선", "station": "강남", "passangers": 5724}
{"index": {"_id": "7"}}
{"date": "2019-09-02", "line": "2호선", "station": "신촌", "passangers": 3912}
{"index": {"_id": "8"}}
{"date": "2019-09-11", "line": "3호선", "station": "양재", "passangers": 4121}
{"index": {"_id": "9"}}
{"date": "2019-09-20", "line": "3호선", "station": "홍제", "passangers": 1021}
{"index": {"_id": "10"}}
{"date": "2019-10-01", "line": "3호선", "station": "불광", "passangers": 971}
```

- Go to http://localhost:5601/app/dev_tools#/console and copy paste above data



#### 8.1 Metrics Aggregations

- Aggregations format

```GET my_stations/_search
{
  "size": 0,
  "aggs": {
    "all_passangers": {
      "<AGG-TYPE>": {
        "field": "passangers"
      }
    }
  }
}
```

- `<AGG-TYPE>` can be **min, max, sum, avg**,...

- Value cardinality (agg type `cardinality`), percentiles and percentile ranks are also supported



#### 8.2 Buckets Aggregations

- Groups data according to certain conditions (similar to `GROUP BY` in SQL)
- `<AGG-TYPE>` can be **range, histogram, date_range, date_histogram**,...
- Agg type **terms** groups data according to values of field



#### 8.3 Sub-Aggregations

- Can recursively perform buckets or metrics aggregation to results of buckets aggregations
- e.g. Average passengers count by line number
- **ㅁㅁ별** ㅇㅇ의 **



#### 8.4 Pipeline Aggregations

- Can perform aggregations with outputs of another aggregation
- e.g. 평균의 최댓값, 지하철 노선별 이용자 수의 합의 누적, ...


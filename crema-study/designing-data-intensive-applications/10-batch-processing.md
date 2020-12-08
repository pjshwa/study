## Ch10 Batch Processing

### Types of Systems
- Services (online systems)
  - "Response time" is a primary measure
- Batch processing systems (offline systems)
  - "Throughput" is a primary measure
- Stream processing systems (near-real-time systems)
  - Similar to batch processing systems, but jobs execute shortly after events happen



### Unix Philosophy

1. Make each program do one thing, and one thing well.
   1. `awk` does filtering well. `sort` does sorting well.
2. Expect the output of every program to become the input to another program.
   1. Providing a uniform interface (file descriptors)

- Two principles which became foundations of modern batch processor systems



### MapReduce

- Distributed FileSystems
  - *NameNode* + Distributed files as an abstraction.
  - Replication of same data to several servers for fault tolerance (Similar to RAID)

- MapReduce Job
  - Mapper: Extract key-value data from input
  - Sort the extracted key-value pairs by key
  - Reducer: Output a single value (summarized data) by key
  - Suitable for any job that can be divided & conquered
- Distributed Execution
  - (input) -> [Mapper] -> [Shuffle (sort by key)] -> (intermediary output) -> [Reducer] -> (output)
  - Mapper output data of same key always goes into same reducer (or..?)
- MapReduce workflows
  - Range of problems you can solve with a single MapReduce job is limited.
    - Has to do with # of sorts required? :thinking:
  - Therefore it is common for MapReduce jobs to be chained
  - Output of a job is always fully materialized (Materialization of Intermediate State)
- Reduce-Side Joins
  - Querying for information in every parallel process could overwhelm the database
  - Usually done by also putting the join target in the MapReduce process + performing a sort-merge join.
- Handling skew
  - When there is a very large amount of data related to a single key (*hot key*)
  - Engines have their own ways of distributing the load
  - Aggregation of particular key can be done throughout 2 or more MapReduce jobs
- Map-Side Joins
  - If join target is small enough to fit in memory
    - Broadcast hash joins
    - Partitioned hash joins
  - If join target can be readily available throughout the input scan
    - Map-side merge joins
  - Preparing reducer input becomes simple -> results in fast speed
- Output of batch workflows
  - Building search indexes
    - Results in "index files"
    - Incremental build = Asynchronous merging
  - Queryable data
    - Writing directly into the OLTP system is a bad idea
      - Database is overwhelmed
      - Faulty writing cannot be hidden by MapReduce abstraction
    - Write out a new database, then bulk import the data
  - Philosophy of batch process outputs
    - Separate logic from wiring (like unix tools)
    - Input is immutable
      - More assumptions can be made -> debugging is easy
    - Input is materialized
      - Reusable
- Comparing Hadoop to Distributed Databases
  - MPP databases
    - Designed to parallelize analytic queries
  - Diversity of storage in Hadoop
    - Trying out ideas up front
    - Useful for ETL processes
  - Diversity of processing models in Hadoop
    - Models that cannot be expressed by SQL
  - Designing for frequent faults
    - Sacrifice speed for recoverability
    - Not just because of hardware faults, but for **preemptibility** of tasks
      - Tasks should be ready for abrupt cancellation



### Beyond MapReduce

- Materialization of Intermediate State
  - Pros: Reusable, loosely coupled jobs
  - Cons
    - In most of cases, aspects of "Pros" don't hold
    - Harshly affected by straggler (long lingering) tasks
      - "Sort" always has to wait for full input
    - Mappers are often redundant
      - In tasks like "Sort + Reduce + Sort + Reduce + ..."
- Dataflow engines
  - Spark, Tez, Flink, ...
    - They all handle an entire workflow as one job
  - No strict roles like *Map* and *Reduce*, instead functions can be assembled in more flexible ways.
    - Called *operator*s
  - Connecting options between operators
    - Shuffle (Traditional MapReduce method of repartitioning + sorting)
    - Shuffle but skip the sorting
  - Advantages of this model
    - Sorting need only be performed in places necessary
    - No unnecessary map tasks
    - Intermediate states need not be written to disk -> better throughput
    - Operators can start executing as soon as their input is ready
  - Fault tolerance
    - Intermediate states are not available for recomputation
    - Keep track of how a given piece of data is computed
      - Which input partitions are used
      - Which operators were applied
    - Works best if operators are deterministic
    - Materializing intermediate state is the best option for fault tolerance still
- Graphs and Iterative Processing
  - Input data is in a graph form
  - Parallel execution is done per vertex
- High-Level APIs and Languages
  - Writing mapper & reducer functions turns out to be tedious
  - High-level abstractions (Declarative SQL) comes into play.. once again
    - Seems like a step backwards (like what MPP databases were doing)
    - But now we have a choice (Abstraction VS Flexibility)
  - Specialized abstractions for different domains
    - Some common tasks & algorithms (plugin form)





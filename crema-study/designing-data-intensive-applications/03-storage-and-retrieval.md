## Ch3 Storage and Retrieval

- Why should an application developer care about the internal structure of a database?



### Data Structures That Power Your Database

- Tradeoff between read performance and write performance: you cannot have both!
- Make use of some data structures to balance the two.




### Hash Indexes

- Maintain an additional in-memory key-value pair
  - where key = actual data key, value = byte offset of actual data value
  - Reading becomes *O(1)*, writing is still *O(1)* with some extra work (maintaining the index pairs)
  - However, disk space can run out fast, since writing is append-only
    - Additional background thread to do compaction + merging of logs
- Implementation details
  - Deletion: "Tombstones"
  - Crash recovery
    - Building the in-memory hash index from ground up can consume lots of time
    - Store snapshots of hash maps of each segment for fast recovery
  - Partially written records: maintain checksums
  - Concurrency: Sole writer thread
- Why don't we update the logs in place?
  - Sequential writes are generally much faster than random writes
  - Error recovery is much simple if segments are immutable
- Downsides
  - Hash table must fit in memory: won't be practical in cases with lots of KEYS
  - Bad range query performance
  - 요약: 확장성이 떨어진다!!




### Sorted String Tables (SSTables)

- Segment files are *sorted by key*
- Some advantages over hash indexes
  - Merging segments is more efficient
  - Memory savings with sorted sparse index table + single segment search
    - Don't have to hold ALL KEYS in memory + still reasonable search time complexity (*O(log n)*)
- Constructing and maintaining SSTables
  - Don't delegate every requests to disk; instead, use an in-memory data structure as a buffer. (Typically a tree, to keep the data sorted at all times in reasonable costs)



### Log-Structured Merge Trees (LSM Trees)

- SSTables structure as disk component + Balanced tree (AVL, red-black, ..) as memory component
- Characteristics summary
  - Memtable (sparse index table, usually implemented with a balanced tree)
  - SSTables (sorted data segments on disk, possibly with some duplicates)
    - Sequential writes
- Performance optimizations
  - Bloom filters to decisively reject all non-existent keys
  - Some efficient compaction strategies



### B-Trees

- Key-values pairs sorted by key, but with very different design philosophy than LSM trees
  - Mainly, utilizing fixed-size blocks instead of variable sized segments
  - Each block consists of values with pointers to them (Except leaf blocks, where only value nodes exist)
  - The insertion algorithm guarantees tree depth of *O(log n)*
  - Writes are slower than LSM trees, i.e. amortized *O(log n)*
- Writing, is a dangerous operation by design
  - Modifies files in-place, therefore open to data corruption on crashes
  - Introduce write-ahead logs (WALs), which is a sequence of logs of all modifications to the B-tree
    - Can now recreate the tree state before corruption
- Optimizations
  - Copy-on-write schemes
    - No in-place mods, instead write a new page
  - Try to locate leaf nodes with nearby key ranges in nearby positions of the actual disk
  - Additional pointers between leaf nodes for better range query performances



### Other Indexing Structures

- Secondary Indexes
- Clustered & Covering Indexes
  - Index includes values from SOME columns in itself
- Fuzzy Indexes
  - Use trie data structure (finite state automaton) to filter similar words
    - Levenshtein distance



### Transaction Processing or Analytics?

- What characteristics of databases do ANALYTIC queries demand?
  - Aggregate over large number of records
  - History of events that happened over time
- Data Warehouse
  - Simply put, a separate database that analysts can query to their hearts’ content, without affecting OLTP operations



### Stars and Snowflakes: Schemas for Analytics

- Includes A LOT of joins!
- Fact tables
  - A sequence of captured events, with attributes that point to databases (Logs)



### Column-Oriented Storage

- Store all the values from each column together instead
- Compression is easy, since columns tend to have more duplicate values than rows
  - Usually done by bitmap representation of each value
- AND & OR operations are easy because computers are good at bitwise operations
- Memory bandwidth and vectorized processing
- Sort Order in Column Storage
  - Makes frequent access to same data easier, but compression becomes harder
- Writing to Column-Oriented Storage
  - Hard!
  - Rewrite all column files



### Aggregation: Data Cubes and Materialized Views

- A metadata table to cache some frequetly accessed statistics
  - Sums, counts, ...




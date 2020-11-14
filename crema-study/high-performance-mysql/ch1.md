- MySQL logical architecture:
  - Clients ->
  - Connection/thread handler ->
  - Query parser & cache ->
  - Optimizer ->
  - Storage engine VIA Storage Engine API

- Connection Management and Security:
  - Authenticate with username, origin host and password
  - Privilege check for each query the client is issuing

- Optimization and Execution
  - Optimization from query rewriting
  - Optimization with storage engine capabilities (i.e. storage enging supports indexing)
  - Query cache

- Concurrency Control
  - Read locks are 'Shared'.
  - Write locks are 'Exclusive': prevents all read/writes.
  - Lock Granularity: Locks consume resources & cause overhead.
  - Table/Row locks. Sacrifices concurrency with less overhead, and vice versa.

- Transactions
  - Atomic unit of work. Group of SQL queries that should be processed as a whole (All or nothing)
  - Transactions are not enough, unless the server passes ACID test. What is it?
    * Atomicity: There is no such thing as partially completed transaction, it's all or nothing.
    * Consistency: DB server should always move from one consistent state from another. Changes made by portions of transaction is never actually reflected in the db, unless the whole transaction succeeds.
    * Isolation: No change from transaction is usually revealed to other queries before the whole transaction is complete.
    * Durability: Changes from a transaction is permanent once committed.

  - Isolation levels
    * READ UNCOMMITTED
    * READ COMMITTED
    * REPEATABLE READ: Several reads from a single transaction should always yield same data. To achieve this, no UPDATES to the dataset the transaction is referencing is allowed. However, INSERTS are allowed, which can cause phantom row problems.
    * SERIALIZABLE: REPEATABLE READ + disable INSERTS to datasets the transaction is referencing.

  - Deadlocks
    * Happens when multiple processes try to lock the same resource.
    * Prevent by deadlock detection & timeouts
    * Rollback strategy: (InnoDB) rollback whichever transaction that has the fewest exclusive row locks

- Transaction Logging
  - Instead of directly writing changes to table on disk, write them on the in-memory copy of data in storage engine.
  - Then the storage engine writes a RECORD of change to disk, which is relatively fast since it only includes sequential I/Os in a small portion of disk.
  - At some later time, a process updates the tables on disk.

- Transactions in MySQL

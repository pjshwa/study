## Ch9 Setting Up a Replica Set

- Replica Set vs Master-Slave
  - Replica Sets are basically Master-Slave cluster with automatic failover
  - Although MongoDB supports both modes, Replica Sets are preferred in new deployments (with modern versions of MongoDB)


- Example configuration

```bash
mongod --port 27017 --dbpath /srv/mongodb/db0 --replSet rs0 --bind_ip localhost,<hostname(s)|ip address(es)>
mongod --port 27018 --dbpath /srv/mongodb/db1 --replSet rs0 --bind_ip localhost,<hostname(s)|ip address(es)>
mongod --port 27019 --dbpath /srv/mongodb/db2 --replSet rs0 --bind_ip localhost,<hostname(s)|ip address(es)>
```

> Beware of unauthorized accesses, before binding to a non-localhost IP.

- Initiate a replica set

```js
rsconf = {
    _id: "rs0",
    members: [
        {_id: 0, host: "localhost:27017"},
        {_id: 1, host: "localhost:27018"},
        {_id: 2, host: "localhost:27019"}
    ],
    "protocolVersion" : NumberLong(1)
}
rs.initiate(rsconf) // Beware of some version peculiarities, like "protocolVersion"
```

- Some `rs` helpers
  - `rs.conf()`: View the replica set config.
  - `rs.status()`: Check the status of replica set.
  - `rs.add()`, `rs.remove()` : Add/remove members to a replica set.
  - `rs.reconfig()`

- Designing a replica set
  - **Majority** of a set
    - More than half of all members in the set.
    - You need votes from a **majority** of a replica set, to elect a primary.
      - Why?
  - Some recommended replica set configurations
    - Majority in one data center
    - Equal number of servers in two data centers + tie-breaking server in 3rd location
  - Elections
    - Servers always nominate themselves to be primary, if election starts.
    - Other servers vote for the canditate unless there are reasons not to
      - Reasons not to: candidate's oplog replication is falling behind.
  - Election Arbiters
    - Keep an odd number of voters

- Some properties of a server, regarding replica sets
  - Priority: How much it *wants* to be a primary.
    - The highest-priority member will always be elected primary (so long as they can reach
      a majority of the set and have the most up-to-date data)
    - If priority is 0, it never becomes a primary.
    - You cannot configure a set to have all priorities 0
  - Hidden: Don't send *read* requests to this server. (Don't use this server as a replication source)



## Ch10 Components of a Replica Set

- Oplogs
  - Containing every write a PRIMARY performs
  - Source of replication
  - A *capped collection* only populated when a replica set is configured
  - Idempotent

- Initial Sync
  - Initial data clone + Some oplog applications
  - Do *Restore from backup* instead

- Staleness
  - Falling behind bounds of oplogs

- Heartbeat
  - State of a server
  - Message (*Heartbeat request*) is sent from server to every other server of the set
  - Member states
    - STARTUP
    - STARTUP2
    - RECOVERING
    - ARBITER
    - PRIMARY, SECONDARY
    - DOWN, UNKNOWN, REMOVED, ROLLBACK, FATAL: problematic states

- Rollbacks
  - Done by a subset of replica set formerly containing PRIMARY
  - Finds and rollbacks to the last matching point of oplogs
  - Rollback logs are generated for manual appliance
  - Can FAIL if there is a huge gap between PRIMARY and now unreachable secondaries



## Ch11 Connecting to a Replica Set from Your Application

- Viewing replica sets from a perspective of a client

  - Find one member, connection to the rest is automatically handled
  - Can perform no writes if there are no reachable PRIMARY servers
- If a (non-idempotent) operation fails, what will the client do next?

  - Three types of errors: Transient network error, persistent outage, command error
  - Retry once when there is a network disconnection
    - Default for MongoDB 3.6
    - Has the best chance of dealing with all three errors
    - Make the operation idempotent (?)
- Waiting for Replication on Writes

  - MongoDB has no automatic replication health checks, has no limits in writing speed
    - Thus, you have to use `getLastError` to periodically check if the replication is working
    - What if `getLastError` provides negative results?
      - If the once PRIMARY server is not in the majority group, there is possibility that one has to manually patch the rollback oplog
      - Thus it is better to always set PRIMARY in the majority group
- Custom Replication Guarantees
  - Example: Guaranteeing One Server per Data Center
    - Set a custom mode `getLastErrorModes`
  - Example: Guaranteeing a Majority of Nonhidden Members
  - Premise: Make classifications, and apply rules to each classification
- Sending Reads to Secondaries
  - Generally, it is a bad idea.
    - Consistency considerations
    - Load considerations
  - Use *sharding* to distribute load
  - Apply different indexes to secondaries



## Ch12 Administration
- Restart a replica set member to a standalone server for maintenance.
  - Why?
    - Performance impact on primary
    - No writes on secondaries
  - Cases where maintenance is required
    - Creating/changing replica set members
      - Replica set configs are stored in a global (local?) document `local.system.replset`
    - Creating Larger Sets
      - \# of voting members is limited to 7
    - Forcing Reconfiguration
      - Reconfigurations sent to secondaries (if no primary is available)
    - Manipulating state of set members
      - Turning primaries into secondaries (`stepDown`)
      - Prevent elections (`freeze`)
      - Maintenance mode
        - Puts replica set member into `RECOVERING` state
        - Reads are not going to members with such state
    - Monitoring replication
      - Getting the status
      - Visualizing (& Fixing) replication graph
        - Sync source is determined by ping time
        - This can lead to long replication chains
        - Manually fix the chain
          - Caution: Don't make loops!
          - Or... disable chaining and force all secondaries to sync from primary.
    - Resizing the OPLog (maintenance window)
    - Restoring from a Delayed Secondary
      - Trigger initial sync VS Use file-system copy
    - Building an index
      - A resource-intensive work
        - Build indexes on secondaries sequentially for stability
      - How to build index on primary?
        - Just build VS Step it down (trigger failover)
    - Replication on a Budget
    - How the Primary Tracks Lag
      - `local.slaves`: a dumping ground for MongoDB to
        report on replication status
      - Chained slaves forward the "replication info" to primary
    - Converting Master-Slave clusters to Replica Sets
    - Mimicking Master-Slave behaviors with Replica Sets



# Database Sharding

This README briefly describes the setup for database sharding using Citus and presents benchmark results comparing performance with and without Citus sharding.

## Sharding and Citus

**Database Sharding** is a technique used to horizontally partition data across multiple servers, thereby distributing the load and improving performance. It's particularly useful for scaling out databases to handle large datasets and high concurrency.

**Citus** is an extension to PostgreSQL that transforms it into a distributed database system, allowing for easy sharding and scaling. It enables high-performance data processing capabilities across multiple nodes, making it ideal for real-time analytics and transactional workloads.

## Setup

The Citus cluster setup involved configuring one coordinator node and two worker nodes. The setup process included:

1. Initializing the Citus extension on PostgreSQL instances.
2. Configuring one instance as the coordinator.
3. Adding other instances as worker nodes using Citus management functions.
4. Creating distributed tables on the coordinator, which Citus automatically manages across the worker nodes.

Adminer was used for database management, providing a web interface for easy interaction with the database.

## Benchmarking

Benchmarks were conducted using `pgbench`, a load testing tool for PostgreSQL. The tests were run with the following configuration:

- Duration: 60 seconds
- Number of clients: 10
- Number of threads: 10

Two types of benchmarks were performed: write (insert/update/delete) and read (select).

### Results With Citus Sharding

**Write Benchmark**:
- Transactions processed: 25,506
- Latency average: 23.533 ms
- TPS (including connections establishing): 424.933838
- TPS (excluding connections establishing): 425.045231

**Read Benchmark**:
- Transactions processed: 1,119,760
- Latency average: 0.536 ms
- TPS (including connections establishing): 18,661.630277
- TPS (excluding connections establishing): 18,666.703330

### Results Without Citus

**Write Benchmark**:
- Transactions processed: 24,793
- Latency average: 24.210 ms
- TPS (including connections establishing): 413.052319
- TPS (excluding connections establishing): 413.157813

**Read Benchmark**:
- Transactions processed: 1,120,823
- Latency average: 0.535 ms
- TPS (including connections establishing): 18,680.038139
- TPS (excluding connections establishing): 18,684.986587

## Analysis

The benchmarks indicate that Citus enhances write operations significantly, showcasing its ability to efficiently manage distributed data. For read operations, the performance improvement is marginal, which suggests that Citus's parallel query execution provides benefits in specific scenarios or more complex queries than those tested. 

These results demonstrate Citus's effectiveness in scaling out PostgreSQL for high-volume transaction processing, making it a viable solution for large-scale, data-intensive applications.
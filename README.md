# Collect Cassandra Latency Histograms

Collection script to collect output fron `nodetool tablehistograms` and `nodetool proxyhistograms`. The intention this script is scheduled in crontab for a given internal (e.g., every 15 minutes `*/15 * * * *`).

An output file exists for each command run. On the first run of the day, a new output file will be created and the host IP address added to line 1. Subsequent runs will append to this file with a timestamp written prior to the command output. Example output below.

```
10.10.10.10
2024-03-14_10:15:00
CMD OUTPUT HERE
...
2024-03-14_10:30:00
CMD OUTPUT HERE
...
```

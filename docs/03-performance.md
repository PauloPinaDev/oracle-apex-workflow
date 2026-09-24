# SQL Performance Analysis

  ## Test 1 — Ticket Search
  
    ### Query
    ---sql
    SELECT
        t.ticket_id,
        t.title,
        t.priority,
        t.status,
        t.created_at
    FROM tickets t
    WHERE t.status = 'OPEN'
    ORDER BY t.created_at DESC;


    Dataset
10,005 tickets
Approximately 25% OPEN
Test data generated using PL/SQL
Indexes Tested
IDX_TICKETS_STATUS
IDX_TICKETS_CREATED_AT
IDX_TICKETS_STATUS_CREATED
Execution Plan — IDX_TICKETS_STATUS

The optimizer selected IDX_TICKETS_STATUS.

Plan:

INDEX RANGE SCAN
→ TABLE ACCESS BY INDEX ROWID BATCHED
→ SORT ORDER BY

Estimated cost: 17

Execution Plan — IDX_TICKETS_STATUS_CREATED

With IDX_TICKETS_STATUS made invisible, the optimizer selected
IDX_TICKETS_STATUS_CREATED.

Plan:

INDEX RANGE SCAN
→ TABLE ACCESS BY INDEX ROWID

Estimated cost: 71

The composite index eliminates the explicit ORDER BY sort,
but the optimizer estimates a higher overall cost.

Observation

The composite index does not automatically provide a lower
estimated cost.

The optimizer evaluates the complete access path, including:

number of rows expected
index access
table access
sorting
estimated cost

Therefore, index selection should be validated against the
actual workload rather than assuming that a composite index
will always perform better.

Conclusion

For this query and current dataset, Oracle's optimizer prefers
the single-column STATUS index.

Further testing with larger and more representative workloads
is required before deciding whether the composite index should
be retained.

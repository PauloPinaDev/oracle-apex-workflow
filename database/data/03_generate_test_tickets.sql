-- ============================================================
-- WorkFlow - Generate Test Tickets
-- ============================================================

INSERT INTO tickets (
    title,
    description,
    priority,
    status,
    created_by,
    assigned_to,
    asset_id,
    created_at,
    updated_at
)
WITH
user_pool AS (
    SELECT
        user_id,
        ROW_NUMBER() OVER (ORDER BY user_id) AS rn
    FROM users
),
agent_pool AS (
    SELECT
        user_id,
        ROW_NUMBER() OVER (ORDER BY user_id) AS rn
    FROM users
    WHERE role = 'AGENT'
),
asset_pool AS (
    SELECT
        asset_id,
        ROW_NUMBER() OVER (ORDER BY asset_id) AS rn
    FROM assets
),
user_count AS (
    SELECT COUNT(*) AS total
    FROM user_pool
),
agent_count AS (
    SELECT COUNT(*) AS total
    FROM agent_pool
),
asset_count AS (
    SELECT COUNT(*) AS total
    FROM asset_pool
),
numbers AS (
    SELECT LEVEL AS n
    FROM dual
    CONNECT BY LEVEL <= 10000
)
SELECT
    'Performance Test Ticket #' || n.n,

    'Automatically generated ticket for SQL performance testing.',

    CASE MOD(n.n, 4)
        WHEN 0 THEN 'LOW'
        WHEN 1 THEN 'MEDIUM'
        WHEN 2 THEN 'HIGH'
        ELSE 'CRITICAL'
    END,

    CASE MOD(n.n, 4)
        WHEN 0 THEN 'OPEN'
        WHEN 1 THEN 'IN_PROGRESS'
        WHEN 2 THEN 'RESOLVED'
        ELSE 'CLOSED'
    END,

    u.user_id,

    CASE
        WHEN MOD(n.n, 5) = 0 THEN NULL
        ELSE a.user_id
    END,

    CASE
        WHEN MOD(n.n, 7) = 0 THEN NULL
        ELSE ast.asset_id
    END,

    SYSTIMESTAMP
        - NUMTODSINTERVAL(MOD(n.n, 3650), 'DAY'),

    SYSTIMESTAMP
        - NUMTODSINTERVAL(MOD(n.n, 3650), 'DAY')

FROM numbers n

CROSS JOIN user_count uc
CROSS JOIN agent_count ac
CROSS JOIN asset_count xc

JOIN user_pool u
    ON u.rn = MOD(n.n - 1, uc.total) + 1

JOIN agent_pool a
    ON a.rn = MOD(n.n - 1, ac.total) + 1

JOIN asset_pool ast
    ON ast.rn = MOD(n.n - 1, xc.total) + 1;

COMMIT;

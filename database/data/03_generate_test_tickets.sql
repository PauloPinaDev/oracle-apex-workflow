-- ============================================================
-- WorkFlow - Generate Test Tickets
-- ============================================================

DECLARE
    l_user_count NUMBER;
    l_asset_count NUMBER;
BEGIN

    SELECT COUNT(*)
      INTO l_user_count
      FROM users;

    SELECT COUNT(*)
      INTO l_asset_count
      FROM assets;

    IF l_user_count = 0 THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'No users available.'
        );
    END IF;

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
    SELECT
        'Test Ticket #' || LEVEL,

        'Automatically generated test ticket for performance testing.',

        CASE MOD(LEVEL, 4)
            WHEN 0 THEN 'LOW'
            WHEN 1 THEN 'MEDIUM'
            WHEN 2 THEN 'HIGH'
            ELSE 'CRITICAL'
        END,

        CASE MOD(LEVEL, 4)
            WHEN 0 THEN 'OPEN'
            WHEN 1 THEN 'IN_PROGRESS'
            WHEN 2 THEN 'RESOLVED'
            ELSE 'CLOSED'
        END,

        MOD(LEVEL - 1, l_user_count) + 1,

        CASE
            WHEN MOD(LEVEL, 3) = 0 THEN NULL
            ELSE MOD(LEVEL, l_user_count) + 1
        END,

        CASE
            WHEN MOD(LEVEL, 5) = 0 THEN NULL
            ELSE MOD(LEVEL - 1, l_asset_count) + 1
        END,

        SYSTIMESTAMP - NUMTODSINTERVAL(
            MOD(LEVEL, 365),
            'DAY'
        ),

        SYSTIMESTAMP - NUMTODSINTERVAL(
            MOD(LEVEL, 365),
            'DAY'
        )

    FROM dual
    CONNECT BY LEVEL <= 10000;

    COMMIT;

END;
/

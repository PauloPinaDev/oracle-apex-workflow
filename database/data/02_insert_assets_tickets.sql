-- ============================================================
-- WorkFlow - Sample Assets, Tickets, Comments and History
-- ============================================================

DECLARE
    -- Users
    l_admin_user       users.user_id%TYPE;
    l_agent_john       users.user_id%TYPE;
    l_agent_sarah      users.user_id%TYPE;
    l_paulo_user       users.user_id%TYPE;

    -- Assets
    l_laptop_paulo     assets.asset_id%TYPE;
    l_laptop_john      assets.asset_id%TYPE;
    l_monitor_01       assets.asset_id%TYPE;

    -- Tickets
    l_ticket_1         tickets.ticket_id%TYPE;
    l_ticket_2         tickets.ticket_id%TYPE;
    l_ticket_3         tickets.ticket_id%TYPE;
    l_ticket_4         tickets.ticket_id%TYPE;
    l_ticket_5         tickets.ticket_id%TYPE;

BEGIN

    -- ========================================================
    -- Get users
    -- ========================================================

    SELECT user_id
      INTO l_admin_user
      FROM users
     WHERE username = 'admin';

    SELECT user_id
      INTO l_agent_john
      FROM users
     WHERE username = 'john.smith';

    SELECT user_id
      INTO l_agent_sarah
      FROM users
     WHERE username = 'sarah.jones';

    SELECT user_id
      INTO l_paulo_user
      FROM users
     WHERE username = 'paulo.pina';


    -- ========================================================
    -- Assets
    -- ========================================================

    INSERT INTO assets (
        asset_tag,
        asset_type,
        description,
        status,
        assigned_user_id
    )
    VALUES (
        'LT-001',
        'LAPTOP',
        'Dell Latitude 5540',
        'ASSIGNED',
        l_paulo_user
    )
    RETURNING asset_id INTO l_laptop_paulo;


    INSERT INTO assets (
        asset_tag,
        asset_type,
        description,
        status,
        assigned_user_id
    )
    VALUES (
        'LT-002',
        'LAPTOP',
        'Lenovo ThinkPad T14',
        'ASSIGNED',
        l_agent_john
    )
    RETURNING asset_id INTO l_laptop_john;


    INSERT INTO assets (
        asset_tag,
        asset_type,
        description,
        status,
        assigned_user_id
    )
    VALUES (
        'MON-001',
        'MONITOR',
        'Dell 27 inch monitor',
        'AVAILABLE',
        NULL
    )
    RETURNING asset_id INTO l_monitor_01;


    INSERT INTO assets (
        asset_tag,
        asset_type,
        description,
        status,
        assigned_user_id
    )
    VALUES (
        'SRV-001',
        'SERVER',
        'Development application server',
        'MAINTENANCE',
        NULL
    );


    -- ========================================================
    -- Ticket 1
    -- ========================================================

    INSERT INTO tickets (
        title,
        description,
        priority,
        status,
        created_by,
        assigned_to,
        asset_id
    )
    VALUES (
        'VPN connection problem',
        'Unable to connect to the corporate VPN from home.',
        'HIGH',
        'IN_PROGRESS',
        l_paulo_user,
        l_agent_john,
        l_laptop_paulo
    )
    RETURNING ticket_id INTO l_ticket_1;


    -- ========================================================
    -- Ticket 2
    -- ========================================================

    INSERT INTO tickets (
        title,
        description,
        priority,
        status,
        created_by,
        assigned_to,
        asset_id
    )
    VALUES (
        'Laptop does not boot',
        'Laptop shows a black screen after pressing the power button.',
        'CRITICAL',
        'OPEN',
        l_agent_john,
        l_agent_sarah,
        l_laptop_john
    )
    RETURNING ticket_id INTO l_ticket_2;


    -- ========================================================
    -- Ticket 3
    -- ========================================================

    INSERT INTO tickets (
        title,
        description,
        priority,
        status,
        created_by,
        assigned_to,
        asset_id
    )
    VALUES (
        'Request for additional monitor',
        'User requires an additional monitor for development work.',
        'LOW',
        'RESOLVED',
        l_paulo_user,
        l_agent_john,
        l_monitor_01
    )
    RETURNING ticket_id INTO l_ticket_3;


    -- ========================================================
    -- Ticket 4
    -- ========================================================

    INSERT INTO tickets (
        title,
        description,
        priority,
        status,
        created_by,
        assigned_to,
        asset_id
    )
    VALUES (
        'Development server unavailable',
        'Development application is currently unavailable.',
        'CRITICAL',
        'IN_PROGRESS',
        l_agent_sarah,
        l_agent_sarah,
        NULL
    )
    RETURNING ticket_id INTO l_ticket_4;


    -- ========================================================
    -- Ticket 5
    -- ========================================================

    INSERT INTO tickets (
        title,
        description,
        priority,
        status,
        created_by,
        assigned_to,
        asset_id
    )
    VALUES (
        'Password reset request',
        'User forgot the password and requires an account reset.',
        'MEDIUM',
        'CLOSED',
        l_paulo_user,
        l_agent_john,
        NULL
    )
    RETURNING ticket_id INTO l_ticket_5;


    -- ========================================================
    -- Ticket comments
    -- ========================================================

    INSERT INTO ticket_comments (
        ticket_id,
        user_id,
        comment_text
    )
    VALUES (
        l_ticket_1,
        l_paulo_user,
        'VPN connection fails after authentication.'
    );


    INSERT INTO ticket_comments (
        ticket_id,
        user_id,
        comment_text
    )
    VALUES (
        l_ticket_1,
        l_agent_john,
        'I am investigating the VPN configuration and authentication logs.'
    );


    INSERT INTO ticket_comments (
        ticket_id,
        user_id,
        comment_text
    )
    VALUES (
        l_ticket_2,
        l_agent_sarah,
        'I will inspect the laptop hardware and boot configuration.'
    );


    INSERT INTO ticket_comments (
        ticket_id,
        user_id,
        comment_text
    )
    VALUES (
        l_ticket_3,
        l_agent_john,
        'Monitor assigned and tested successfully.'
    );


    INSERT INTO ticket_comments (
        ticket_id,
        user_id,
        comment_text
    )
    VALUES (
        l_ticket_4,
        l_agent_sarah,
        'Infrastructure team is currently investigating the server.'
    );


    INSERT INTO ticket_comments (
        ticket_id,
        user_id,
        comment_text
    )
    VALUES (
        l_ticket_5,
        l_agent_john,
        'Password was reset successfully. User confirmed access.'
    );


    -- ========================================================
    -- Ticket history
    -- ========================================================

    INSERT INTO ticket_history (
        ticket_id,
        changed_by,
        old_status,
        new_status
    )
    VALUES (
        l_ticket_1,
        l_agent_john,
        'OPEN',
        'IN_PROGRESS'
    );


    INSERT INTO ticket_history (
        ticket_id,
        changed_by,
        old_status,
        new_status
    )
    VALUES (
        l_ticket_3,
        l_agent_john,
        'OPEN',
        'IN_PROGRESS'
    );


    INSERT INTO ticket_history (
        ticket_id,
        changed_by,
        old_status,
        new_status
    )
    VALUES (
        l_ticket_3,
        l_agent_john,
        'IN_PROGRESS',
        'RESOLVED'
    );


    INSERT INTO ticket_history (
        ticket_id,
        changed_by,
        old_status,
        new_status
    )
    VALUES (
        l_ticket_4,
        l_agent_sarah,
        'OPEN',
        'IN_PROGRESS'
    );


    INSERT INTO ticket_history (
        ticket_id,
        changed_by,
        old_status,
        new_status
    )
    VALUES (
        l_ticket_5,
        l_agent_john,
        'OPEN',
        'IN_PROGRESS'
    );


    INSERT INTO ticket_history (
        ticket_id,
        changed_by,
        old_status,
        new_status
    )
    VALUES (
        l_ticket_5,
        l_agent_john,
        'IN_PROGRESS',
        'RESOLVED'
    );


    INSERT INTO ticket_history (
        ticket_id,
        changed_by,
        old_status,
        new_status
    )
    VALUES (
        l_ticket_5,
        l_agent_john,
        'RESOLVED',
        'CLOSED'
    );


    COMMIT;

END;
/

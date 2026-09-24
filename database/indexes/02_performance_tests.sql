SELECT
    t.ticket_id,
    t.title,
    t.priority,
    t.status,
    t.created_at
FROM tickets t
WHERE t.status = 'OPEN'
ORDER BY t.created_at DESC;

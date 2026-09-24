-- ============================================================
-- WorkFlow - Database Indexes
-- ============================================================

-- USERS
CREATE INDEX idx_users_department
    ON users (department_id);

-- ASSETS
CREATE INDEX idx_assets_assigned_user
    ON assets (assigned_user_id);

-- TICKETS
CREATE INDEX idx_tickets_created_by
    ON tickets (created_by);

CREATE INDEX idx_tickets_assigned_to
    ON tickets (assigned_to);

CREATE INDEX idx_tickets_asset
    ON tickets (asset_id);

CREATE INDEX idx_tickets_status
    ON tickets (status);

CREATE INDEX idx_tickets_priority
    ON tickets (priority);

CREATE INDEX idx_tickets_created_at
    ON tickets (created_at);

-- TICKET COMMENTS
CREATE INDEX idx_comments_ticket
    ON ticket_comments (ticket_id);

CREATE INDEX idx_comments_user
    ON ticket_comments (user_id);

-- TICKET HISTORY
CREATE INDEX idx_history_ticket
    ON ticket_history (ticket_id);

CREATE INDEX idx_history_changed_by
    ON ticket_history (changed_by);

CREATE INDEX idx_history_changed_at
    ON ticket_history (changed_at);

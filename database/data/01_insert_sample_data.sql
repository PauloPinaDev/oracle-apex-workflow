-- ============================================================
-- WorkFlow - Sample Data
-- ============================================================

INSERT INTO departments (name, description)
VALUES ('IT Support', 'First-line and second-line IT support');

INSERT INTO departments (name, description)
VALUES ('Infrastructure', 'Servers, networks and infrastructure');

INSERT INTO departments (name, description)
VALUES ('Security', 'Information security and access management');

COMMIT;

DECLARE
    l_it_department         departments.department_id%TYPE;
    l_infrastructure_department departments.department_id%TYPE;
    l_security_department   departments.department_id%TYPE;
BEGIN
    SELECT department_id
      INTO l_it_department
      FROM departments
     WHERE name = 'IT Support';

    SELECT department_id
      INTO l_infrastructure_department
      FROM departments
     WHERE name = 'Infrastructure';

    SELECT department_id
      INTO l_security_department
      FROM departments
     WHERE name = 'Security';

    INSERT INTO users (
        department_id, username, full_name, email, role
    ) VALUES (
        l_it_department,
        'admin',
        'System Administrator',
        'admin@workflow.local',
        'ADMIN'
    );

    INSERT INTO users (
        department_id, username, full_name, email, role
    ) VALUES (
        l_it_department,
        'john.smith',
        'John Smith',
        'john.smith@workflow.local',
        'AGENT'
    );

    INSERT INTO users (
        department_id, username, full_name, email, role
    ) VALUES (
        l_infrastructure_department,
        'sarah.jones',
        'Sarah Jones',
        'sarah.jones@workflow.local',
        'AGENT'
    );

    INSERT INTO users (
        department_id, username, full_name, email, role
    ) VALUES (
        l_security_department,
        'paulo.pina',
        'Paulo Pina',
        'paulo.pina@workflow.local',
        'USER'
    );

    COMMIT;
END;
/

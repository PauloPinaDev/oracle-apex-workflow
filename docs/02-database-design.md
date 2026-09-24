# Database Design

## Overview
The WorkFlow application uses a relational Oracle Database
to manage departments, users, assets, tickets and ticket history.

## Entity Relationship
DEPARTMENTS
    |
    └── USERS
          |
          ├── TICKETS
          |     |
          |     ├── TICKET_COMMENTS
          |     └── TICKET_HISTORY
          |
          └── ASSETS

## Tables

  ### DEPARTMENTS
  Stores the organisational departments.
  
  ### USERS
  Stores application users and their roles.
  Roles:
  
  - ADMIN
  - AGENT
  - USER
  
  ### ASSETS
  Stores IT assets assigned to users.
  
  ### TICKETS
  Stores service requests and incidents.
  
  ### TICKET_COMMENTS
  Stores comments associated with tickets.
  
  ### TICKET_HISTORY
  Stores changes to ticket status.
  
## Design Decisions
  
  ### Identity Columns
  Identity columns are used for primary key generation.
  
  ### Foreign Keys
  Foreign keys enforce referential integrity between
  related entities.
  
  ### Check Constraints
  Check constraints are used to enforce valid values
  for statuses, roles and priorities.
  
  ### Unique Constraints
  Usernames, emails, department names and asset tags
  must be unique.

## Future Improvements
- Add indexes based on query performance analysis
- Add auditing
- Add PL/SQL business logic
- Add automated tests

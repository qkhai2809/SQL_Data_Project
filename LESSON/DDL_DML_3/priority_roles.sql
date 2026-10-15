--.read LESSON/DDL_DML_3/priority_roles.sql
CREATE OR REPLACE TABLE staging.priority_roles(
    role_id INTEGER PRIMARY KEY,
    role_name VARCHAR,
    priority_lv INTEGER
);

INSERT INTO staging.priority_roles(role_id, role_name, priority_lv)
VALUES
  (1, 'Data Engineer', 2),
  (2, 'Senior Data Engineer', 1),
  (3, 'Software Engineer', 3),
  (4, 'Data Scientist', 3);

  SELECT *
  FROM staging.priority_roles;

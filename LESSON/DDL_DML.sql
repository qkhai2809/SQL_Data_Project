--.read LESSON/DDL_DML.sql

CREATE DATABASE IF NOT EXISTS job_mart;
SHOW DATABASES;

--DROP DATABASE IF EXISTS job_mart;

SELECT *
FROM information_schema.schemata;

USE job_mart;
CREATE SCHEMA IF NOT EXISTS staging;

--DROP SCHEMA staging;
CREATE TABLE IF NOT EXISTS staging.preferred_roles (
    role_id INTEGER PRIMARY KEY,
    role_name VARCHAR
);

DROP TABLE IF EXISTS main.preferred_roles;


SELECT * FROM information_schema.tables
WHERE table_catalog = 'job_mart';


INSERT INTO staging.preferred_roles(role_id, role_name)
VALUES
     (1, 'Data Engineer'),
     (2, 'Data Analyst'),
     (3, 'Data Scientist'),
     (4, 'Analytic Engineer'),
     (5, 'Senior Data Engineer');



ALTER TABLE staging.preferred_roles
ADD COLUMN preferred BOOLEAN;

UPDATE staging.preferred_roles
SET preferred = FALSE
WHERE role_id = 3 OR role_id = 4 OR role_id = 2;

ALTER TABLE staging.preferred_roles
RENAME TO priority_role;
SELECT *
FROM staging.priority_role;

ALTER TABLE staging.priority_role
RENAME COLUMN preferred TO priority_lv;

ALTER TABLE staging.priority_role
ALTER COLUMN priority_lv TYPE INTEGER;

UPDATE staging.priority_role
SET priority_lv = 2
WHERE role_id = 3 OR role_id = 4 OR role_id = 2;

UPDATE staging.priority_role
SET priority_lv = 1
WHERE role_id = 1 OR role_id = 5;



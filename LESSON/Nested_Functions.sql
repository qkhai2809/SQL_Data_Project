SELECT ['PHAM', 'QUANG', 'KHAI'] as name_array;

--ARRAY
WITH skills AS (
    SELECT 'Python' AS skill
    UNION ALL
    SELECT 'Sql'
    UNION ALL
    SELECT 'R'
), skills_array AS(
    SELECT LIST(skill ORDER BY skill) AS skill_list
    FROM skills
)

SELECT skill_list[1],
       skill_list[2],
       skill_list[3]
FROM skills_array;

-- ┌───────────────┬───────────────┬───────────────┐
-- │ skill_list[1] │ skill_list[2] │ skill_list[3] │
-- │    varchar    │    varchar    │    varchar    │
-- ├───────────────┼───────────────┼───────────────┤
-- │ Python        │ R             │ Sql           │
-- └───────────────┴───────────────┴───────────────┘

--STRUCT
WITH skill_struct AS (
SELECT STRUCT_PACK( 
    skill:= 'python', 
    type:= 'programming') AS s
)

SELECT s.skill,
       s.type
FROM skill_struct;
-- ┌─────────┬─────────────┐
-- │  skill  │    type     │
-- │ varchar │   varchar   │
-- ├─────────┼─────────────┤
-- │ python  │ programming │
-- └─────────┴─────────────┘
 
WITH skill_table AS (
SELECT 'Python' AS skills, 'programming' AS types
    UNION ALL
    SELECT 'Sql', 'query_language'
    UNION ALL
    SELECT 'R', 'programming'
)
SELECT STRUCT_PACK(
    skill:= skills, 
    type:= types
)
FROM skill_table;
-- ┌─────────────────────────────────────────────────┐
-- │ struct_pack(skill := skills, "type" := "types") │
-- │      struct(skill varchar, "type" varchar)      │
-- ├─────────────────────────────────────────────────┤
-- │ {'skill': Python, 'type': programming}          │
-- │ {'skill': Sql, 'type': query_language}          │
-- │ {'skill': R, 'type': programming}               │
-- └─────────────────────────────────────────────────┘

--ARRAY OF STRUCT

SELECT  [
    { skill: 'python', type: 'programming'},
    { skill: 'sql', type: 'quey_language'}
] AS skills_array_of_structs;

 
WITH skill_table AS (
SELECT 'Python' AS skills, 'programming' AS types
    UNION ALL
    SELECT 'Sql', 'query_language'
    UNION ALL
    SELECT 'R', 'programming'
),

 skill_arr_struct AS (
SELECT ARRAY_AGG(STRUCT_PACK(
    skill:= skills, 
    type:= types
) ORDER BY skills
) AS skill_arr_strct
FROM skill_table)

SELECT *
FROM skill_arr_struct;

-- ┌────────────────────────────┬─────────────────────────────┬─────────────────────────────────────┐
-- │ (skill_arr_strct[1]).skill │ (skill_arr_strct[2])."type" │         skill_arr_strct[3]          │
-- │          varchar           │           varchar           │ struct(skill varchar, "type" varcha │
-- │                            │                             │                 r)                  │
-- ├────────────────────────────┼─────────────────────────────┼─────────────────────────────────────┤
-- │ Python                     │ programming                 │ {                                   │
-- │                            │                             │   'skill': Sql,                     │
-- │                            │                             │   'type': query_language            │
-- │                            │                             │ }                                   │
-- └────────────────────────────┴─────────────────────────────┴─────────────────────────────────────┘

--MAP
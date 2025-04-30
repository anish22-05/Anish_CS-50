<-- Find a student’s historical course enrollments, based on their ID.
    -- SELECT "courses"."title", "courses"."semester"
    -- FROM "enrollments"
    -- JOIN "courses" ON "enrollments"."course_id" = "courses"."id"
    -- JOIN "students" ON "enrollments"."student_id" = "students"."id"
    -- WHERE "students"."id" = 3;
--Without index query plan of above query is, we have 2 searches and 1 scan on enrollments table, so create index on enrollments.
    --QUERY PLAN
    |--SEARCH students USING INTEGER PRIMARY KEY (rowid=?)
    |--SCAN enrollments
    --SEARCH courses USING INTEGER PRIMARY KEY (rowid=?)
--Solution:
    create index idx_enrollments_students_course on enrollments(student_id, course_id);

    --QUERY PLAN
    |--SEARCH students USING INTEGER PRIMARY KEY (rowid=?)
    |--SEARCH enrollments USING COVERING INDEX idx_enrollments_students_course (student_id=?)
    --SEARCH courses USING INTEGER PRIMARY KEY (rowid=?)
    --since we are using both student_id & course_id in above query from enrollments table so we created combine index which results
    -- in fast searching from enrollement table.

--------------------------------------------------------------------------------------------------------------------------------------------
<-- Find all students who enrolled in Computer Science 50 in Fall 2023:
    -- SELECT "id", "name"
    -- FROM "students"
    -- WHERE "id" IN (
    --     SELECT "student_id"
    --     FROM "enrollments"
    --     WHERE "course_id" = (
    --         SELECT "id"
    --         FROM "courses"
    --         WHERE "courses"."department" = 'Computer Science'
    --         AND "courses"."number" = 50
    --         AND "courses"."semester" = 'Fall 2023'
    --     )
    -- );

--QUERY PLAN:
    |--SEARCH students USING INTEGER PRIMARY KEY (rowid=?)
    --LIST SUBQUERY 2
    |--SEARCH enrollments USING INDEX idx_enrollments_course (course_id=?)
    --SCALAR SUBQUERY 1
        --SCAN courses
-- Here we need to create index in courses as it is scanning whole courses table which is taking time. by creating index we turn.
-- this scan into search.
--Solution:
    CREATE INDEX idx_courses_department ON courses(department)
    CREATE INDEX idx_courses_dept_num_sem ON courses(department,number,semester)
QUERY PLAN
|--SEARCH students USING INTEGER PRIMARY KEY (rowid=?)
--LIST SUBQUERY 2
   |--SEARCH enrollments USING INDEX idx_enrollments_course (course_id=?)
   --SCALAR SUBQUERY 1
      --SEARCH courses USING COVERING INDEX idx_courses_dept_num_sem (department=? AND number=? AND semester=?)
--------------------------------------------------------------------------------------------------------------------------------
-- Sort courses by most- to least-enrolled in Fall 2023:
    -- SELECT "courses"."id", "courses"."department", "courses"."number", "courses"."title", COUNT(*) AS "enrollment"
    -- FROM "courses"
    -- JOIN "enrollments" ON "enrollments"."course_id" = "courses"."id"
    -- WHERE "courses"."semester" = 'Fall 2023'
    -- GROUP BY "courses"."id"
    -- ORDER BY "enrollment" DESC;
-- This is query plan of above query where it scans courses table so we can add index to courses table to 
-- make it from "scan" to "search"
-- QUERY PLAN
--     |--SCAN courses
--     |--SEARCH enrollments USING COVERING INDEX idx_enrollments_course (course_id=?)
--     --USE TEMP B-TREE FOR ORDER BY
--Here we require to add index to courses table here it is using semester attribute.
--Solution:
    CREATE INDEX idx_courses_semester ON courses(semester);
-- QUERY PLAN
    |--SEARCH courses USING INDEX idx_courses_semester (semester=?)
    |--SEARCH enrollments USING COVERING INDEX idx_enrollments_course (course_id=?)
    --USE TEMP B-TREE FOR ORDER BY

----------------------------------------------------------------------------------------------------------------------
<-- Find all computer science courses taught in Spring 2024:
    -- SELECT "courses"."id", "courses"."department", "courses"."number", "courses"."title"
    -- FROM "courses"
    -- WHERE "courses"."department" = 'Computer Science'
    -- AND "courses"."semester" = 'Spring 2024';
-- QUERY PLAN
-- --SEARCH courses USING INDEX idx_courses_semester (semester=?)
-- Here we need not do anything as it is already faast and using alredy created index.
CREATE INDEX idx_courses_semester ON courses(semester);--"this index is already created so this query works smoothly using index."
----------------------------------------------------------------------------------------------------------------------------------

<-- Find the requirement satisfied by “Advanced Databases” in Fall 2023:
    -- SELECT "requirements"."name"
    -- FROM "requirements"
    -- WHERE "requirements"."id" = (
    --     SELECT "requirement_id"
    --     FROM "satisfies"
    --     WHERE "course_id" = (
    --         SELECT "id"
    --         FROM "courses"
    --         WHERE "title" = 'Advanced Databases'
    --         AND "semester" = 'Fall 2023'
    --     )
    -- );
-- QUERY PLAN
    --SEARCH requirements USING INTEGER PRIMARY KEY (rowid=?)
    --SCALAR SUBQUERY 2
        --SCAN satisfies
        --SCALAR SUBQUERY 1
        --SEARCH courses USING INDEX idx_courses_semester (semester=?)
-- Here we require to create index in satisfies table to make it from scan to search.
--Solution:
    CREATE INDEX idx_satisfies_req ON satisfies(requirment_id);
    CREATE INDEX idx_satisfies_course_id ON satisfies(course_id);
-- QUERY PLAN
    --SEARCH requirements USING INTEGER PRIMARY KEY (rowid=?)
    --SCALAR SUBQUERY 2
    --SEARCH satisfies USING INDEX idx_satisfies_course_id (course_id=?)
    --SCALAR SUBQUERY 1
        --SEARCH courses USING INDEX idx_courses_semester (semester=?)
----------------------------------------------------------------------------------------------------------------------------------

-- Find how many courses in each requirement a student has satisfied:

    -- SELECT "requirements"."name", COUNT(*) AS "courses"
    -- FROM "requirements"
    -- JOIN "satisfies" ON "requirements"."id" = "satisfies"."requirement_id"
    -- WHERE "satisfies"."course_id" IN (
    --     SELECT "course_id"
    --     FROM "enrollments"
    --     WHERE "enrollments"."student_id" = 8
    -- )
    -- GROUP BY "requirements"."name";
-- QUERY PLAN
    --SEARCH satisfies USING INDEX idx_satisfies_course_id (course_id=?)
        --LIST SUBQUERY 1
        | --SEARCH enrollments USING COVERING INDEX idx_enrollments_students_course (student_id=?)
        --SEARCH requirements USING INTEGER PRIMARY KEY (rowid=?)
        --USE TEMP B-TREE FOR GROUP BY

---Solution: 
    --As we can observe in above query plan this query is using indexes for its search so there is no need to create new indexes.

---------------------------------------------------------------------------------------------------------------------------------

<--Search for a course by title and semester:
    -- SELECT "department", "number", "title"
    -- FROM "courses"
    -- WHERE "title" LIKE "History%"
    -- AND "semester" = 'Fall 2023';
-- QUERY PLAN:
    --SEARCH courses USING INDEX idx_courses_semester (semester=?)
--Solution: 
    -- Here as you can see in above query plan the query is already using index while searching so we dont need to add new indexes.
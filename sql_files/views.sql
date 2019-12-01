CREATE OR REPLACE VIEW facutly_information_view AS
select FACULTY.id,
       FACULTY.name,
       FACULTY.email,
       FACULTY.phone,
       DEPARTMENT.DEPT_NAME,
       UNIVERSITY.NAME as univerity_name
from FACULTY,
     DEPARTMENT,
     UNIVERSITY
where DEPARTMENT.id = FACULTY.DEPT_ID
  and DEPARTMENT.UNIVERSITY_ID = UNIVERSITY.id
ORDER BY FACULTY.ID;


-- SELECT STUDENT.ID,
--        STUDENT.NAME,
--        STUDENT.PHONE,
--        STUDENT.ADMITTED_YEAR,
--        DEPARTMENT.DEPT_NAME,
--        UNIVERSITY.NAME as UNIVERSITY_NAME
-- FROM STUDENT,
--      DEPARTMENT,
--      UNIVERSITY
-- WHERE STUDENT.DEPT_ID = DEPARTMENT.ID;

CREATE OR REPLACE VIEW student_information_view
AS
SELECT STUDENT.ID,
       STUDENT.NAME,
       STUDENT.PHONE,
       STUDENT.ADMITTED_YEAR,
       DEPARTMENT.DEPT_NAME,
       UNIVERSITY.NAME as UNIVERSITY_NAME
FROM STUDENT,
     DEPARTMENT,
     UNIVERSITY
WHERE STUDENT.DEPT_ID = DEPARTMENT.ID
  and DEPARTMENT.UNIVERSITY_ID = UNIVERSITY.ID
ORDER BY STUDENT.ID;


-- CREATE OR REPLACE VIEW project_information_view
-- AS
CREATE OR REPLACE VIEW project_information_view AS
SELECT PROJECT.ID,
       PROJECT.NAME,
       PROJECT.DESCRIPTION,
       FACULTY.NAME AS FACULTY_NAME
FROM PROJECT,
     FACULTY,
     FACULTY_PROJECT
WHERE PROJECT.ID = FACULTY_PROJECT.PROJECT_ID
  AND FACULTY.ID = FACULTY_PROJECT.FACULTY_ID
ORDER BY ID;


CREATE OR REPLACE VIEW thesis_information_view AS
SELECT THESIS.ID, THESIS.NAME, THESIS.DESCRIPTION, FACULTY.NAME AS FACULTY_NAME
FROM THESIS,
     FACULTY,
     FACULTY_THESIS
WHERE THESIS.ID = FACULTY_THESIS.THESIS_ID
  AND FACULTY.ID = FACULTY_THESIS.FACULTY_ID
order by THESIS.ID;

select *
from TECHNOLOGY;
select *
from TECHNOLOGY_PROJECT;
select *
from TECHNOLOGY_THESIS;

SELECT
       TECHNOLOGY.ID, TECHNOLOGY.NAME, TECHNOLOGY.DESCRIPTION, COUNT(TECHNOLOGY_THESIS.TECHNOLOGY_ID) AS THESIS_COUNT
FROM TECHNOLOGY,TECHNOLOGY_THESIS
WHERE TECHNOLOGY.ID = TECHNOLOGY_THESIS.TECHNOLOGY_ID
GROUP BY TECHNOLOGY_THESIS.TECHNOLOGY_ID;

select count(*) from technology_thesis group by technology_id;

select count(technology_thesis.*), count(project_thesis.*) from technology_thesis, project_thesis
    group by technology_thesis.technology_id and project_thesis.technology_id;

select count(technology_thesis.technology_id), thesis.name from technology_thesis,thesis group by technology_id;



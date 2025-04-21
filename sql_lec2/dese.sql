<-- Your colleague is preparing a map of all public schools in Massachusetts. 
-- In 1.sql, write a SQL query to find the names and cities of all public schools in 
-- Massachusetts.
SELECT name, city FROM schools WHERE state = "MA" AND type = "Public School";
<-- Your team is working on archiving old data. write a SQL query to find the names of districts that are no longer operational.
SELECT name FROM districts WHERE name = "%non-op%";
<-- write a SQL query to find the average per-pupil expenditure. Name the column “Average District Per-Pupil Expenditure”.
SELECT AVG(per_pupil_expenditure) AS "Average District Per-Pupil Expenditure" FROM expenditure;
<--write a SQL query to find the 10 cities with the most public schools. 
-- Your query should return the names of the cities and the number of public schools within them, 
-- ordered from greatest number of public schools to least. If two cities have the same number of public schools, 
-- order them alphabetically.
SELECT city, COUNT(name) FROM schools WHERE type = "Public School" GROUP BY city ORDER BY count(name)DESC;
<--DESE would like you to determine in what cities additional public schools might be needed. 
-- write a SQL query to find cities with 3 or fewer public schools. 
-- Your query should return the names of the cities and the number of public schools within them, 
-- ordered from greatest number of public schools to least. If two cities have the same number of public schools, 
-- order them alphabetically.

SELECT city, COUNT(name) FROM schools WHERE type = "Public School" GROUP BY city HAVING COUNT(name) < 3 ORDER BY COUNT(name) DESC, city;
<--DESE wants to assess which schools achieved a 100% graduation rate. 
-- write a SQL query to find the names of schools (public or charter!) that reported a 100% graduation rate.

SELECT name FROM schools WHERE id IN (SELECT school_id FROM graduation_rates WHERE graduated = 100);

<--DESE is preparing a report on schools in the Cambridge school district. In 7.sql, 
-- write a SQL query to find the names of schools (public or charter!) in the Cambridge school district. 
-- Keep in mind that Cambridge, the city,contains a few school districts, but DESE is interested in the district whose name is 
-- “Cambridge.”
SELECT name FROM schools WHERE district_id IN (SELECT name FROM districts WHERE name = "Cambrdge")
<-- A parent wants to send their child to a district with many other students. In 8.sql, 
-- write a SQL query to display the names of all school districts and the number of pupils enrolled in each.
SELECT name , pupils FROM districts JOIN expenditures ON districts.id = expenditures.district_id;

<-- Another parent wants to send their child to a district with few other students. 
-- In 9.sql, write a SQL query to find the name (or names) of the school district(s) with the single least number of pupils. 
-- Report only the name(s).
SELECT name, pupils FROM districts JOIN expenditures ON districts.id = expenditures.district_id ORDER BY pupils;

<--In Massachusetts, school district expenditures are in part determined by local taxes on property (e.g., home) values. 
-- In 10.sql, write a SQL query to find the 10 public school districts with the highest per-pupil expenditures. 
-- Your query should return the names of the districts and the per-pupil expenditure for each.
SELECT name, pupils FROM districts JOIN expenditures ON districts.id = expenditures.district_id ORDER BY pupil;
<-- Is there a relationship between school expenditures and graduation rates? In 11.sql, 
-- write a SQL query to display the names of schools, their per-pupil expenditure, and their graduation rate. 
-- Sort the schools from greatest per-pupil expenditure to least. If two schools have the same per-pupil expenditure, 
-- sort by school name.

SELECT schools.name, per_pupil_expenditure, graduated FROM districts 
JOIN expenditures ON districts.id = expenditures.district_id
JOIN schools ON schools.district_id = districts.id JOIN graduation_rates ON schools.id = graduation_rates.school_id
ORDER BY per_pupil_expenditure DESC, schools.name;
<-- A parent asks you for advice on finding the best public school districts in Massachusetts. 
-- write a SQL query to find public school districts with above-average per-pupil expenditures and 
-- an above-average percentage of teachers rated “exemplary”. Your query should return the districts’ names, 
-- along with their per-pupil expenditures and percentage of teachers rated exemplary. Sort the results first by the percentage of 
-- teachers rated exemplary (high to low), then by the per-pupil expenditure (high to low).
SELECT districts.name, expenditures.per_pupil_expenditure, staff_evaluations.examplary FROM districts
JOIN expenditures ON expenditures.district_id = districts.id
JOIN staff_evaluations ON staff_evaluations.district_id = districts.id
WEHRE districts.type = "Public School District" AND per_pupil_expenditure >=(
    SELECT AVG(per_pupil_expenditure) FROM expenditures
) AND examplary >= (SELECT AVG(examplary)FROM staff_evaluations)
ORDER BY examplary DESC, per_pupil_expenditure DESC;
<-- WRITE QUERY OF YOUR CHOICE USING JOIN, SUBQUERY.
SELECT name FROM districts 
JOIN expenditures ON districts.id = expenditures.district_id
ORDER BY pupils LIMIT 1;

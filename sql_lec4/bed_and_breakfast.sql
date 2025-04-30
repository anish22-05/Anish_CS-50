<-- In one_bedrooms.sql, write a SQL statement to create a view named one_bedrooms. 
-- This view should contain all listings that have exactly one bedroom. Ensure the view contains the following columns:
--     id, which is the id of the listing from the listings table.
--     property_type, from the listings table.
--     host_name, from the listings table.
--     accommodates, from the listings table.

CREATE VIEW "one_bedrooms" AS 
    SELECT id,property_type,host_name,accommodates from listings where bedrooms = 1;

<-- In available.sql, write a SQL statement to create a view named available. 
-- This view should contain all dates that are available at all listings. Ensure the view contains the following columns:
--     id, which is the id of the listing from the listings table.
--     property_type, from the listings table.
--     host_name, from the listings table.
--     date, from the availabilities table, which is the date of the availability.
CREATE VIEW "available" AS
    SELECT listings.id, property_type, host_name,accommodates,availabilities.date FROM listings
    JOIN availabilities ON availabilities.listing_id = listings.id
    WHERE available = "TRUE";

<-- In frequently_reviewed.sql, write a SQL statement to create a view named frequently_reviewed. 
-- This view should contain the 100 most frequently reviewed listings, sorted from most- to least-frequently reviewed. 
-- Ensure the view contains the following columns:
--     id, which is the id of the listing from the listings table.
--     property_type, from the listings table.
--     host_name, from the listings table.
--     reviews, which is the number of reviews the listing has received.
-- If any two listings have the same number of reviews, sort by property_type (in alphabetical order), 
-- followed by host_name (in alphabetical order).
CREATE VIEW "frequently_reviewed" AS 
    SELECT listings.id,host_name,property_type FROM listings JOIN reviews ON reviews.listing_id = listings.id
    GROUP BY  listings.id
    ORDER BY COUNT(listing_id) DESC, property_type,host_name
    LIMIT 100;
<-- In june_vacancies.sql, write a SQL statement to create a view named june_vacancies. 
-- This view should contain all listings and the number of days in June of 2023 that they remained vacant. 
-- Ensure the view contains the following columns:
--     id, which is the id of the listing from the listings table.
--     property_type, from the listings table.
--     host_name, from the listings table.
--     days_vacant, which is the number of days in June of 2023, that the given listing was marked as available.
CREATE VIEW "june_vacancies" AS
SELECT listings.id, property_type,host_name, COUNT(availabilities.date) FROM listings
JOIN availabilities ON availabilities.listing_id = listings.id
WHERE date LIKE "2023-06-%" 
GROUP BY listings.id;

<-- You might notice that when running "SELECT * FROM "listings" LIMIT 5;"
-- the results look quite wonky! The description column contains descriptions with many line breaks, 
-- each of which are printed to your terminal.

    -- In no_descriptions.sql, write a SQL statement to create a view named 
    -- no_descriptions that includes all of the columns in the listings table except for description.
CREATE VIEW "no_descriptions" AS 
    SELECT id, property_type, host_name, accommodates, bedrooms FROM listings;
    
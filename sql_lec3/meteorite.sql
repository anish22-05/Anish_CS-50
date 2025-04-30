-- You’ve been given a CSV file of historical meteorite landings here on Earth, 
-- of which there are quite a few! Your job is to import the data into a SQLite database, 
-- cleaning it up along the way. After you’re done, 
-- the database will be used in analyses by some of your fellow engineers.
--Step 1--------------------------------------------------
-- We import csv using ".import --csv meteorites.csv meteorites_temp" here "meteorites_temp"
-- is the table that will store csv file data by using csv attributs and turn them into table attributes.
.import --csv meteorites.csv meteorites_temp
--Step 2---
    --Any empty values in meteorites.csv are represented by NULL in the meteorites table.
    --Keep in mind that the mass, year, lat, and long columns have empty values in the CSV.
    UPDATE meteorites_temp SET mass = NULL WHERE mass = 0;
    UPDATE meteorites_temp SET lat = NULL WHERE lat = 0;
    UPDATE meteorites_temp SET long = NULL WHERE long = 0;
    UPDATE meteorites_temp SET year = NULL WHERE year = 0;
    UPDATE meteorites_temp SET year = NULL WHERE year LIKE "";
    -- All columns with decimal values (e.g., 70.4777) should be rounded to the nearest hundredths place 
    -- (e.g., 70.4777 becomes 70.48).
    -- Keep in mind that the mass, lat, and long columns have decimal values.
    UPDATE meteorites_temp SET mass = ROUND(mass,2),lat = ROUND(lat,2),long = ROUND(long,2);
    -- All meteorites with the nametype “Relict” are not included in the meteorites table.
    CREATE TABLE meteorites(
        name TEXT,
        id INTEGER,
        class TEXT,
        mass REAL,
        discovery TEXT,
        year INTEGER,
        lat REAL,
        long REAL,
        PRIMARY KEY("id")
    );
    
    -- The meteorites are sorted by year, 
    -- oldest to newest, and then—if any two meteorites landed in the same year—by name, in alphabetical order.
        insert into meteorites("name", "class", "mass", "discovery", "year", "lat", "long")
        select name, class, mass, discovery, year, lat, long from meteorites_temp where nametype NOT LIKE "%relict%"
        order by year, name;
    


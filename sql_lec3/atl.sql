CREATE TABLE Passangers(
"id" INTEGER,
"first_name" TEXT,
"Last_name" TEXT,
"age" INTEGER,
PRIMARY KEY ("id")
);
CREATE TABLE Airlines(
"id" INTEGER,
"name" TEXT,
"concourse" TEXT,
PRIMARY KEY("id")
);
CREATE TABLE Flights(
"id" INTEGER,
"flight_number" INTEGER,
"airline_id" INTEGER,
"departing_airport_code" TEXT,
"arrival_airport_code" TEXT,
"departing_datetime" DATETIME,
"arrival_datetime" DATETIME,
PRIMARY KEY("id"),
FOREIGN KEY("airline_id") REFERENCES Airlines("id")
);
CREATE TABLE CheckIns(
"id" INTEGER,
"datetime" DATETIME,
"passanger_id" INTEGER,
"flight_id" INTEGER,
PRIMARY KEY("id"),
FOREIGN KEY("passanger_id") REFERENCES Passanger("id"),
FOREIGN KEY("flight_id") REFERENCES flights("id")
);


CREATE TABLE Users(
    "id" INTEGER 
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "username" TEXT UNIQUE NOT NULL,
    "password" CHAR(128),
    PRIMARY KEY("id")
);

CREATE TABLE Schools(
    "id" INT AUTO_INCREMENT,
    "name" TEXT NOT NULL,
    "school_type" CHECK("school_type" IN ("Primary","Secondary","Higher Education")),
    "location" TEXT NOT NULL,
    "founding_year" DATE,
    PRIMARY KEY("id")
);
CREATE TABLE Companies(
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "industry" CHECK("industry"("Technology","Education","Business")) NOT NULL,
    "location" TEXT NOT NULL,
    PRIMARY KEY("id")
);
CREATE TABLE Connections(
    "user1_id" INT,
    "user2_id" INT,
    PRIMARY KEY ("user1_id","user2_id"),
    FOREIGN KEY ("user1_id") REFERENCES Users("user_id"),
    FOREIGN KEY ("user2_id") REFERENCES Users("user_id")
);
CREATE TABLE UserSchools(
    "user_id" INT,
    "school_id" INT,
    "start_date" DATE,
    "end_date" DATE,
    "degree" VARCHAR(255),
    PRIMARY KEY (user_id, school_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (school_id) REFERENCES Schools(school_id)

);
CREATE TABLE UserCompanies(
    "user_id" INT,
    "company_id" INT,
    "start_date" DATE,
    "end_date" DATE,
    PRIMARY KEY (user_id, company_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (company_id) REFERENCES Companies(company_id)
);

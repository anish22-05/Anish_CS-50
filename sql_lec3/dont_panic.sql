--**************************************Schema information of table______
CREATE TABLE IF NOT EXISTS "users" (
    "id" INTEGER,
    "username" TEXT NOT NULL UNIQUE,
    "password" TEXT NOT NULL,
    PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "user_logs" (
    "id" INTEGER,
    "type" TEXT NOT NULL,
    "old_username" TEXT,
    "new_username" TEXT,
    "old_password" TEXT,
    "new_password" TEXT,
    PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "items" (
    "id" INTEGER,
    "name" TEXT NOT NULL UNIQUE,
    "price" NUMERIC NOT NULL,
    PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "orders" (
    "id" INTEGER,
    "user_id" INTEGER,
    "item_id" INTEGER,
    "quantity" INTEGER NOT NULL CHECK("quantity" > 0),
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("item_id") REFERENCES "items"("id")
);
CREATE TRIGGER "log_user_updates"
AFTER UPDATE OF "username", "password" ON "users"
FOR EACH ROW
BEGIN
    INSERT INTO "user_logs" ("type", "old_username", "new_username", "old_password", "new_password")
    VALUES ('update', OLD."username", NEW."username", OLD."password", NEW."password");
END;
CREATE TRIGGER "log_user_deletes"
AFTER DELETE ON "users"
FOR EACH ROW
BEGIN
    INSERT INTO "user_logs" ("type", "old_username", "new_username", "old_password", "new_password")
    VALUES ('delete', OLD."username", NULL, OLD."password", NULL);
END;
CREATE TRIGGER "log_user_inserts"
AFTER INSERT ON "users"
FOR EACH ROW
BEGIN
    INSERT INTO "user_logs" ("type", "old_username", "new_username", "old_password", "new_password")
    VALUES ('insert', NULL, NEW."username", NULL, NEW."password");
END;
--***********************************************************************************************************
UPDATE users SET password = "982c0381c279d139fd221fce974916e7"
WHERE username = "admin";
--Erase any activity that is recorded while changing the password.
DELETE FROM user_logs WHERE old_username = "admin";
--ADD FALSE DATA TO THROW OFF YOUR TRAIL USER emily33 passwords in admin password.
INSERT INTO user_logs (type,old_username,new_username,password)
SELECT 'updates','admin','admin',NULL,(
    SELECT password
    FROM users
    WHERE username = 'emily33'
);
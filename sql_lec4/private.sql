--------------------------------------------
CREATE TABLE IF NOT EXISTS "sentences" (
    "id" INTEGER,
    "sentence" TEXT NOT NULL,
    PRIMARY KEY("id")
);
--------------------------------------------------------
CREATE TABLE IF NOT EXISTS "triplets" (
"sentence_id" INTEGER,
"start_char" INTEGER,
"length" INTEGER);
-- USE insert query to insert triplet to triplets table.
----------------------------------------------------------------------
CREATE VIEW "message" AS
select substr(sentence, start_char, length) AS "phrase" from triplets
join sentences on sentences.id = triplets.sentence_id
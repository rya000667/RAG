-- String Array GIN index


Goal:
Run these queries
SELECT id, doc FROM docs03 WHERE '{wordshttpxkcdcom231}' <@ string_to_array(lower(doc), ' ');
EXPLAIN SELECT id, doc FROM docs03 WHERE '{wordshttpxkcdcom231}' <@ string_to_array(lower(doc), ' ');


CREATE TABLE docs03 (id SERIAL, doc TEXT, PRIMARY KEY(id));

-- split and convert each word to a vector
CREATE INDEX array03 ON docs03 USING gin(
    string_to_array(lower(doc), ' ')
);


INSERT INTO docs03 (doc) VALUES
('you write programs you will make up your own words that have meaning to'),
('you called variables You will have great latitude in'),
('choosing your names for your variables but you cannot use any of'),
('Pythons reserved words as a name for a variable'),
('When we train a dog we use special words like sit stay and'),
('they just look at you with a quizzical look on their face until you say'),
('a reserved word For example if you say I wish more people would walk'),
('to improve their overall health what most dogs likely hear is blah'),
('blah blah walk blah blah blah blah That is because'),
('language between humans and cats has no reserved wordshttpxkcdcom231');


INSERT INTO docs03 (doc) SELECT 'Neon ' || generate_series(10000,20000);





-- Example from lecture
DROP TABLE docs CASCADE;
DROP INDEX gin1 ON docs USING gin(to_tsvector('english', doc));

CREATE TABLE docs (id SERIAL, doc TEXT, PRIMARY KEY (id));
CREATE INDEX gin1 ON docs USING gin(to_tsvector('english', doc));

INSERT INTO docs (doc) VALUES
('This is SQL and python and other fun teaching stuff'),
('More people should learn SQL from UMSI'),
('UMSI also teaches Python and also SQL');

-- Filler rows
INSERT INTO docs (doc) SELECT 'Neon ' || GENERATE_SERIES(10000, 20000);

SELECT id, doc
FROM docs
WHERE
to_tsquery('english', 'learn') @@ to_tsvector('english', doc);

EXPLAIN SELECT id, doc
FROM docs
WHERE
to_tsquery('english', 'learn') @@ to_tsvector('english', doc);




--GOAL:
SELECT id, doc FROM docs03 WHERE to_tsquery('english', 'wordshttpxkcdcom231') @@ to_tsvector('english', doc);
EXPLAIN SELECT id, doc FROM docs03 WHERE to_tsquery('english', 'wordshttpxkcdcom231') @@ to_tsvector('english', doc);

CREATE TABLE docs03 (id SERIAL, doc TEXT, PRIMARY KEY(id));

CREATE INDEX fulltext03 ON docs03 USING gin(to_tsvector('english', doc));


INSERT INTO docs03 (doc) VALUES
('you write programs you will make up your own words that have meaning to'),
('you called variables You will have great latitude in'),
('choosing your names for your variables but you cannot use any of'),
('Pythons reserved words as a name for a variable'),
('When we train a dog we use special words like sit stay and'),
('they just look at you with a quizzical look on their face until you say'),
('a reserved word For example if you say I wish more people would walk'),
('to improve their overall health what most dogs likely hear is blah'),
('blah blah walk blah blah blah blah That is because'),
('language between humans and cats has no reserved wordshttpxkcdcom231');


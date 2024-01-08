CREATE TABLE goodreads
(
	id integer PRIMARY KEY,
	title text NOT NULL,
	author text NOT NULL,
	publishing_house text NOT NULL,
	size integer,
	isbn varchar(32) NOT NULL,
	avg_rating real,
	num_ratings real
);

Copying table data 'public.goodreads' on database 'hw_6' and server 'PostgreSQL 16 (localhost:5432)'

CREATE TABLE publisher
(
	id integer,
	publishing_house character varying,
	address character varying,
	edition integer
	founded integer,
);

INSERT INTO publisher
VALUES
(1, 'Издательство «Эксмо́»', 'Москва', 15000, 1991),
(2, 'Издательская группа «АСТ»', 'Москва', 25000, 1990),
(3, 'Издательство «Просвещение»', 'Санкт-Петербург', 2500, 1930),
(4, 'Издательская Группа «Азбука-Аттикус»', 'Санкт-Петербург', 3700, 2008),
(5, 'Издательства Легион', 'Ростов-на-Дону', 800, 2010);

SELECT * FROM goodreads
SELECT * FROM publisher

SELECT title, author
FROM goodreads
WHERE publishing_house = ANY (SELECT publishing_house FROM publisher );

SELECT goodreads.title, goodreads.author, goodreads.isbn
FROM goodreads
INNER JOIN publisher ON goodreads.publishing_house=publisher.publishing_house;

EXPLAIN ANALYZE (до создания индекса)
SELECT *
FROM goodreads
WHERE size >= 300;

"QUERY PLAN"
"Seq Scan on goodreads  (cost=0.00..6.50 rows=185 width=113) (actual time=0.027..0.062 rows=184 loops=1)"
"  Filter: (size >= 300)"
"  Rows Removed by Filter: 16"
"Planning Time: 0.976 ms"
"Execution Time: 1.099 ms"

CREATE INDEX idx_goodreads
ON goodreads (title, author, avg_rating);

EXPLAIN ANALYZE (после создания индекса)
SELECT *
FROM goodreads
WHERE size >= 300;

"QUERY PLAN"
"Seq Scan on goodreads  (cost=0.00..6.50 rows=185 width=113) (actual time=0.023..0.070 rows=184 loops=1)"
"  Filter: (size >= 300)"
"  Rows Removed by Filter: 16"
"Planning Time: 2.393 ms"
"Execution Time: 0.092 ms"

--Индексы используются для более быстрого извлечения данных из базы данных, чем в противном случае.
--До формирования индекса плановое время на обработку подсчитано 0.976 ms, после формирования индекса плановое время увеличилось до 2.393 ms.
--Обновление таблицы с индексами занимает больше времени, чем обновление таблицы без индексов, поскольку индексы также требуют обновления.
--При исполнении время уменьшилось с 1.099 ms до 0.092 ms.

--(SQL-запрос с использованием оконных функций для анализа данных внутри окна)
SELECT
  title,
  author,
  size,
  AVG(size) OVER (
    PARTITION BY title
    ORDER BY author
    ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
  ) AS avg_size
FROM
  goodreads;

--DDL (CREATE, ALTER, DROP)--

ALTER TABLE publisher
ADD director varchar(255);



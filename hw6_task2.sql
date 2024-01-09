CREATE TABLE books
(
	id integer,
	title character varying,
	author character varying,
	publication character varying,
	genre character varying,
);

INSERT INTO books
VALUES
(65656,	'451° по Фаренгейту', 'Рэй Брэдбери',	'2006',	'fantasy'),
(87877,	'1984',	'Джордж Оруэлл',	'1949',	'fantasy'),
(97877,	'Мастер и Маргарита',	'Михаил Булгаков',	'2002',	'fantasy'),
(54548,	'Три товарища',	'Эрих Мария Ремарк',	'2000',	'prose'),
(99873,	'Цветы для Элджернона',	'Дэниел Киз',	'2012',	'prose'),
(45465,	'Портрет Дориана Грея',	'Оскар Уайльд',	'1890',	'fantasy'),
(65465,	'Кэрри',	'Стивен Кинг', '1990', 'fantasy');

INSERT INTO books
VALUES
(27685, 'Десять негритят', 'Агата Кристи', '2021', 'detective');

SELECT * FROM books

SELECT title, author,genre FROM books

SELECT title, author,genre,publication FROM books

SELECT * FROM books
ORDER BY id;

SELECT * FROM books
WHERE genre='fantasy';

SELECT MAX(publication) FROM books;

CREATE VIEW [books for read] AS
SELECT title, author, publication
FROM books WHERE genre = 'fantasy';

CREATE OR REPLACE
VIEW books_for_read AS
SELECT title, author, publication
FROM books WHERE id >= 10000;

SELECT * FROM books_for_read


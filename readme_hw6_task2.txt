CREATE VIEW [Books_for_read] AS
SELECT title, author
FROM books
WHERE genre = 'fantasy';


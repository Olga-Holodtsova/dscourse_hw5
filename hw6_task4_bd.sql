CREATE TABLE student (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    progress INTEGER
);

INSERT INTO student (name, progress) VALUES ('John Doe', 96);
INSERT INTO student (name, progress) VALUES ('Jane Doe', 82);

SELECT * FROM student

-- Создать роли "admin" и "user":
CREATE ROLE "admin";
CREATE ROLE "user";

-- Предоставление различных уровней доступа для этих ролей:
-- Предоставление прав администратора
GRANT ALL PRIVILEGES ON TABLE student TO admin;

-- Предоставление прав пользователя
GRANT SELECT, INSERT, UPDATE ON TABLE student TO "user";

-- Роль "admin" имеет все привилегии на таблицу "student", в то время как роль "user" имеет права только на выполнение операций SELECT, INSERT и UPDATE.
-- Тест уровней доступа, подключение к бд от имени каждой роли:
-- Подключение от имени администратора

\c your_database admin

SELECT * FROM student;

INSERT INTO student (id, name, progress) VALUES (3, 'New Student', 72);

UPDATE student SET progress = 52 WHERE id = 1;

-- Подключение от имени пользователя

\c your_database user

SELECT * FROM student;

INSERT INTO student (name, progress) VALUES ('Another Student', 80);

ERROR:  нет доступа к последовательности student_id_seq 
ОШИБКА:  нет доступа к последовательности student_id_seq
SQL state: 42501
-- Эта операция вызовет ошибку, так как роль "user" не имеет прав на INSERT

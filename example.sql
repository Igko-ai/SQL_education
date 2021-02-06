DROP TABLE IF EXISTS users;
CREATE TABLE users(
id SERIAL PRIMARY KEY,
name VARCHAR(255) COMMENT 'Имя пользователя'
) COMMENT 'Пользователи';

SELECT * FROM users;
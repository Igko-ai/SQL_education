-- Создание БД для социальной сети ВКонтакте
-- https://vk.com/geekbrainsru

-- Делаем БД текущей
USE vk;

-- Создаём таблицу пользователей
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  first_name VARCHAR(100) NOT NULL COMMENT "Имя пользователя",
  last_name VARCHAR(100) NOT NULL COMMENT "Фамилия пользователя",
  email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта",
  phone VARCHAR(100) NOT NULL UNIQUE COMMENT "Телефон",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Пользователи";  

-- Таблица профилей
CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Ссылка на пользователя", 
  gender CHAR(1) NOT NULL COMMENT "Пол",
  birthday DATE COMMENT "Дата рождения",
  photo_id INT UNSIGNED COMMENT "Ссылка на основную фотографию пользователя",
  status VARCHAR(30) COMMENT "Текущий статус",
  city VARCHAR(100) COMMENT "Город проживания",
  postcode VARCHAR(100) COMMENT "Регион проживания",
  country_id INT UNSIGNED COMMENT "Ссылка на страну проживания",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Профили"; 

-- Таблица-справочник стран
CREATE TABLE countries (
 id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Цифровой код страны",
 country VARCHAR(50) COMMENT "Название страны"
) COMMENT "Страны";

-- Таблица сообщений
CREATE TABLE messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  from_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на отправителя сообщения",
  to_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на получателя сообщения",
  body TEXT NOT NULL COMMENT "Текст сообщения",
  is_important BOOLEAN COMMENT "Признак важности",
  is_delivered BOOLEAN COMMENT "Признак доставки",
  created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Сообщения";

-- Таблица дружбы
CREATE TABLE friendship (
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на инициатора дружеских отношений",
  friend_id INT UNSIGNED NOT NULL COMMENT "Ссылка на получателя приглашения дружить",
  status_id INT UNSIGNED NOT NULL COMMENT "Ссылка на статус (текущее состояние) отношений",
  requested_at DATETIME DEFAULT NOW() COMMENT "Время отправления приглашения дружить",
  confirmed_at DATETIME COMMENT "Время подтверждения приглашения",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки",  
  PRIMARY KEY (user_id, friend_id) COMMENT "Составной первичный ключ"
) COMMENT "Таблица дружбы";

-- Таблица статусов дружеских отношений
CREATE TABLE friendship_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название статуса",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"  
) COMMENT "Статусы дружбы";

-- Таблица групп
CREATE TABLE communities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор сроки",
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название группы",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"  
) COMMENT "Группы";

-- Таблица связи пользователей и групп
CREATE TABLE communities_users (
  community_id INT UNSIGNED NOT NULL COMMENT "Ссылка на группу",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  PRIMARY KEY (community_id, user_id) COMMENT "Составной первичный ключ"
) COMMENT "Участники групп, связь между пользователями и группами";

-- Таблица медиафайлов
CREATE TABLE media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, который загрузил файл",
  filepath VARCHAR(255) NOT NULL COMMENT "Путь к файлу",
  size INT NOT NULL COMMENT "Размер файла",
  metadata JSON COMMENT "Метаданные файла",
  media_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип контента",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Медиафайлы";

-- Таблица типов медиафайлов
CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название типа",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Типы медиафайлов";

-- Таблица типов лайков
CREATE TABLE like_types (
 id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идетификатор строки",
 like_type VARCHAR(20) NOT NULL UNIQUE COMMENT "Тип лайка"
) COMMENT "Реакция";

-- Таблица связи пользователей и лайков
CREATE TABLE users_likes (
  like_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на реакцию",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  PRIMARY KEY (like_type_id, user_id) COMMENT "Составной первичный ключ"
) COMMENT "Реакция на пользователя";

-- Таблица связи постов и лайков
CREATE TABLE messages_likes (
  like_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на реакцию",
  message_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пост",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  PRIMARY KEY (like_type_id, message_id) COMMENT "Составной первичный ключ"
) COMMENT "Реакция на пост";

-- Таблица связи медиафайлов и лайков
CREATE TABLE media_likes (
  like_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на реакцию",
  media_id INT UNSIGNED NOT NULL COMMENT "Ссылка на медиа",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  PRIMARY KEY (like_type_id, media_id) COMMENT "Составной первичный ключ"
) COMMENT "Реакция на медиафайл";


-- Доработка данных
-- Добавлена таблица user_statuses

-- заполняем таблицу user_statuses
INSERT INTO user_statuses (name) VALUES
  ('Single'),
  ('Married'),
  ('Undefined');
 
 -- Смотрим, что получилось
SELECT * FROM user_statuses us ;


-- Анализируем профайлы пользователей
SELECT * FROM profiles LIMIT 250;

-- ощищаем сожержимое колонки статус
UPDATE profiles SET status = NULL

-- меняем название колонки и тип данных
ALTER TABLE profiles CHANGE status status_id INT;


-- Анализируем данные пользователей
SELECT * FROM users LIMIT 10;

-- Приводим в порядок временные метки
UPDATE users SET updated_at = NOW() WHERE updated_at < created_at;                  


 -- Анализируем профили пользователей
SELECT * FROM profiles LIMIT 10;

-- Добавляем ссылки на статус пользователя
UPDATE profiles SET status_id = CEILING(RAND() * 3);
 
-- Добавляем ссылки на фото
UPDATE profiles SET photo_id = CEILING(RAND() * 250);


-- Анализируем данные сообщений
SELECT * FROM messages LIMIT 10;

-- Обновляем значения ссылок на отправителя и получателя сообщения
UPDATE messages SET 
  from_user_id = CEILING(RAND() * 250),
  to_user_id = CEILING(RAND() * 250);

 
-- Смотрим структуру таблицы медиаконтента 
DESC media;

-- Анализируем данные медиа
SELECT * FROM media LIMIT 10;

-- Анализируем типы медиаконтента
SELECT * FROM media_types;

-- Ощищаем таблицу
TRUNCATE media_types;

-- Добавляем нужные типы
INSERT INTO media_types (name) VALUES
  ('photo'),
  ('video'),
  ('audio');

-- Анализируем данные
SELECT * FROM media LIMIT 10;

-- Обновляем данные для ссылки на тип и владельца
UPDATE media SET media_type_id = CEILING(RAND() * 3);
UPDATE media SET user_id = CEILING(RAND() * 250);


-- Создаём временную таблицу форматов медиафайлов
CREATE TEMPORARY TABLE extensions (name VARCHAR(10));

-- Заполняем значениями
INSERT INTO extensions VALUES ('jpeg'), ('avi'), ('mpeg'), ('png');

-- Cмотрим таблицу
SELECT * FROM extensions;

-- Обновляем ссылку на файл
UPDATE media SET filepath = CONCAT(
  filepath ,
  (SELECT last_name FROM users ORDER BY RAND() LIMIT 1),
  '.',
  (SELECT name FROM extensions ORDER BY RAND() LIMIT 1)
);

-- Обновляем размер файлов
UPDATE media SET size = FLOOR(10000 + (RAND() * 1000000)) WHERE size < 1000;

-- Заполняем метаданные
UPDATE media SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}');  

-- Возвращаем столбцу метеданных правильный тип
ALTER TABLE media MODIFY COLUMN metadata JSON;

-- Смотрим, что получилось
SELECT * FROM media LIMIT 10;


-- Смотрим структуру таблицы дружбы
DESC friendship;
RENAME TABLE friendship TO friendships;

-- Анализируем данные
SELECT * FROM friendships LIMIT 10;

-- Обновляем ссылки на друзей
UPDATE friendships SET 
  user_id = CEILING(RAND() * 250),
  friend_id = CEILING(RAND() * 250);

-- Исправляем случай когда user_id = friend_id
UPDATE friendships SET friend_id = friend_id + 1 WHERE user_id = friend_id;
 
-- Анализируем данные 
SELECT * FROM friendship_statuses;

-- Очищаем таблицу
TRUNCATE friendship_statuses;

-- Вставляем значения статусов дружбы
INSERT INTO friendship_statuses (name) VALUES
  ('Requested'),
  ('Confirmed'),
  ('Rejected');
 
-- Обновляем ссылки на статус 
UPDATE friendships SET status_id = CEILING(RAND() * 3); 


-- Смотрим структуру таблицы групп
DESC communities;

-- Анализируем данные
SELECT * FROM communities;

-- Удаляем часть групп
DELETE FROM communities WHERE id > 20;

-- Анализируем таблицу связи пользователей и групп
SELECT * FROM communities_users;

-- Обновляем значения community_id
UPDATE communities_users SET community_id = CEILING(RAND() * 20)
WHERE user_id BETWEEN 1 AND 50;

-- Обновляем значения community_id
UPDATE communities_users SET community_id = CEILING(RAND() * 20)
WHERE user_id BETWEEN 51 AND 75;

-- Обновляем значения community_id
UPDATE communities_users SET community_id = CEILING(RAND() * 20)
WHERE user_id BETWEEN 76 AND 100;

-- Обновляем значения community_id
UPDATE communities_users SET community_id = CEILING(RAND() * 20)
WHERE user_id BETWEEN 101 AND 125;

-- Обновляем значения community_id
UPDATE communities_users SET community_id = CEILING(RAND() * 20)
WHERE user_id BETWEEN 126 AND 150;

-- Обновляем значения community_id
UPDATE communities_users SET community_id = CEILING(RAND() * 20)
WHERE user_id BETWEEN 151 AND 175;

-- Обновляем значения community_id
UPDATE communities_users SET community_id = CEILING(RAND() * 20)
WHERE user_id BETWEEN 176 AND 200;

-- Обновляем значения community_id
UPDATE communities_users SET community_id = CEILING(RAND() * 20)
WHERE user_id BETWEEN 201 AND 225;

-- Обновляем значения community_id
UPDATE communities_users SET community_id = CEILING(RAND() * 20)
WHERE user_id BETWEEN 226 AND 250;

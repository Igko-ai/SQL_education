-- тема “Оптимизация запросов”

/* 1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products 
 * в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.*/
USE shop;

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME ,
	table_name_to_log VARCHAR(100) NOT NULL,
	id_to_log INT NOT NULL,
	name_to_log VARCHAR(255) NOT NULL
) ENGINE=Archive;

DROP TRIGGER IF EXISTS log_users;
DELIMITER $$
CREATE TRIGGER log_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs(created_at, table_name_to_log, id_to_log, name_to_log) VALUES
 	(NOW(), 'users', NEW.id, NEW.name);
END$$

DROP TRIGGER IF EXISTS log_catalogs;
DELIMITER $$
CREATE TRIGGER log_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs(created_at, table_name_to_log, id_to_log, name_to_log) VALUES
 	(NOW(), 'catalogs', NEW.id, NEW.name);
END$$

DROP TRIGGER IF EXISTS log_products;
DELIMITER $$
CREATE TRIGGER log_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs(created_at, table_name_to_log, id_to_log, name_to_log) VALUES
 	(NOW(), 'products', NEW.id, NEW.name);
END$$

-- test
INSERT INTO catalogs (name) VALUES 
('Клавиатуры'),
('Мышки');

SELECT * FROM logs; 

/* 2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.*/

-- сделал новую таблицу test, такую же как users
DROP TABLE IF EXISTS test;
CREATE TABLE test (
	id SERIAL,
	name VARCHAR(50),
	birthday_at DATE,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
 	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


DROP PROCEDURE IF EXISTS insert_values
delimiter $$
CREATE PROCEDURE insert_values ()
BEGIN
	DECLARE i INT DEFAULT 0;
	SELECT @delta := 10000;
	/* при @delta := 100000 время создания 1000000 записей 7 мин 21 сек
	   при @delta := 50000 время создания 1000000 записей  4 мин 24 сек
	   при @delta := 25000 время создания 1000000 записей  2 мин 16 сек
	   при @delta := 10000 время создания 1000000 записей  1 мин 26 сек
	   практически 100%-ная линейная зависимость, при построении линии тренда R^2 = 0.9941
	   y = 0.0667x + 0.7768 исходя из этого, если @delta := 1000000, то это займёт примерно 67,5 минут (не проверял) */
	WHILE i < @delta DO
		-- insert для @delta := 10000
		INSERT INTO test(name, birthday_at) VALUES 
		(CONCAT('user_', i + 0*@delta), NOW()),
		(CONCAT('user_', i + 1*@delta), NOW()),
		(CONCAT('user_', i + 2*@delta), NOW()),
		(CONCAT('user_', i + 3*@delta), NOW()),
		(CONCAT('user_', i + 4*@delta), NOW()),
		(CONCAT('user_', i + 5*@delta), NOW()),
		(CONCAT('user_', i + 6*@delta), NOW()),
		(CONCAT('user_', i + 7*@delta), NOW()),
		(CONCAT('user_', i + 8*@delta), NOW()),
		(CONCAT('user_', i + 9*@delta), NOW()),
		(CONCAT('user_', i + 10*@delta), NOW()),
		(CONCAT('user_', i + 11*@delta), NOW()),
		(CONCAT('user_', i + 12*@delta), NOW()),
		(CONCAT('user_', i + 13*@delta), NOW()),
		(CONCAT('user_', i + 14*@delta), NOW()),
		(CONCAT('user_', i + 15*@delta), NOW()),
		(CONCAT('user_', i + 16*@delta), NOW()),
		(CONCAT('user_', i + 17*@delta), NOW()),
		(CONCAT('user_', i + 18*@delta), NOW()),
		(CONCAT('user_', i + 19*@delta), NOW()),
		(CONCAT('user_', i + 20*@delta), NOW()),
		(CONCAT('user_', i + 21*@delta), NOW()),
		(CONCAT('user_', i + 22*@delta), NOW()),
		(CONCAT('user_', i + 23*@delta), NOW()),
		(CONCAT('user_', i + 24*@delta), NOW()),
		(CONCAT('user_', i + 25*@delta), NOW()),
		(CONCAT('user_', i + 26*@delta), NOW()),
		(CONCAT('user_', i + 27*@delta), NOW()),
		(CONCAT('user_', i + 28*@delta), NOW()),
		(CONCAT('user_', i + 29*@delta), NOW()),
		(CONCAT('user_', i + 30*@delta), NOW()),
		(CONCAT('user_', i + 31*@delta), NOW()),
		(CONCAT('user_', i + 32*@delta), NOW()),
		(CONCAT('user_', i + 33*@delta), NOW()),
		(CONCAT('user_', i + 34*@delta), NOW()),
		(CONCAT('user_', i + 35*@delta), NOW()),
		(CONCAT('user_', i + 36*@delta), NOW()),
		(CONCAT('user_', i + 37*@delta), NOW()),
		(CONCAT('user_', i + 38*@delta), NOW()),
		(CONCAT('user_', i + 39*@delta), NOW()),
		(CONCAT('user_', i + 40*@delta), NOW()),
		(CONCAT('user_', i + 41*@delta), NOW()),
		(CONCAT('user_', i + 42*@delta), NOW()),
		(CONCAT('user_', i + 43*@delta), NOW()),
		(CONCAT('user_', i + 44*@delta), NOW()),
		(CONCAT('user_', i + 45*@delta), NOW()),
		(CONCAT('user_', i + 46*@delta), NOW()),
		(CONCAT('user_', i + 47*@delta), NOW()),
		(CONCAT('user_', i + 48*@delta), NOW()),
		(CONCAT('user_', i + 49*@delta), NOW()),
		(CONCAT('user_', i + 50*@delta), NOW()),
		(CONCAT('user_', i + 51*@delta), NOW()),
		(CONCAT('user_', i + 52*@delta), NOW()),
		(CONCAT('user_', i + 53*@delta), NOW()),
		(CONCAT('user_', i + 54*@delta), NOW()),
		(CONCAT('user_', i + 55*@delta), NOW()),
		(CONCAT('user_', i + 56*@delta), NOW()),
		(CONCAT('user_', i + 57*@delta), NOW()),
		(CONCAT('user_', i + 58*@delta), NOW()),
		(CONCAT('user_', i + 59*@delta), NOW()),
		(CONCAT('user_', i + 60*@delta), NOW()),
		(CONCAT('user_', i + 61*@delta), NOW()),
		(CONCAT('user_', i + 62*@delta), NOW()),
		(CONCAT('user_', i + 63*@delta), NOW()),
		(CONCAT('user_', i + 64*@delta), NOW()),
		(CONCAT('user_', i + 65*@delta), NOW()),
		(CONCAT('user_', i + 66*@delta), NOW()),
		(CONCAT('user_', i + 67*@delta), NOW()),
		(CONCAT('user_', i + 68*@delta), NOW()),
		(CONCAT('user_', i + 69*@delta), NOW()),
		(CONCAT('user_', i + 70*@delta), NOW()),
		(CONCAT('user_', i + 71*@delta), NOW()),
		(CONCAT('user_', i + 72*@delta), NOW()),
		(CONCAT('user_', i + 73*@delta), NOW()),
		(CONCAT('user_', i + 74*@delta), NOW()),
		(CONCAT('user_', i + 75*@delta), NOW()),
		(CONCAT('user_', i + 76*@delta), NOW()),
		(CONCAT('user_', i + 77*@delta), NOW()),
		(CONCAT('user_', i + 78*@delta), NOW()),
		(CONCAT('user_', i + 79*@delta), NOW()),
		(CONCAT('user_', i + 80*@delta), NOW()),
		(CONCAT('user_', i + 81*@delta), NOW()),
		(CONCAT('user_', i + 82*@delta), NOW()),
		(CONCAT('user_', i + 83*@delta), NOW()),
		(CONCAT('user_', i + 84*@delta), NOW()),
		(CONCAT('user_', i + 85*@delta), NOW()),
		(CONCAT('user_', i + 86*@delta), NOW()),
		(CONCAT('user_', i + 87*@delta), NOW()),
		(CONCAT('user_', i + 88*@delta), NOW()),
		(CONCAT('user_', i + 89*@delta), NOW()),
		(CONCAT('user_', i + 90*@delta), NOW()),
		(CONCAT('user_', i + 91*@delta), NOW()),
		(CONCAT('user_', i + 92*@delta), NOW()),
		(CONCAT('user_', i + 93*@delta), NOW()),
		(CONCAT('user_', i + 94*@delta), NOW()),
		(CONCAT('user_', i + 95*@delta), NOW()),
		(CONCAT('user_', i + 96*@delta), NOW()),
		(CONCAT('user_', i + 97*@delta), NOW()),
		(CONCAT('user_', i + 98*@delta), NOW()),
		(CONCAT('user_', i + 99*@delta), NOW());
		SET i = i + 1;	
	END WHILE;
END$$

CALL insert_values ()$$ 


-- тема “NoSQL”

-- установка Redis
sudo apt update
sudo apt install redis-server

-- 1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.
-- создаем коллекцию
127.0.0.1:6379> sadd ip_address 127.0.0.2 127.0.0.3 127.0.0.4 127.0.0.5 127.0.0.6
(integer) 5
-- входящие в коллекцию уникальные значения
127.0.0.1:6379> smembers ip_address
1) "127.0.0.5"
2) "127.0.0.4"
3) "127.0.0.3"
4) "127.0.0.2"
5) "127.0.0.6"
-- количество уникальных значений в коллекции
127.0.0.1:6379> scard ip_address
(integer) 5
-- первое посещение
127.0.0.1:6379> set 127.0.0.2 1
OK
127.0.0.1:6379> get 127.0.0.2
"1"
-- следующее посещение
127.0.0.1:6379> incr 127.0.0.2
(integer) 2
127.0.0.1:6379> get 127.0.0.2
"2"

-- 2. При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени.
127.0.0.1:6379> mset ex@ex.ru ex_name ex_name ex@ex.ru
OK
127.0.0.1:6379> get ex_name
"ex@ex.ru"
127.0.0.1:6379> get ex@ex.ru
"ex_name"

-- 3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.
-- установка и запуск MongoDB
curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt update
sudo apt install mongodb-org
sudo systemctl start mongod.service

> use shop
switched to db shop
> db.shop.insert({"type":"category", "name":"computers"})
WriteResult({ "nInserted" : 1 })
> db.shop.insert({"type":"products", "name":"display"})
WriteResult({ "nInserted" : 1 })
> db.shop.find()
{ "_id" : ObjectId("5d3991370b05a4bb2c4f3cbf"), "type" : "category", "name" : "computers" }
{ "_id" : ObjectId("5d39914c0b05a4bb2c4f3cc0"), "type" : "products", "name" : "display" }




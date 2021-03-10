/* 1. Проанализировать какие запросы могут выполняться наиболее часто в процессе работы приложения и добавить необходимые индексы.*/

-- Поиск пользователя по фамилии
CREATE INDEX users_last_name_idx ON users(last_name);

-- Поиск пользователя по городу проживания
CREATE INDEX profiles_city_idx ON profiles(city);

-- Поиск поста по заголовку
CREATE INDEX posts_head_idx ON posts(head);

/* 2. Задание на оконные функции
Построить запрос, который будет выводить следующие столбцы:
имя группы
среднее количество пользователей в группах
самый молодой пользователь в группе
самый старший пользователь в группе
общее количество пользователей в группе
всего пользователей в системе
отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100 */

SELECT DISTINCT communities.name,
	COUNT(communities_users.community_id) OVER () / MAX(communities_users.community_id) OVER () AS average_by_groups,
	FIRST_VALUE(users.id) OVER (PARTITION BY communities_users.community_id ORDER BY profiles.birthday DESC) AS younger_user,
 	FIRST_VALUE(users.id) OVER (PARTITION BY communities_users.community_id ORDER BY profiles.birthday) AS older_user,
	COUNT(communities_users.user_id) OVER (PARTITION BY communities_users.community_id) AS users_by_groups,
  	MAX(users.id) OVER () AS total_users,
    COUNT(communities_users.user_id) OVER (PARTITION BY communities_users.community_id) / MAX(users.id) OVER () * 100 AS percentage_by_groups
	FROM communities_users
		LEFT JOIN communities
        	ON communities_users.community_id = communities.id
    	LEFT JOIN profiles
        	ON communities_users.user_id = profiles.user_id
        LEFT JOIN users
        	ON communities_users.user_id = users.id;

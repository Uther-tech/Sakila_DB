#1- Afficher les 5 premiers Records de la table Actor
SELECT * FROM sakila.actor LIMIT 5 ;
#ou
SELECT * FROM actor WHERE actor_id <= 5;

#2- Récupérer dans une colonne Actor_Name le full_name des acteurs sous le format: first_name + " " + last_name;
SELECT CONCAT(first_name, ' ', last_name) AS Actor_Name FROM actor;

#3- Récupérer dans une colonne Actor_Name le full_name des acteurs sous le format: first_name en minuscule + "." + last_name en majuscule
SELECT CONCAT(LOWER(first_name), '.', UPPER(last_name)) AS Actor_Name FROM actor;

#4- Récupérer dans une colonne Actor_Name le full_name des acteurs sous le format: last_name en
#majuscule + "." + premiere lettre du first_name en majuscule
SELECT CONCAT(UPPER(last_name), '.', UPPER(LEFT(first_name, 1)),LOWER(SUBSTRING(first_name,2))) AS Actor_Name FROM actor;

#5- Trouver le ou les acteurs appelé(s) "JENNIFER"
SELECT first_name FROM actor WHERE UPPER(first_name) = 'JENNIFER';
SELECT first_name FROM actor WHERE first_name = 'JENNIFER';

#6- Trouver les acteurs ayant des prénoms de 3 charactères
SELECT first_name FROM actor WHERE CHAR_LENGTH(first_name) = 3;

#7- Afficher les acteurs (actor_id, first_name, last_name, nbre char first_name, nbre char
#last_name )par ordre décroissant de longueur de prénoms
SELECT actor_id, first_name, last_name, CHAR_LENGTH(first_name) AS nbre_char_first_name, CHAR_LENGTH(last_name) AS nbre_char_last_name
FROM actor ORDER BY CHAR_LENGTH(first_name) DESC;

#8- Afficher les acteurs (actor_id, first_name, last_name, nbre char first_name, nbre char
#last_name )par ordre décroissant de longueur de prénoms et croissant de longuer de noms
SELECT actor_id, first_name, last_name, CHAR_LENGTH(first_name) AS nbre_char_first_name, CHAR_LENGTH(last_name) AS nbre_char_last_name
FROM actor ORDER BY CHAR_LENGTH(first_name) DESC, CHAR_LENGTH(last_name) ASC;

#9- Trouver les acteurs ayant dans leurs last_names la chaine: "SON
SELECT actor_id, first_name, last_name FROM actor WHERE last_name LIKE '%SON%';
SELECT actor_id, first_name, last_name FROM actor WHERE UPPER(last_name) LIKE '%SON%';

#10- Trouver les acteurs ayant des last_names commençant par la chaine: "JOH"
SELECT actor_id, first_name, last_name FROM actor WHERE UPPER(last_name) LIKE 'JOH%';

#11- Afficher par ordre alphabétique croissant les last_names et les first_names des acteurs ayant dans leurs last_names la chaine "LI"
SELECT first_name, last_name FROM actor WHERE last_name LIKE '%LI%' ORDER BY last_name ASC, first_name ASC;
SELECT first_name, last_name FROM actor WHERE UPPER(last_name) LIKE '%LI%'ORDER BY last_name ASC, first_name ASC;

#12- trouver dans la table country les countries "China", "Afghanistan", "Bangladesh"
SELECT * FROM country WHERE UPPER(country) IN ('CHINA', 'AFGHANISTAN', 'BANGLADESH');

#13- Ajouter une colonne middle_name entre les colonnes first_name et last_name
ALTER TABLE actor ADD middle_name VARCHAR(50) AFTER first_name;

#14- Changer le data type de la colonne middle_name au type blob
ALTER TABLE actor MODIFY middle_name BLOB;

#15- Supprimer la colonne middle_name
ALTER TABLE actor DROP COLUMN middle_name;

#16- Trouver le nombre des acteurs ayant le meme last_name Afficher le resultat par ordre décroissant
SELECT last_name, COUNT(*) AS count FROM actor GROUP BY last_name ORDER BY count DESC;

#17- Trouver le nombre des acteurs ayant le meme last_name 
#Afficher UNIQUEMENT les last_names communs à au moins 3 acteurs Afficher par ordre alph. croissant
SELECT last_name, COUNT(*) AS count FROM actor GROUP BY last_name HAVING COUNT(*) >= 3 ORDER BY last_name ASC;

#18- Trouver le nombre des acteurs ayant le meme first_name Afficher le resultat par ordre alph.croissant
SELECT first_name, COUNT(*) AS count FROM actor GROUP BY first_name ORDER BY first_name ASC;

#19- Insérer dans la table actor ,un nouvel acteur , faites attention à l'id!
INSERT INTO actor (first_name, last_name) VALUES ('MAREVA', 'TASSIN');

#20- Modifier le first_name du nouvel acteur à "Jean"
UPDATE actor SET first_name = 'Jean' WHERE first_name = 'MAREVA' AND last_name = 'TASSIN';

#21- Supprimer le dernier acteur inséré de la table actor###
#DELETE FROM actor ORDER BY actor_id DESC LIMIT 1;
DELETE FROM actor WHERE id = last_insert_id();

#22-Corriger le first_name de l'acteur HARPO WILLIAMS qui était accidentellement inséré à GROUCHO WILLIAMS
UPDATE actor SET first_name = 'HARPO' WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

#23- Mettre à jour le first_name dans la table actor pour l'actor_id 173 comme suit: si le first_name="ALAN" 
#alors remplacer le par "ALLAN" sinon par "MUCHO ALLAN"
UPDATE actor SET first_name = IF(first_name = 'ALAN', 'ALLAN', 'MUCHO ALLAN') WHERE actor_id = 173;

#24- Trouver les first_names,last names et l'adresse de chacun des membre staff RQ: utiliser join avec les tables staff & address:
SELECT staff.first_name, staff.last_name, address.address FROM staff JOIN address ON staff.address_id = address.address_id;

#25- Afficher pour chaque membre du staff ,le total de ses salaires depuis Aout 2005. RQ: Utiliser les tables staff & payment.
SELECT staff.staff_id, staff.first_name, staff.last_name, SUM(payment.amount) AS total_salary FROM staff
JOIN payment ON staff.staff_id = payment.staff_id WHERE payment.payment_date >= '2005-08-01' GROUP BY staff.staff_id, staff.first_name, 
staff.last_name ORDER BY total_salary DESC;

#26- Afficher pour chaque film ,le nombre de ses acteurs
SELECT film.title, COUNT(actor_id) AS Nombre_d_acteurs
FROM film JOIN film_actor ON film.id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor_id GROUP BY film.title;

SELECT film.title, COUNT(actor.actor_id) AS Nombre_d_acteurs
FROM film JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id =actor.actor_id GROUP BY film.title;

#27- Trouver le film intitulé "Hunchback Impossible"
SELECT film_id 
FROM film 
WHERE title = 'Hunchback Impossible';

#28- combien de copies exist t il dans le systme d'inventaire pour le film Hunchback Impossible
SELECT COUNT(*) 
FROM inventory 
WHERE film_id = (
    SELECT film_id 
    FROM film 
    WHERE title = 'Hunchback Impossible'
);


#29- Afficher les titres des films en anglais commençant par 'K' ou 'Q'
SELECT title
FROM film 
WHERE (title LIKE 'K%' OR title LIKE 'Q%') AND language_id = 'English';

#30- Afficher les first et last names des acteurs qui ont participé au film intitulé 'ACADEMY DINOSAUR'
SELECT actor.first_name, actor.last_name 
FROM actor 
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id 
WHERE film.title = 'ACADEMY DINOSAUR';

#31-Trouver la liste des films catégorisés comme family films
SELECT film.title
FROM film 
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id 
WHERE category.name = 'Family';

#32- Afficher le top 5 des films les plus loués par ordre decroissant
SELECT film.title, COUNT(rental.rental_id) as rental_count FROM film 
JOIN inventory ON film.film_id = inventory.film_id JOIN rental ON
inventory.inventory_id = rental.inventory_id GROUP BY film.title ORDER BY rental_count DESC LIMIT 5;

#33- Afficher la liste des stores : store ID, city, country
SELECT store.store_id, city.city, country.country FROM store JOIN address ON store.address_id = address.address_id 
JOIN city ON address.city_id = city.city_id JOIN country ON city.country_id = country.country_id;

#34- Afficher le chiffre d'affaire par store. RQ: le chiffre d'affaire = somme (amount)
SELECT store.store_id, SUM(payment.amount) as total_revenue FROM store JOIN staff ON store.store_id = staff.store_id 
JOIN payment ON staff.staff_id = payment.staff_id GROUP BY store.store_id;

#35- Lister par ordre décroissant le top 5 des catégories ayant le plus des revenues.
# RQ utiliser les tables : category, film_category, inventory, payment, et rental.

SELECT category.name, SUM(payment.amount) as total_revenue 
FROM category 
JOIN film_category ON category.category_id = film_category.category_id 
JOIN inventory ON film_category.film_id = inventory.film_id 
JOIN rental ON inventory.inventory_id = rental.inventory_id 
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY total_revenue DESC
LIMIT 5;

#36- Créer une view top_five_genres avec les résultat de la requete precedante
CREATE VIEW top_five_genres AS
SELECT category.name, SUM(payment.amount) as total_revenue 
FROM category 
JOIN film_category ON category.category_id = film_category.category_id 
JOIN inventory ON film_category.film_id = inventory.film_id 
JOIN rental ON inventory.inventory_id = rental.inventory_id 
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY total_revenue DESC
LIMIT 5;

#37- Supprimer la table top_five_genres
DROP VIEW IF EXISTS top_five_genres;


















CREATE DATABASE booklog2018;

CREATE TABLE books (
	id SERIAL4 PRIMARY KEY,
	title VARCHAR(400),
	author VARCHAR(400),
	genre VARCHAR(100),
	rating Integer,
	image_url VARCHAR(400)
);

INSERT INTO books (title, author, genre, rating, image_url) VALUES ('Less Than Zero', 'Bret Easton Ellis', 'fiction', 4, 'https://images.gr-assets.com/books/1328459200l/10317124.jpg');

ALTER TABLE books ADD review TEXT;
ALTER TABLE books ADD purchase_url VARCHAR(400);
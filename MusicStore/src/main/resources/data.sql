truncate product_tbl;
alter table product_tbl modify price decimal(5,2);
insert into product_tbl
	(imageurl, category, title, artist, style, format, price, genre, quantity)
values
	('images/electronic.jpg', 'Music', 'Testing1', 'Tester', 'Electronic', 'digital', 15, 'rock', 3);
insert into product_tbl
	(imageurl, category, title, artist, style, format, price, genre, quantity)
values
	('images/rap.jpg', 'Music', 'Testing2', 'Tester', 'rap', 'digital', 15, 'rock', 3);
insert into product_tbl
	(imageurl, category, title, artist, style, format, price, genre, quantity)
values
	('images/hiphop.jpg', 'Music', 'Testing3', 'Tester', 'Hip Hop', 'cd', 15, 'rock', 3);
insert into product_tbl
	(imageurl, category, title, artist, style, format, price, genre, quantity)
values
	('images/violin.jpg', 'Music', 'Does it Really Work?', 'Joe Mama', 'Classical', 'vinyl', 15, 'electronic', 3);
insert into product_tbl
	(imageurl, category, title, artist, style, format, price, genre, quantity)
values
	('images/rock.jpg', 'Music', 'B All U Can B', 'Th Stones', 'Rock', 'vinyl', 15, 'electronic', 3);

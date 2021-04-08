truncate product_tbl;
alter table product_tbl modify price decimal(5,2);
insert into product_tbl
	(product_id,title, artist, style, format, price, genre, quantity)
values
<<<<<<< HEAD
	('Testing1', 'Tester', 'folk', 'digital', 15.00, 'rock', 3);
=======
	(0,'Testing1', 'Tester', 'folk', 'digital', 15, 'rock', 3);
>>>>>>> f6e7e342b4444bc0f148245a2d242515678cd3a8
insert into product_tbl
	(product_id,title, artist, style, format, price, genre, quantity)
values
	(0,'Testing2', 'Tester', 'folk', 'digital', 15, 'rock', 3);
insert into product_tbl
	(product_id,title, artist, style, format, price, genre, quantity)
values
	(0,'Testing3', 'Tester', 'symphony', 'cd', 15, 'rock', 3);
insert into product_tbl
	(product_id,title, artist, style, format, price, genre, quantity)
values
	(0,'Does it Really Work?', 'Joe Mama', 'hard core', 'vinyl', 15, 'electronic', 3);

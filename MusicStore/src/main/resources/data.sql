truncate product_tbl;
alter table product_tbl modify price decimal(5,2);
insert into product_tbl
	(title, artist, style, format, price, genre, quantity)
values
	('Testing1', 'Tester', 'folk', 'digital', 15, 'rock', 3);
insert into product_tbl
	(title, artist, style, format, price, genre, quantity)
values
	('Testing2', 'Tester', 'folk', 'digital', 15, 'rock', 3);
insert into product_tbl
	(title, artist, style, format, price, genre, quantity)
values
	('Testing3', 'Tester', 'symphony', 'cd', 15, 'rock', 3);
insert into product_tbl
	(title, artist, style, format, price, genre, quantity)
values
	('Does it Really Work?', 'Joe Mama', 'hard core', 'vinyl', 15, 'electronic', 3);

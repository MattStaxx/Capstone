truncate product_tbl;
alter table product_tbl modify price decimal(5,2);


insert into product_tbl
	(id,category,imageurl,title, artist, style, format, price, genre, quantity)
values
	(0,'Electronics','images/turntable1-1280.jpg','Airpods',"N/A", 'folk', 'digital', 15.00, 'rock', 3);

insert into product_tbl
	(category,imageurl,title, artist, style, format, price, genre, quantity)
values
	('Electronics','images/turntable1-1280.jpg','Airpods',"N/A", 'folk', 'digital', 15.00, 'rock', 3);
insert into product_tbl
	(category,imageurl,title, artist, style, format, price, genre, quantity)
values
	('Electronics','images/turntable1-1280.jpg','Airpods',"N/A", 'folk', 'digital', 15.00, 'rock', 3);
insert into product_tbl
	(category,imageurl,title, artist, style, format, price, genre, quantity)
values
	('Electronics','images/turntable1-1280.jpg','Airpods',"N/A", 'folk', 'digital', 15.00, 'rock', 3);


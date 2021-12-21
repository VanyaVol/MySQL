-- створення бази данних

create database okten;


-- показати всі бази данних

show databases;


-- вибрати бд

use okten;


-- створення таблиці

create table cars
(
    id    int         not null auto_increment,
    make  varchar(20) not null,
    model varchar(20) not null,
    year  year        not null,
    price int         not null,
    primary key (id)
);


-- оновлення полів таблиці

alter table cars
    add count int null;


-- запит показати всі поля в таблиці cars

select * from cars;


-- ініціалізація полів таблиці

insert into cars VALUE (null, 'audi', 'a4', 2000, 2000, 1);
insert into cars VALUE (null, 'audi', 'a3', 1998, 1900, 2);
insert into cars VALUE (null, 'bmw', '3', 1998, 1700,3);
insert into cars VALUE (null, 'bmw', '5', 2005, 3500,5);
insert into cars VALUE (null, 'volkswagen', 'golf 2', 1995, 1200,3);
insert into cars VALUE (null, 'volkswagen', 'golf 3', 1999, 1900,2);
insert into cars VALUE (null, 'volkswagen', 'golf 4', 2002, 2900,1);
insert into cars VALUE (null, 'volkswagen', 'golf 5', 2006, 7299,2);
insert into cars VALUE (null, 'mazda', '5', 2006, 6299,2);
insert into cars VALUE (null, 'kia', 'sorento', 2009, 10299,2);
insert into cars VALUE (null, 'volkswagen', 'touareg 3', 2020, 20999,1);
insert into cars VALUE (null, 'volkswagen', 'touareg 1', 2008, 10999,1);
insert into cars VALUE (null, 'volkswagen', 'touareg 2', 2010, 14999,10);
insert into cars VALUE (null, 'bmw', 'm5', 2007, 14999,5);
insert into cars VALUE (null, 'bmw', 'm6', 2016, 24999,6);
insert into cars VALUE (null, 'kia', 'sonata', 2011, 12999,3);


-- видалити значення

delete from cars where id > 0;


-- task 1
-- найти все машины старше 2000 г

select * from cars where year > 2000;


-- task 2
-- найти все машины млатше 2015 г

select * from cars where year < 2015;


-- task 3
-- найти все машины 2008, 2009, 2010 годов

select * from cars where year >= 2008 and year <= 2010;
select * from cars where year = 2008 or year = 2009 or year = 2010;


-- task 4
-- найти все машины не с этих годов 2008, 2009, 2010 годов

select * from cars where not (year >= 2008 and year <= 2010);


-- task 5
-- найти все машины год которых совпадает с ценой

select * from cars where year = price;


-- task 6
-- найти все машины bmw старше 2014 года

select * from cars where make = 'bmw' and year > 2015;


-- task 7
-- найти все машины audi младше 2014 года

select * from cars where make = 'audi' and year < 2014;
select * from cars where make like 'audi' and year < 2014;


-- task 8
-- найти первые 5 машин

select * from cars limit 5;
select * from cars where id <= 5;


-- task 9
-- найти последнии 5 машин

select * from cars order by id desc limit 5;


-- task 10
-- найти среднее арифметическое цен машин модели KIA

select avg(price) as 'KIA AVG PRICE' from cars where make = 'kia';


-- task 11
-- найти среднее арифметическое цен каждой машины

select avg(price) as 'AVG', make from cars group by make;


-- task 12
-- посчитать количество каждой марки машин

select make, count(make) as 'COUNT' from cars group by make;
select COUNT(make) as countNew from cars group by make order by countNew desc limit 1;


-- task 13
-- найти марку машины количество которых больше всего

select make,max(count) from cars;


-- task 14
-- найти все машины в модели которых вторая и предпоследняя буква "а"

select * from cars where make like '_a%a';


-- task 15
-- найти все машины модели которых больше 8 символов

select * from cars where length(make) > 8;


-- task 16
-- ***найти машины цена которых больше чем цена среднего арифметического всех машин

select * from cars where price > (select avg(price) from cars);


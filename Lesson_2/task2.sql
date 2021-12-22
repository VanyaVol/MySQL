show databases ;

use vanyavol;

show tables;

-- 1.Вибрати усіх клієнтів, чиє ім'я має менше ніж 6 символів.

select * from client where length(FirstName) < 6;


-- 2.Вибрати львівські відділення банку.

select * from department where DepartmentCity like 'lviv';


-- 3.Вибрати клієнтів з вищою освітою та посортувати по прізвищу.

select * from client where Education = 'high' order by LastName;


-- 4.Виконати сортування у зворотньому порядку над таблицею Заявка і вивести 5 останніх елементів.

select * from application order by idApplication desc limit 5;


-- 5.Вивести усіх клієнтів, чиє прізвище закінчується на OV чи OVA.

select * from client where LastName like '%ov' or LastName like '%ova';


-- 6.Вивести клієнтів банку, які обслуговуються київськими відділеннями.

select idClient, FirstName, LastName, d.DepartmentCity from client join department d on client.Department_idDepartment = d.idDepartment
where DepartmentCity like 'kyiv';


-- 7.Знайти унікальні імена клієнтів.

select distinct FirstName from client;


-- 
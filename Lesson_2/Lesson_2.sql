show databases;

use vanyavol;

show tables;

-- 1.Вибрати усіх клієнтів, чиє ім'я має менше ніж 6 символів.

select *
from client
where length(FirstName) < 6;


-- 2.Вибрати львівські відділення банку.

select *
from department
where DepartmentCity like 'lviv';


-- 3.Вибрати клієнтів з вищою освітою та посортувати по прізвищу.

select *
from client
where Education = 'high'
order by LastName;


-- 4.Виконати сортування у зворотньому порядку над таблицею Заявка і вивести 5 останніх елементів.

select *
from application
order by idApplication desc
limit 5;


-- 5.Вивести усіх клієнтів, чиє прізвище закінчується на OV чи OVA.

select *
from client
where LastName like '%ov'
   or LastName like '%ova';


-- 6.Вивести клієнтів банку, які обслуговуються київськими відділеннями.

select idClient, FirstName, LastName, d.DepartmentCity
from client
         join department d on client.Department_idDepartment = d.idDepartment
where DepartmentCity like 'kyiv';


-- 7.Знайти унікальні імена клієнтів.

select distinct FirstName
from client;


-- 8.Вивести дані про клієнтів, які мають кредит більше ніж на 5000 тисяч гривень.

select c.idClient, c.FirstName, c.LastName, a.Sum
from client c
         join application a on c.idClient = a.Client_idClient
where a.Sum > 5000;


-- 9.Порахувати кількість клієнтів усіх відділень та лише львівських відділень.

select COUNT(*) as CountAllClients
from client c
         join department d on c.Department_idDepartment = d.idDepartment
union
select COUNT(*) as Clientslviv
from client cl
         join department de on cl.Department_idDepartment = de.idDepartment
where de.DepartmentCity = 'Lviv';

select (select count(*)
        from client c
                 join department d on c.Department_idDepartment = d.idDepartment) as AllCities,
       (select count(*)
        from client c1
                 join department d1 on c1.Department_idDepartment = d1.idDepartment
        where d1.DepartmentCity = 'Lviv')                                         as CityLviv
from dual;


-- 10.Знайти кредити, які мають найбільшу суму для кожного клієнта окремо.

select c.LastName, c.FirstName, max(a.Sum) as 'Max credit'
from application a
         join client c on c.idClient = a.Client_idClient
group by a.Client_idClient;


-- 11. Визначити кількість заявок на крeдит для кожного клієнта.

select c.FirstName, c.LastName, count(*) as 'Count credits'
from application a
         join client c on c.idClient = a.Client_idClient
group by c.idClient;


-- 12. Визначити найбільший та найменший кредити.

select 'max credit', max(Sum) as 'max credit'
from application
union
select 'min credit', min(Sum) as 'min credit'
from application;

# or

select (select max(Sum) from application) as 'Max credit',
       (select min(Sum) from application) as 'Min credit'
from dual;


-- 13. Порахувати кількість кредитів для клієнтів,які мають вищу освіту.

select FirstName, LastName, count(*) as 'Count credits high education'
from client c
         join application a on c.idClient = a.Client_idClient
where c.Education = 'high'
group by idClient;


-- 14. Вивести дані про клієнта, в якого середня сума кредитів найвища.

select c.*, avg(Sum) as avg
from client c
         join application a on c.idClient = a.Client_idClient
group by idClient
order by avg desc
limit 1;


-- 15. Вивести відділення, яке видало в кредити найбільше грошей

select d.DepartmentCity, sum(a.Sum) as SumCredits
from client c
         join application a on c.idClient = a.Client_idClient
         join department d on c.Department_idDepartment = d.idDepartment
group by d.idDepartment
order by SumCredits desc
limit 1;


-- 16. Вивести відділення, яке видало найбільший кредит.

select d.DepartmentCity, max(a.Sum)
from client c
         join application a on c.idClient = a.Client_idClient
         join department d on c.Department_idDepartment = d.idDepartment
group by d.idDepartment
limit 1;


-- 17. Усім клієнтам, які мають вищу освіту, встановити усі їхні кредити у розмірі 6000 грн.

select *
from client c
         join application a on c.idClient = a.Client_idClient
where Education = 'high';

update application a join client c on a.Client_idClient = c.idClient
set a.Sum = 6000
where c.Education = 'high';


-- 18. Усіх клієнтів київських відділень пересилити до Києва.

update client c join department d on c.Department_idDepartment = d.idDepartment
set c.City = 'Kyiv'
where d.idDepartment = 1;

select *
from client
         join department d on d.idDepartment = client.Department_idDepartment;


-- 19. Видалити усі кредити, які є повернені.

select *
from application;

delete
from application
where CreditState = 'Returned';


-- 20. Видалити кредити клієнтів, в яких друга літера прізвища є голосною.

delete application
from application
         join client c on c.idClient = application.Client_idClient
where LastName regexp '^.[eyuoa].*';

select *
from application;


-- 21.Знайти львівські відділення, які видали кредитів на загальну суму більше ніж 5000

select d.DepartmentCity, a.Sum
from client c
         join application a on c.idClient = a.Client_idClient
         join department d on d.idDepartment = c.Department_idDepartment
where d.DepartmentCity = 'lviv'
  and a.Sum > 5000;


-- 22.Знайти клієнтів, які повністю погасили кредити на суму більше ніж 5000

select c.FirstName, c.LastName, a.Sum, a.CreditState
from client c
         join application a on c.idClient = a.Client_idClient
where a.CreditState = 'Returned'
  and a.Sum > 5000;


-- 23.Знайти максимальний неповернений кредит.

select c.FirstName, c.LastName, a.Sum, a.CreditState
from client c
         join application a on c.idClient = a.Client_idClient
where a.CreditState = 'Not returned'
order by a.Sum desc
limit 1;


-- 24.Знайти клієнта, сума кредиту якого найменша

select c.FirstName, c.LastName, a.Sum, a.CreditState
from client c
         join application a on c.idClient = a.Client_idClient
order by a.Sum
limit 1;


-- 25.Знайти кредити, сума яких більша за середнє значення усіх кредитів

select *
from application
where (select avg(Sum) from application) > Sum;


-- 26. Знайти клієнтів, які є з того самого міста, що і клієнт, який взяв найбільшу кількість кредитів

select City from client where city = (select c.city from client c join application a on c.idClient = a.Client_idClient group by idClient order by count(idApplication) desc limit 1);


-- 27. Місто клієнта з найбільшою кількістю кредитів

select City
from client c
         join application a on c.idClient = a.Client_idClient
         join department d on c.Department_idDepartment = d.idDepartment
group by d.DepartmentCity;

select City
from client c
         join application a on c.idClient = a.Client_idClient
         join department d on c.Department_idDepartment = d.idDepartment group by idClient order by count(idApplication) desc;


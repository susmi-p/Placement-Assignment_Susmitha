create database sqlpractice;

use sqlpractice;

select * from city;

/*-------- 1st Question --------*/

select * from city where countrycode='USA'and population>100000;

/*-------- 2nd Question --------*/

select name,countrycode,population from city where countrycode='USA'and population>120000;

/* ------- 3rd Question --------*/

select * from city;

/*-------- 4th Question ----------*/

select * from city where ID=1661;

/*----------- 5th Question --------*/

select * from city where countrycode='JPN';

/*------------ 6th Question ------------*/

select name,countrycode from city where countrycode='JPN';

/*---------------- 7th Question---------------*/

select * from stationdata;

select city,state from stationdata;

/*-------------- 8th Question -------------*/

select city,id from stationdata WHERE id % 2 = 0;

/*---------------- 9th Question ----------*/

SELECT (COUNT(city)-COUNT(DISTINCT city)), city AS cityDifference
FROM stationdata
group by city;

/*--------------- 10th Question -----------*/

select city,length(city) as lencity
from stationdata
order by lencity ASC 
limit 1 ;

select city,length(city) as lencity
from stationdata
order by lencity desc
limit 1 ;

/*--------------- 11th Question ----------*/

select distinct(city) as discity 
from stationdata
where LEFT(city,1) in ('a','i','e','i','o','u'); 

/*--------------- 12th Question ----------*/

select distinct(city) as discity 
from stationdata
where right(city,1) in ('a','i','e','i','o','u'); 

/*--------------- 13th Question ----------*/

select distinct(city) as discity 
from stationdata
where LEFT(city,1) not in ('a','i','e','i','o','u'); 

/*--------------- 14th Question ----------*/

select distinct(city) as discity 
from stationdata
where RIGHT(city,1) not in ('a','i','e','i','o','u'); 

/*--------------- 15th Question ----------*/

SELECT distinct(city) as discity
FROM stationdata 
WHERE LEFT(city , 1) not IN ('a','e','i','o','u')
or RIGHT(city,1) not IN  ('a','e','i','o','u');

/*--------------- 16th Question ----------*/

SELECT distinct(city) as discity
FROM stationdata 
WHERE LEFT(city , 1) not IN ('a','e','i','o','u')
and RIGHT(city,1) not IN  ('a','e','i','o','u');

/*--------------- 17th Question ----------*/

create table Product (
product_id int primary key,
product_name varchar(30),
unit_price int
);

create table Sales(
seller_id int,
product_id int,
buyer_id int,
sale_date date,
quantity int,
price int,
foreign key(product_id) references Product(product_id)
); 

insert into Product values
(1,'S8',1000),
(2,'G4',800),
(3,'iphone',1400);

insert into Sales values
(1,1,1,'2019-01-21',2,2000),
(1,2,2,'2019-02-17',1,800),
(2,2,3,'2019-06-02',1,800),
(3,3,4,'2019-05-13',2,2800);


SELECT product_id, product_name
FROM Product
WHERE product_id NOT IN 
(SELECT product_id FROM Sales 
WHERE sale_date > '2019-03-31' OR  sale_date < '2019-01-01' );

select * from product;

select * from sales;

/*--------------- 18th Question ------------*/

create table Views (
article_id int,
author_id int,
viewer_id int,
view_date date
);

insert into views values
(1,3,5,'2019-08-01'),
(1,3,6,'2019-08-02'),
(2,7,7,'2019-08-01'),
(2,7,6,'2019-08-02'),
(4,7,1,'2019-07-22'),
(3,4,4,'2019-07-21'),
(3,4,4,'2019-07-21');

select * from Views;

select distinct(viewer_id) as id from Views 
where author_id = viewer_id
order by id asc ;

/*--------------- 19th Question ------------*/

create table Delivery_table
(
delivery_id int primary key,
customer_id int,
order_id date,
customer_pref_delivery_date date
);

insert into Delivery_table values
(1,1,'2019-08-01','2019-08-01'),
(2,5,'2019-08-02','2019-08-02') ,
(3,1,'2019-08-11','2019-08-11'),
(4,3,'2019-08-24','2019-08-26'),
(5,4,'2019-08-21','2019-08-22'),
(6,2,'2019-08-11','2019-08-13');

select * from Delivery_table;

select  round(100.00 * count(delivery_id) /sum(count(delivery_id)) over(),2) as immediate_percentage
from Delivery_table
where order_id=customer_pref_delivery_date
group by delivery_id
limit 1;

/*--------------- 20th Question ------------*/
create table Ads
(
ad_id int,
user_id int,
`action` enum('Clicked','Viewed','Ignored'),
primary key(ad_id,user_id)
);

insert into Ads values
(1,1,'Clicked'),
(2,2,'Clicked'),
(3,3,'Viewed'),
(5,5,'Ignored'),
(1,7,'Ignored'),
(2,7,'Viewed'),
(3,5,'Clicked'),
(1,4,'Viewed'),
(2,11,'Viewed'),
(1,2,'Clicked');

select * from Ads;

select
ad_id,ifnull(round(avg(case when action = "Clicked" then 1 when action = "Viewed" then 0 else null end)*100,2),0) as ctr
from Ads
group by ad_id
order by ctr desc,ad_id asc;

/*------------ 21 Question ---------------*/

create table Employee_table
(
employee_id int primary key,
team_id int
);

insert into Employee_table values
(1,8),
(2,8),
(3,8),
(4,7),
(5,9),
(6,9);

select e.employee_id, (select count(team_id) from Employee_table where e.team_id = team_id) as team_size
from Employee_table e;

/*--------------- 22 Question -----------------*/

create table Countries
(
country_id int,
country_name varchar(30),
primary key (country_id)
);

create table Weather
(
country_id int,
weather_state int,
`day` date,
primary key (country_id,day)
);

insert Countries values
(2,'USA'),
(3,'Australia'),
(7,'Peru'),
(5,'China'),
(8,'Morocco'),
(9,'Spain');

insert Weather values
(2,15,'2019-11-01'),
(2,12,'2019-10-28'),
(2,12,'2019-10-27'),
(3,-2,'2019-11-10'),
(3,0,'2019-11-11'),
(3,3,'2019-11-12'),
(5,16,'2019-11-07'),
(5,18,'2019-11-09'),
(5,21,'2019-11-23'),
(7,25,'2019-11-28'),
(7,22,'2019-12-01'),
(7,20,'2019-12-02'),
(8,25,'2019-11-05'),
(8,27,'2019-11-15'),
(8,31,'2019-11-25'),
(9,7,'2019-10-23'),
(9,3,'2019-12-23');

select * from Countries;

select * from Weather;

select country_name, case when avg(weather_state) <= 15 then "Cold"
                          when avg(weather_state) >= 25 then "Hot"
                          else "Warm" end as weather_type
from Countries inner join Weather
on Countries.country_id = Weather.country_id
where left(day, 7) = '2019-11'
group by country_name;

/*---------- 23 question ---------*/

create table Prices
(
product_id int,
start_date date,
end_date date,
price int,
primary key(product_id,start_date,end_date)
);

create table UnitsSold
(
product_id int,
purchase_date date,
units int
);

insert Prices values
(1,'2019-02-17','2019-02-28',5),
(1,'2019-03-01','2019-03-22',20),
(2,'2019-02-01','2019-02-20',15),
(2,'2019-02-21','2019-03-31',30);

insert UnitsSold values
(1,'2019-02-25',100),
(1,'2019-03-01',15),
(2,'2019-02-10',200),
(2,'2019-03-22',30);

select * from Prices;

select * from UnitsSold;

select b.product_id, 
round(sum(a.units * b.price) / sum(a.units), 2) as average_price 
from UnitsSold as a inner join Prices AS b 
	on a.product_id = b.product_id 
where  a.purchase_date between b.start_date and b.end_date 
group by product_id;


/*----------------- 24 Question ------------*/

create table Activity
(
player_id int,
device_id int,
event_date date,
games_played int,
primary key(player_id,event_date)
);

insert into Activity values
(1,2,'2016-03-01',5),
(1,2,'2016-05-02',6),
(2,3,'2017-06-25',1),
(3,1,'2016-03-02',0),
(3,4,'2018-07-03',5);

select * from Activity;

select player_id,min(event_date) as first_login
	from Activity
	GROUP BY
      player_id;

/*-------------- 25 Question ---------------*/

SELECT
  player_id,
  device_id
FROM
  Activity
WHERE (player_id, event_date) IN 
	(select player_id,min(event_date) as first_login
	from Activity
	GROUP BY
      player_id
	);

/*------------ 26 Question ----------*/

create table Product1
(
product_id int,
product_name varchar(30),
product_category varchar(30),
primary key(product_id)
);

create table Orders
(
product_id int,
order_date date,
unit int
);

insert Product1 values
(1,'Leetcode Solutions','Book'),
(2,'Jewels of Stringology','Book'),
(3,'HP','Laptop'),
(4,'Lenovo','Laptop'),
(5,'Leetcode Kit','T-shirt');

select * from product1;

insert Orders values
(1,'2020-02-05',60),
(1,'2020-02-10',70),
(2,'2020-01-18',30),
(2,'2020-02-11',80),
(3,'2020-02-17',2),
(3,'2020-02-24',3),
(4,'2020-03-01',20),
(4,'2020-03-04',30),
(4,'2020-03-04',60),
(5,'2020-02-25',50),
(5,'2020-02-27',50),
(5,'2020-03-01',50);

select a.product_name, sum(unit) as unit
from Product1 a
left join Orders b
on a.product_id = b.product_id
where b.order_date between '2020-02-01' and '2020-02-29'
group by a.product_id
having sum(unit) >= 100;

/*------------- 27th Question -----------------*/

create table Users 
(
user_id int,
name varchar(30),
mail varchar(100),
primary key(user_id)
);

insert Users values
(1,'Winston','winston@leetcode.com'),
(2,'Jonathan','jonathanisgreat'),
(3,'Annabelle','bella-@leetcode.com'),
(4,'Sally','sally.come@leetcode.com'),
(5,'Marwan','quarz#2020@leetcode.com'),
(6,'David','david69@gmail.com'),
(7,'Shapiro','.shapo@leetcode.com');

select user_id,`name`,mail from Users
where REGEXP_LIKE(mail, '^[a-zA-Z][a-zA-Z0-9\_\.\-]*@leetcode.com');

/*-------------- 28th Question ----------*/

create table Customers
(
customer_id int,
`name` varchar(30),
country varchar(30),
primary key(customer_id)
);

create table Products
(
product_id int,
`description` varchar(30),
price varchar(30),
primary key(product_id)
);

create table `Order`
(
order_id int,
customer_id int,
product_id int,
order_date date,
quantity int,
primary key(order_id)
);

insert Customers values
(1,'Winston','USA'),
(2,'Jonathan','Peru'),
(3,'Moustafa','Moustafa');

insert Products values
(10,'LC Phone',300),
(20,'LC T-Shirt',10),
(30,'LC Book',45),
(40,'LC Keychain',2);

insert `Order` values
(1,1,10,'2020-06-10',1),
(2,1,20,'2020-07-01',1),
(3,1,30,'2020-07-08',2),
(4,2,10,'2020-06-15',2),
(5,2,40,'2020-07-01',10),
(6,3,20,'2020-06-24',2),
(7,3,30,'2020-06-25',2),
(9,3,30,'2020-05-08',3);

select o.customer_id, c.name
from Customers c, Products p,`Order` o
where c.customer_id = o.customer_id and p.product_id = o.product_id
group by o.customer_id
having 
(
    sum(case when o.order_date like '2020-06%' then o.quantity*p.price else 0 end) >= 100
    and
    sum(case when o.order_date like '2020-07%' then o.quantity*p.price else 0 end) >= 100
);

/*------------- 29th Question ----------*/

create table TVProgram
(
program_date date,
content_id int,
channel varchar(30),
primary key(program_date,content_id)
);

create table Content
(
content_id varchar(30),
title varchar(30),
Kids_content enum('Y','N'),
content_type varchar(30),
primary key(content_id)
);

insert TVProgram values
('2020-06-10 08:00',1,'LC-Channel'),
('2020-05-11 12:00',2,'LC-Channel'),
('2020-05-12 12:00',3,'LC-Channel'),
('2020-05-13 14:00',4,'Disney Ch'),
('2020-06-18 14:00',4,'Disney Ch'),
('2020-07-15 16:00',5,'Disney Ch');

insert Content values
(1,'Leetcode Movie','N','Movies'),
(2,'Alg. for Kids','Y','Series'),
(3,'Database Sols','N','Series'),
(4,'Aladdin','Y','Movies'),
(5,'Cinderella','Y','Movies');

select * from TVProgram;

select * from Content;

select distinct title
from Content 
join TVProgram using(content_id)
where kids_content = 'Y' 
	and content_type = 'Movies' 
	and (month(program_date), year(program_date)) = (6, 2020);

/*------------ 30 Question ---------------*/

create table NPV
(
id int,
`year` int,
npv int,
primary key(id,`year`)
);

create table Queries
(
id int,
`year` int,
primary key(id,`year`)
);

insert NPV values
(1,'2018',100),
(7,'2020',30),
(13,'2019',40),
(1,'2019',113),
(2,'2008',121),
(3,'2009',12),
(11,'2020',99),
(7,'2019',0);

insert Queries values
(1,'2019'),
(2,'2008'),
(3,'2009'),
(7,'2018'),
(7,'2019'),
(7,'2020'),
(13,'2019');

select q.id, q.year, ifnull(n.npv,0) as npv
from queries as q
left join npv as n
on (q.id, q.year) = (n.id, n.year);

/*----------------- 31st Question ---------------*/

select q.id, q.year, ifnull(n.npv,0) as npv
from queries as q
left join npv as n
on (q.id, q.year) = (n.id, n.year);

/*------------ 32nd Question -------------*/

create table Employees
(
id int,
`name` varchar(30),
primary key(id)
);

create table EmployeeUNI
(
id int,
unique_id int,
primary key(id,unique_id)
);

insert Employees values
(1,'Alice'),
(7,'Bob'),
(11,'Meir'),
(90,'Winston'),
(3,'Jonathan');

insert EmployeeUNI values
(3,1),
(11,2),
(90,3);

select unique_id, name
from Employees
left join EmployeeUNI
on if (Employees.id = EmployeeUNI.id, Employees.id, null);


/*--------------- 33rd Question --------------*/

create table Users1
(
id int,
name1 varchar(30),
primary key(id)
);

create table Rides
(
id int,
user_id int,
distance int,
primary key(id)
);

insert Users1 values
(1,'Alice'),
(2,'Bob'),
(3,'Alex'),
(4,'Donald'),
(7,'Lee'),
(13,'Jonathan'),
(19,'Elvis');

insert Rides values
(1,1,120),
(2,2,317),
(3,3,222),
(4,7,100),
(5,13,312),
(6,19,50),
(7,7,120),
(8,19,400),
(9,7,230);

select Users1.name1, IFNULL(SUM(Rides.distance), 0) AS travelled_distance
from Users1 LEFT JOIN Rides
on Users1.id = Rides.user_id
group by name1
order by travelled_distance desc,
name1 asc;

select * from users1;

/*----------------- 34 Question --------------------*/

select a.product_name, sum(unit) as unit
from Product1 a
left join Orders b
on a.product_id = b.product_id
where b.order_date between '2020-02-01' and '2020-02-29'
group by a.product_id
having sum(unit) >= 100;

/*------------- 35th Question -------------------*/

create table Movies
(
movie_id int,
title varchar(30),
primary key(movie_id)
);

select * from Movies;

insert Movies values 
(1,'Avengers'),
(2,'Frozen 2'),
(3,'Joker');

create table Users2
(
user_id int,
name1 varchar(30),
primary key(user_id)
);

insert users2 values
(1,'Daniel'),
(2,'Monica'),
(3,'Maria'),
(4,'James');

select * from users1;

create table MovieRating
(
movie_id int,
user_id int,
rating int,
created_at date,
primary key(movie_id,created_at)
);

insert MovieRating values
(1,1,3,'2020-01-12'),
(1,2,4,'2020-02-11'),
(1,3,2,'2020-02-12'),
(1,4,1,'2020-01-01'),
(2,1,5,'2020-02-17'),
(2,2,2,'2020-02-01'),
(2,3,2,'2020-03-01'),
(3,1,3,'2020-02-22'),
(3,2,4,'2020-02-25');

SELECT user_name AS results FROM
(
SELECT a.name1 AS user_name, COUNT(*) AS counts FROM MovieRating AS b
    JOIN Users2 AS a
    on a.user_id = b.user_id
    GROUP BY b.user_id
    ORDER BY counts DESC, user_name ASC LIMIT 1
) first_query
UNION
SELECT movie_name AS results FROM
(
SELECT c.title AS movie_name, AVG(d.rating) AS rate FROM MovieRating AS d
    JOIN Movies AS c
    on c.movie_id = d.movie_id
    WHERE substr(d.created_at, 1, 7) = '2020-02'
    GROUP BY d.movie_id
    ORDER BY rate DESC, movie_name ASC LIMIT 1
) second_query;

/*----------------- 36th Quetion ----------------*/

select * from users1;

select * from rides;

select Users1.name1, IFNULL(SUM(Rides.distance), 0) AS travelled_distance
from Users1 LEFT JOIN Rides
on Users1.id = Rides.user_id
group by name1
order by travelled_distance desc,
name1 asc;

/*--------------- 37th Question ---------*/

select unique_id, name
from Employees
left join EmployeeUNI
on if (Employees.id = EmployeeUNI.id, Employees.id, null);

/*------------------ 38th Question --------------*/

create table Departments
(
id int,
name varchar(30),
primary key(id)
);

create table students
(
id int,
name varchar(30),
department_id int,
primary key(id)
);

insert departments values
(1,'Electrical Engineering'),
(7,'Computer Engineering'),
(13,'Business Administration');

insert Students values
(23,'Alice',1),
(1,'Bob',7),
(5,'Jennifer',13),
(2,'John',14),
(4,'Jasmine',77),
(3,'Steve',74),
(6,'Luis',1),
(8,'Jonathan',7),
(7,'Daiana',33),
(11,'Madelynn',1);

select id, name
from Students
where department_id not in (select id from Departments);

/*--------------- 39th Question ----------------*/

create table Calls
(
from_id int,
to_id int,
duration int
);

insert calls values
(1,2,59),
(2,1,11),
(1,3,20),
(3,4,100),
(3,4,200),
(3,4,200),
(4,3,499);

select from_id as person1,to_id as person2,
    count(duration) as call_count, sum(duration) as total_duration
from (select * 
      from Calls 
      union all
      select to_id, from_id, duration 
      from Calls) t1
where from_id < to_id
group by person1, person2;

/*------------------ 40th Question --------------*/

select b.product_id, 
round(sum(a.units * b.price) / sum(a.units), 2) as average_price 
from UnitsSold as a inner join Prices AS b 
	on a.product_id = b.product_id 
where  a.purchase_date between b.start_date and b.end_date 
group by product_id;

/*----------------- 41st Question -----------------*/

create table warehouse 
(
name varchar(30),
product_id int,
units int,
primary key(name, product_id)
);

create table products2
(
product_id int,
product_name varchar(30),
width int,
length int,
height int,
primary key(product_id)
);

insert warehouse values
('LCHouse1',1,1),
('LCHouse1',2,10),
('LCHouse1',3,5),
('LCHouse2',1,2),
('LCHouse2',2,2),
('LCHouse3',4,1);

insert products2 values
(1,'LC-TV',5,50,40),
(2,'LC-KeyChain',5,5,5),
(3,'LC-Phone',2,10,10),
(4,'LC-T-Shirt',4,10,20);
 
select * from products2;

select name as warehouse_name, sum(units * vol) as volume
from Warehouse w
join (select product_id, Width*Length*Height as vol
     from Products2) p
on w.product_id = p.product_id
group by name;

/*------------------- 42nd Question --------------*/

create table sales1
(
sales_date date,
fruit enum('apples','oranges'),
sold_num int,
primary key(sales_date,fruit)
);

insert sales1 values
('2020-05-01','apples',10),
('2020-05-01','oranges',8),
('2020-05-02','apples',15),
('2020-05-02','oranges',15),
('2020-05-03','apples',20),
('2020-05-03','oranges',0),
('2020-05-04','apples',15),
('2020-05-04','oranges',16);

select * from  sales1;

select s.sales_date,
    sum(if(s.fruit = 'apples', s.sold_num, -s.sold_num)) as diff
from Sales1 s
group by s.sales_date;

/*--------------- 43rd Question -------------------*/

select * from activity;

select 
    player_id,
    min(event_date) as first_login 
from activity 
group by player_id;

/*---------------- 44th Question -----------------*/

create table employee
(
id int,
name varchar(30),
department varchar(30),
managerId int,
primary key(id)
);

insert employee values
(101,'John','A',Null),
(102,'Dan','A',101),
(103,'James','A',101),
(104,'Amy','A',101),
(105,'Anne','A',101),
(106,'Ron','B',101);

select * from employee;

SELECT m.name 
FROM Employee e JOIN Employee m ON e.managerId = m.id
GROUP BY m.name
HAVING COUNT(e.id) >= 5;

/*------------------ 46th Question -----------------*/

create table Customer
(
customer_id int,
product_key int
);

create table  product2
(product_key int,
primary key(product_key)
);

insert customer values
(1,5),
(2,6),
(3,5),
(3,6),
(1,6);

insert Product2 values
(5),
(6);

select a.customer_id from
(select customer_id, count(distinct product_key) as num
from Customer
group by customer_id) a
where a.num = (select count(distinct product_key) from Product2);

/*--------------- 47th Question ---------------------*/

create table Project
(
project_id int,
employee_id int,
primary key(project_id,employee_id)
);

create table employee1
(
employee_id int,
name varchar(30),
experience_years int,
primary key(employee_id)
);

insert project values
(1,1),
(1,2),
(1,3),
(2,1),
(2,4);

insert Employee1 values
(1,'Khaled',3),
(2,'Ali',2),
(3,'John',3),
(4,'Doe',2);


select project_id, employee_id
from Project
join Employee1
using (employee_id)
where (project_id, experience_years) in (
    select project_id, max(experience_years)
    from Project
    join Employee1
    using (employee_id)
    group by project_id);
    
/*--------------- 48th Question ----------------*/

create table Books
(
book_id int,
name varchar(30),
available_from date,
primary key(book_id)
);

create table Orders1
(
order_id int,
book_id int,
quantity int,
dispatch_date date,
primary key(order_id)
);

insert books values
(1,'Kalila And Demna','2010-01-01'),
(2,"28 Letters",'2012-05-12'),
(3,"The Hobbit",'2019-06-10'),
(4,"13 Reasons Why",'2019-06-01'),
(5,"The Hunger Games",'2008-09-21');

insert orders1 values
(1,1,2,'2018-07-26'),
(2,1,1,'2018-11-05'),
(3,3,8,'2019-06-11'),
(4,4,6,'2019-06-05'),
(5,4,5,'2019-06-20'),
(6,5,9,'2009-02-02'),
(7,5,8,'2010-04-13');

SELECT b.book_id, 
       b.NAME 
FROM   books AS b 
       LEFT JOIN orders1 AS o 
              ON b.book_id = o.book_id 
                 AND dispatch_date BETWEEN '2018-06-23' AND '2019-6-23' 
WHERE  Datediff('2019-06-23', b.available_from) > 30 
GROUP BY book_id 
HAVING Sum(IFNULL(o.quantity, 0)) < 10 ORDER  BY NULL ;

/*------------------ 49th Question ------------------------*/

create table Enrollments 
(
student_id int,
course_id int,
grade int,
primary key(student_id,course_id)
);

insert enrollments values
(2,2,95),
(2,3,95),
(1,1,90),
(1,2,99),
(3,1,80),
(3,2,75),
(3,3,82);

SELECT e.student_id, min(e.course_id) course_id, e.grade
FROM enrollments e
JOIN (
    SELECT student_id, max(grade) grade
    FROM enrollments
    GROUP BY student_id) g USING (student_id, grade)
GROUP BY e.student_Id;

/*-------------- 50th Question --------------------*/

create table Players
(
player_id int,
group_id int,
primary key(player_id)
);

create table matches
(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int
);

insert players values
(15,1),
(25,1),
(30,1),
(45,1),
(10,2),
(35,2),
(50,2),
(20,3),
(40,3);

insert matches values
(1,15,45,3,0),
(2,30,25,1,2),
(3,30,15,2,0),
(4,40,20,5,2),
(5,35,50,1,1);

select group_id,player_id 
from (
    select sc.group_id group_id, sc.player_id player_id, 
       rank() over (partition by sc.group_id order by sum(sc.score) desc, sc.player_id asc) as rnk 
    from(
        select p.group_id group_id,
         p.player_id player_id ,
         sum(m.first_score) as score
        from players p
        inner join matches m
        on p.player_id = m.first_player
        group by p.group_id,p.player_id
        
        union all
        
        select p.group_id group_id,
         p.player_id player_id ,
        sum(second_score) as score
        from players p
        inner join matches m
        on p.player_id = m.second_player
        group by p.group_id,p.player_id
    ) sc
    group by sc.group_id,sc.player_id
) A 
where rnk = 1;












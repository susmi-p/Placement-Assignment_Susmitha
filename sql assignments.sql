use susmitha;
/*--------first question---------*/
create table linkedIN(
Id int,
Technology varchar(30)
);

insert into linkedIn values
(1,'DS'),
(1,'Tableau'),
(2,'PowerBI'),
(1,'SQL'),
(1,'Python'),
(2,'R');

select * from linkedIn;
select id from linkedIn where technology in ('PowerBI','SQL','Python');
select id from linkedIn where technology='Python' and technology='SQL' and technology='R';
select technology from linkedin;
select id from linkedin where technology in ('Python','SQL','R') group by id;

SELECT id
FROM linkedin
WHERE technology = 'DS'
AND id IN (
    SELECT id
    FROM linkedin
    WHERE technology = 'Tableau'
    AND id IN (
        SELECT id
        FROM linkedin
        WHERE technology = 'Python'
    And id IN (
		SELECT id
        FROM linkedin
        WHERE technology='SQL'
        )
    )
);
create table product_info(
product_id int,
product_name varchar(30)
);

/*---------second question ans--------------*/

insert into product_info values
(1001,'Blog'),
(1002,'Youtube'),
(1003,'Education');

create table product_info_likes(
User_id int,
product_id int,
liked_date date
);

insert into product_info_likes values
(1,1001,'2023/08/19'),
(2,1003,'2023/08/18');

select t.product_id from product_info_likes l 
right join product_info t 
on l.product_id=t.product_id
where liked_date is null;

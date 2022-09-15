--task1  (lesson8)
-- oracle: https://leetcode.com/problems/department-top-three-salaries/
select Department,employee,salary from (
select (select name from Department where id=departmentid) as Department, 
name as employee,salary,
dense_rank() over(partition by departmentid order by salary desc ) drnk 
from Employee ) aa 
where drnk<=3
--task2  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/17
select member_name,status,sum(amount*unit_price) as costs from familymembers family_member 
left join payments p on member_id =family_member 
where year(date)='2005'
group by member_name,status

--task3  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/13
select distinct name from Passenger p WHERE 
exists (select * from Passenger p2
where p2.name=p.name and p.id<>p2.id)
--task4  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38
select count(*) as count from Student 
where first_name ='Anna'
--task5  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/35
select count(c.id) as count from Class c 
left join Schedule s on c.id=s.class 
where date='2019-09-02'
--task6  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38

--task7  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/32
select floor(avg(case when 
month(birthday)-month(current_date)>0 or 
(month(birthday)-month(current_date)=0
and day(birthday)-day(current_date)>=0 ) 
then year(current_date)-year(birthday)-1  else 
year(current_date)-year(birthday)  end)) as age
from FamilyMembers
--task8  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/27
select good_type_name,sum(amount*unit_price) as costs from Payments p
left join goods g on g.good_id=p.good
left join goodtypes gt on gt.good_type_id=g.type
where year(p.date)='2005'
group by good_type_name
--task9  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/37
select min(case when 
month(birthday)-month(current_date)>0 OR (
month(birthday)-month(current_date)=0 and 
day(birthday)-day(current_date)>=0  )
then year(current_date)-year(birthday)-1  else 
year(current_date)-year(birthday)  end) as year
 from Student
--task10  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/44
select max(case when 
month(birthday)-month(current_date)>0 OR (
month(birthday)-month(current_date)=0 and 
day(birthday)-day(current_date)>=0  )
then year(current_date)-year(birthday)-1  else 
year(current_date)-year(birthday)  end) as max_year
 from Student s
 left join Student_in_class sic on s.id=sic.student
 left join class c on c.id=sic.class
 where c.name like '10%'
--task11 (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/20
select status,member_name,sum(unit_price*amount) as costs
from FamilyMembers f
left join payments p on p.family_member=f.member_id 
left join goods g on p.good=g.good_id 
left join GoodTypes gt on gt.good_type_id=g.type 
where good_type_name='entertainment'
group by status,member_name
--task12  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/55
delete from company where name in (
select name from  (
select name,dense_rank() over (order by count) rnk from 
(
select name, count(*) as count  from company c 
left join trip t on c.id=t.company 
group by name) aa) bb where rnk=1)
--task13  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/45
select classroom from (
select classroom,rank() over (order by count desc) rnk from
(select classroom,count(*) as count from Schedule 
group by classroom 
order by count desc) aa) bb where rnk=1
--task14  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/43
select last_name from Teacher t 
left join Schedule s on t.id=s.teacher 
left join Subject su on su.id=s.subject 
where su.name='Physical Culture'
order by last_name
--task15  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/63
select CONCAT(last_name,'.',
SUBSTRING(first_name,1,1),'.',
SUBSTRING(middle_name,1,1),'.')   as name
from Student
order by name

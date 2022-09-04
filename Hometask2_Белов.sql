--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--Корабли: Для каждого класса определите число кораблей этого класса, потопленных в сражениях. Вывести: класс и число потопленных кораблей.
select c.class,count(*) from classes c
left join ships s on s.class=c.class
left join outcomes o on o.ship =c.class and o.result='sunk'
left join outcomes o2 on o2.ship =s.name and o2.result='sunk'
where o.result='sunk' or o2.result='sunk'
group by  c.class

--task2
--Корабли: Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. Вывести: класс, год.
select distinct s.class,(select min(ss.launched) 
from ships ss 
where  ss.class=s.class) 
from ships s
order by s.class

--select * from classes s2 
--task3
--Корабли: Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, вывести имя класса и число потопленных кораблей.
with ship3 as (select c.class,count(*) from classes c
left join ships s on s.class=c.class 
group by c.class
having count(*) >=3
)
select c.class,count(*) from ship3 c
left join ships s on s.class=c.class
left join outcomes o on o.ship =c.class and o.result='sunk'
left join outcomes o2 on o2.ship =s.name and o2.result='sunk'
where o.result='sunk' or o2.result='sunk'
group by  c.class

--task4
--Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди всех кораблей такого же водоизмещения (учесть корабли из таблицы Outcomes).
with sss as (select name,s.class,displacement,numguns from ships s
join classes c on s.class=c.class
union all
select o.ship,c.class,c.displacement,c.numguns from outcomes o
join ships s on s.name=o.ship
join classes c on c.class=o.ship
union all
select c.class,c.class,c.displacement,c.numguns  from classes c
where not exists (select * from ships s where c.class=s.class)
)
select distinct sss.name,sss.displacement /*,sss.class,sss.displacement,numguns*/ from sss
where sss.numguns = (select max(s.numguns) from sss s where s.displacement=sss.displacement )
order by sss.displacement

--task5
--Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker
select maker/*,pc.model,ram,speed*/ from pc
join product p on pc.model=p.model
where pc.ram=(select min(ram) from pc) and
pc.speed=(select max(pc2.speed) from pc pc2 where pc2.ram=pc.ram)

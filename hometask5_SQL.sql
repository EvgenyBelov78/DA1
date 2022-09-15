--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson7)
-- sqlite3: Сделать тестовый проект с БД (sqlite3, project name: task1_7). В таблицу table1 записать 1000 строк с случайными значениями (3 колонки, тип int) от 0 до 1000.
-- Далее построить гистаграмму распределения этих трех колонко

--task2  (lesson7)
-- oracle: https://leetcode.com/problems/duplicate-emails/
/*select distinct p.email from person p
where exists (select * from person p2 where p2.id<>p.id and p2.email=p.email)*/
--или
select email from person 
group by email 
having count(*)>1

--task3  (lesson7)
-- oracle: https://leetcode.com/problems/employees-earning-more-than-their-managers/
select  e.name as "employee" from employee  e
left join employee e2 on e.managerid=e2.id
where e.salary>e2.salary

--task4  (lesson7)
-- oracle: https://leetcode.com/problems/rank-scores/
select score,dense_rank() over(order by score desc) rank from scores

--task5  (lesson7)
-- oracle: https://leetcode.com/problems/combine-two-tables/
select lastname,firstname,city,state from person p
left join address a on a.personid=p.personid
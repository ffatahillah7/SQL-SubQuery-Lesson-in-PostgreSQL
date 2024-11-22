---SUBQUERY ON POSTGRESQL WITH CASE STUDY-----------------------

----Preparing Supporting Table------------------------

create table manager_position (
	manager_id SERIAL primary key,
	position varchar(4),
	manager_name varchar (50),
	country varchar(30)
	)
	
Insert into manager_position (position,manager_name,country) values 
('PF','Andrew Sheva','Russia'),
('C','Tom Haye','England'),
('SF','Kevin Diks','Netherland'),
('SG','Jay Idzes','Italia'),
('PG','Sandy Walsh','Indonesia')

select * from manager_position mp 


----Material Start-----------

---Scalar Subquery ---
-----Select Player with above average salary---------------------------
-----The Subquery result on Where clause is single value------------------

select ndp."Name", ndp."Team", ndp."Position" ,ndp."Salary" 
from "nba_Detroit_Pistons" ndp 
where ndp."Salary" > (select AVG("Salary") from "nba_Detroit_Pistons")

------------------------------------------------------------------------

----Single-Row Subquery-------------------------------------------------
-------Select data where manager_name is Kevin Diks---------------------
-------The Subquery result on where clause is single row----------------

select * from "nba_New_Orleans_Pelicans" nnop 
where nnop."Position" = 
(select position from manager_position where manager_name = 'Kevin Diks')

-------------------------------------------------------------------------

----Multiple-Row Subquery------------------------------------------------
-----Select Data where manager name is not Kevin Diks and Tom Haye-------
-------The Subquery result on where clause is multiple rows----------------

select * from "nba_Portland_Trail_Blazers" nptb
where nptb."Position" in 
(select distinct position from manager_position mp
where manager_name not in('Kevin Diks,','Tom Haye')
)

------------------------------------------------------------------------

----Correlated Subquery like self join----------------------------------
------Depend on Main Query----------------------------------------------
------Retrieved data where salary is above average salary----------------
------Avergae salary is from each position-------------------------------

select * from "nba_Portland_Trail_Blazers" nptb
where nptb."Salary" > (select avg("Salary")
	from "nba_Portland_Trail_Blazers" where "Position" = nptb."Position")
					
-----------------Check Average from each Position-----------------------
select nptb."Position" , avg(nptb."Salary") 
from "nba_Portland_Trail_Blazers" nptb 
group by nptb."Position" 

--------------------------------------------------------------------------

----Nested Subquery (Subquery in Subquery)---------------------------------

select ndp."Name",ndp."Position",ndp."Age" ,ndp."Salary" 
from "nba_Detroit_Pistons" ndp 
where ndp."Salary" > (select avg("Salary") 
	from (select * from "nba_Detroit_Pistons" where "Position" = 'C') as s)

--------------------------------------------------------------------------
	
---Subquery with From Clause---------------------------------------------
	
select "Name","Team","Position","Salary"
from (select * from "nba_New_Orleans_Pelicans"
where "Salary" > 3000000)

-------------------------------------------------------------------------


create database lesson6_homework



--------- 1ST PUZZLE

SELECT *
FROM INPUTTBL


SELECT 
    CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
    CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl
GROUP BY 
    CASE WHEN col1 < col2 THEN col1 ELSE col2 END,
    CASE WHEN col1 < col2 THEN col2 ELSE col1 END;


------------------ 2ND PUZZLE

select *
from testduplicatecount


select EmpName, count(empname) as Appearences
from testduplicatecount
group by EmpName
having count(empname)>1


select EmpName, Appearences 
from (
	select EmpName, count(empname) as Appearences
	from testduplicatecount
	group by EmpName) as base_table
where Appearences > 1

 

--------------------- 3RD PUZZLE
select *
from groupbymultiplecolumns



select typ, 
	count(case
	when value1 = 'a' then 1
	when value2 = 'a' then 1
	when value3 = 'a' then 1
	end) as number
from groupbymultiplecolumns
group by typ

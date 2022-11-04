-- Query 1
-- Employee data with Duplicate Employees based on Title

SELECT emp.emp_no, emp.first_name, emp.last_name,
	   ttl.title, ttl.from_date, ttl.to_date
INTO retirement_titles
FROM employees emp 
LEFT JOIN titles ttl
ON emp.emp_no = ttl.emp_no
WHERE emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp.emp_no;

--Query 2
--Unique Titles using DISTINCT argument
SELECT tbl_1.emp_no, tbl_1.first_name, tbl_1.last_name, tbl_1.title 
INTO unique_titles
FROM
(
SELECT DISTINCT ON (emp_no) *
FROM retirement_titles
ORDER BY emp_no, from_date DESC
) tbl_1
WHERE tbl_1.to_date = '9999-01-01'
ORDER BY tbl_1.emp_no, tbl_1.to_date DESC;

--Query 3
--Retiring Titles
SELECT COUNT(emp_no) as _count, title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY _count desc;

--Query 4
--Mentorship Eligibility Query
SELECT em.emp_no, em.first_name, em.last_name, em.birth_date,
		dm.from_date, dm.to_date,
		tt.title
INTO mentorship_eligibility
FROM employees em
LEFT JOIN dept_emp dm ON em.emp_no = dm.emp_no
LEFT JOIN titles tt on em.emp_no = tt.emp_no
INNER JOIN 
	(
		SELECT emp_no, MAX(from_date) AS mdate
		FROM titles
		GROUP BY emp_no
	) tt2 on tt.emp_no = tt2.emp_no and tt.from_date = tt2.mdate
WHERE em.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
AND dm.to_date ='9999-01-01'
ORDER BY em.emp_no;



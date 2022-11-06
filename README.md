# Pewlett Hackard Retirement Analysis

## Overview of Analysis
The human resources department anticipates that it will have a wave of its current employees retire over the next few years and is interested in understanding that specific demographic in order to prepare for succession planning and backfilling.  They have asked us to utilize available employee demographic data and departmental information to answer some specific questions:

1. How many employees will be retiring in the near future?
2. Of that retiree pool, how many are eligible for a retirement package?

## Results
We generated four queries that generated various data:
1. Query 1 generated a list of all employees in the database born betwen 1952 and 1955.  This included employees that might no longer be with the company and duplicate records where the employee had multiple titles during his or her tenure.
2. Query 2 refined that list to remove ex-employees and, for employees that had multiple titles, leave only the most recent title record.
3. Query 3 summarized Query 2 by title and count of retiring employees with that current title.
4. Query 4 generated a list of current employees that were approximately 10 years from retirement (whose birthdates were 10 years earlier than those in Queries 1 through 3).

It wasn't clear what exactly the mentorship program would be but my assumption for the rest of this analysis is that we would want to look to those near retirement to mentor that next group behind them in order to retain a level of leadership immediately after the retirees leave, but also to start thinking about how this next wave of retirees (those born in the 1960's) would be backfilled as well.

Some key takeaways from this first set of analysis:

![Image 1](/Resources/Image1_1.png)

- There are 72,458 current employees that would likely retire in the very near future (those born in the 50s).  Assuming even distribution of retirements across a three-year period, this is still a significant burden on HR to process and onboard approximately 24,000 employees per year.

![Image 2](/Resources/Image1_2.png)

- There are only 1,549 currently employees eligible for the mentorship program (those born in the 60s).

![Image 3](/Resources/Image1_3.png)

- Breaking down the near-term retiree pool by title, we see that 50,842 retirees have a "Senior" title.  This implies these individuals have significant experience in their fields and it might not be as easy to backfill internally without significant development.
- The remaining 21,616 employees in the upcoming retirement wave have lower titles.  These positions might be easier to backfill.  FOr example, "Staff" could imply administrative assistants or other support roles that are more easily filled by temporary or contractors.  This could be a short-term solution: utilize a staffing agency to backfill the positions and effectively outsource the HR while having internal staff focus on filling the core "Senior" roles.

## Summary

For the next round of analysis I wanted to look into some more details around specific departments that might have more issues with the retiree wave, as well as looking at what the talent pipeline looked like that would be available to potentially develop.  The thought is that, rather than try to backfill the senior roles, develop current employees and backfill at a lower level.

I used the following SQL to build a table that contained a list of current employees, birth dates, current title, current department, and current salary:
```
SELECT em.emp_no, em.first_name, em.last_name, em.birth_date,
	   tt.title AS current_title, 
	   dp.dept_name AS current_dept,
	   sl.salary AS current_salary
INTO employee_bday_title_dept_salary
FROM employees em 
LEFT JOIN 
	(SELECT a.* FROM titles a INNER JOIN 
		(
			SELECT emp_no, MAX(from_date) AS mdate
			FROM titles 
			GROUP BY emp_no
		) b on a.emp_no = b.emp_no and a.from_date = b.mdate
	) tt 
	ON em.emp_no = tt.emp_no
INNER JOIN dept_emp dm ON em.emp_no = dm.emp_no
LEFT JOIN departments dp ON dm.dept_no = dp.dept_no
LEFT JOIN salaries sl ON em.emp_no = sl.emp_no
WHERE dm.to_date = '9999-01-01'
ORDER BY em.emp_no;
```
This built the table "employee_bday_title_dept_salary" that I will be using for subsequent analysis.

I used the below to look at the waves of upcoming employees in two- to three-year buckets, based on birth year, in order to sort of visualize the wave as it is coming.  I then calculated the percentage of those born in '52 to '56 relative to the total population of the title to see if one group was losing more of their overall staff as others and if they would be hit hard in the next wave of retirement after that.

```
SELECT 	tb.*,
		TO_CHAR(CAST(tb.retiree_52_56 AS FLOAT) / CAST(tb.total_emp AS FLOAT)*100, '999D9%') AS pct_retiring
FROM
(
SELECT current_title,
	COUNT(CASE WHEN (birth_date BETWEEN '1952-01-01' AND '1956-12-31') THEN emp_no END) AS retiree_52_56,
	COUNT(CASE WHEN (birth_date BETWEEN '1957-01-01' AND '1959-12-31') THEN emp_no END) AS wave_57_59,
	COUNT(CASE WHEN (birth_date BETWEEN '1960-01-01' AND '1962-12-31') THEN emp_no END) AS wave_60_62,
	COUNT(CASE WHEN (birth_date BETWEEN '1963-01-01' AND '1965-12-31') THEN emp_no END) AS wave_63_65,
	COUNT(emp_no) AS total_emp
FROM employee_bday_title_dept_salary
GROUP BY current_title
) tb;
```

And we get these results:

![Image 4](/Resources/Image2_1.PNG)

A couple interesting takeaways:
- The "silver tsunami" appears to impact all titles equally.  I was expecting to maybe see that one specific title or group would be more impacted, which might imply that the HR team could focus on one specific type of role.  
- Almost 2/5 of each title is retiring in the next 4 years.
- In all cases, the four-year bucket of soonest retirees exceeds subsequent four-year buckets following it, indeed confirming this is a "tsunami" and that the number of retirees in following years will be lower (assuming any backfilling happens on the low end).  HR can consider temporarily staffing up its recruiting team and should focus on bringing on younger workers to avoid having to backfill more retirees sooner.



-- CREATING A TABLE FOR THE RETIRING EMPLOYEES BY TITLE
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO emp_retirement_title
FROM employees AS e
LEFT JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM emp_retirement_title
ORDER BY emp_no, to_date DESC;

-- RETRIEVE THE # OF TITLES OF THE EMPLOYEES THAT ARE RETIRING
SELECT COUNT(u.title), title
INTO retiring_titles
FROM unique_titles AS u
GROUP BY title
ORDER BY COUNT(title) DESC;

SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees AS e
LEFT JOIN dept_empl AS de
ON (e.emp_no = de.emp_no)
LEFT JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

-- ADDITIONAL QUERIES
SELECT e.emp_no,
	de.dept_no,
	d.dept_name
INTO emp_retiring_dept
FROM employees AS e
LEFT JOIN dept_empl as de
ON (e.emp_no = de.emp_no)
LEFT JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT COUNT(erd.emp_no) emp_no,
	dept_name
INTO retiring_dept
FROM emp_retiring_dept AS erd
GROUP BY dept_name
ORDER BY COUNT(emp_no) DESC;

SELECT COUNT(me.emp_no),
	title
FROM mentorship_eligibility AS me
GROUP BY title
ORDER BY COUNT(emp_no) DESC;
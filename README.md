# Pewlett-Hackard-Analysis
Overview:
Bobby from Pewlett-Hackard would like for us to set up a database where we can import and house employee and department data. Bobby would like for us to calculate the number of employees by the title that can be anticipated to be retiring soon. The company is considering starting up a mentorship program where employees that are going to retire soon can move to a part-time position and mentor newer employees for their future with the company.

Purpose of the project
Retiring Employees by Title query will show the titles of all employees born between January 1 1952 and December 31, 1955. The first query retrieved the emp_no, first_name, and last_name columns from the "employees" table and the title,from_date, and to_date columns from the "titles" table. By using the primary key (employee number) and filtering the data by birth_date, we were able to put the information into a new table. The table called "unique_titles" was created to hold the first occurrence of the emp_no by using the DISTINCT ON function. To achieve the count, the function ORDER BY COUNT was used to show the total number of each title from the unique_titles table. For mentorship eligibility, a query was created using columns from the "employees" and "dept_emp" table, it was then filtered on current employees born in 1965 then ordered by emp_no.

Results 
By running the queries, we create multiple lists of data for the managers. 
People who are eligible for retirement: Retirement Titles CSV.
Tally of all the titles for those eligible for retirement: Retiring Titles.
A list used to narrow the results down to the most recent title for each retiree: Unique Titles.
The list of current employees eligible for the mentorship program: Mentorship Eligibility.

By using these lists, management should be able to make the appropriate decisions to limit the impact of the pending "silver tsunami" of retirees. Something the company may want to consider looking into is a comparison of the retiree salaries vs the current employee salaries. This would help underscore the potential positive impact of the retiring workforce on the bottom line. Additionally, it might be worthwhile to examine the employee-to-manager ratio to make sure that no department is understaffed or has an abundance of management. It could lead to a restructuring that has the potential to improve both working conditions and output.

Summary:
Pewlett-Hackard has a total of 300,024 total employees. Of these employees, 90,398 are due for retirement. This is about a third of its entire workforce. Only 1549 employees are eligible for the mentorship program. 

--DATA ENGINEERING
drop table departments;
drop table titles;
drop table employee;
drop table dep_manager;
drop table dep_emp;
drop table salaries;


create table departments (
	dept_no varchar (10) not null ,
	dept_name Varchar (50) not null,
	primary key (dept_no)
);
select * from departments limit 10; 

create table titles (
	title_id varchar not null,
	title varchar (20) not null,
	primary key (title_id) 
	);

select * from titles;

create table employee (
	emp_no int not null,
	emp_title_id Varchar not null ,
	birth_date varchar (15) not null ,
	first_name Varchar (50) not null ,
	last_name Varchar (50) not null ,
	sex Varchar (10) not null ,
	hire_date date not null,
	Primary key (emp_no),
	foreign key (emp_title_id) references titles(title_id)
);

select * from employee limit(10);

create table dep_manager (
	dep_no varchar (10) not null ,
	emp_no int not null,
	foreign key (dep_no) references departments(dept_no),
	foreign key (emp_no) references employee(emp_no)
);

select * from dep_manager;

create table dep_emp (
	emp_no int not null, 
	dep_no varchar (10) not null,
	foreign key (emp_no) references employee(emp_no),
	foreign key (dep_no) references departments(dept_no)
	);

select * from dep_emp limit 10;
--

create table salaries (
	emp_no int not null,
	salary int not null,
	foreign key (emp_no) references employee(emp_no)
	);
	
select* from salaries;	
	
-- DATA ANALYSIS

--1.List the following details of each employee: employee number, last name, first name, sex, and salary.

select employee.emp_no, employee.last_name, employee.first_name, employee.sex, salaries.salary
from employee
inner join salaries on 
employee.emp_no=salaries.emp_no;


--2.List first name, last name, and hire date for employees who were hired in 1986

select employee.first_name, employee.last_name, employee.hire_date
from employee
where hire_date >= '01/01/1986'
and hire_date <'01/01/1987'
;

--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

select departments.dept_no, departments.dept_name, dep_manager.emp_no, employee.first_name, employee.last_name
from dep_manager
inner join departments on
dep_manager.dep_no=departments.dept_no
inner join employee on 
dep_manager.emp_no=employee.emp_no;

	
--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
select employee.emp_no, employee.last_name, employee.first_name, departments.dept_name
from dep_emp
inner join departments on 
dep_emp.dep_no=departments.dept_no
inner join employee on
dep_emp.emp_no=employee.emp_no;

--5.List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select employee.first_name, employee.last_name, employee.sex
from employee
where first_name='Hercules'
and last_name like 'B%';

--6.List all employees in the Sales department, including their employee number, last name, first name, and department name.
select employee.emp_no, employee.last_name, employee.first_name, departments.dept_name
from dep_emp
inner join departments on 
dep_emp.dep_no=departments.dept_no
inner join employee on
dep_emp.emp_no=employee.emp_no
where dept_name='Sales';

--7.List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

select employee.emp_no, employee.last_name, employee.first_name, departments.dept_name
from dep_emp
inner join departments on 
dep_emp.dep_no=departments.dept_no
inner join employee on
dep_emp.emp_no=employee.emp_no
where dept_name='Sales' or dept_name='Development';

--8.In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select last_name, count(last_name) from employee
group by last_name
order by count(last_name) desc;

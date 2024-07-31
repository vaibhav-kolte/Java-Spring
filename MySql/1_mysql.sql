Create database myDB;

use myDB;

drop database myDB;

show tables;

alter database myDB read only = 1;
-- allow read only mode set to 1

alter database myDB read only = 0;
-- allow editable mode set to 0 


create table employees(
	employee_id INT,
    first_name VARCHAR(50),
    last_name varchar(50),	
    hourly_pay decimal(5,2),
    hire_date date
);

select * from employees;

rename table workers to employees;

alter table employees
add phone_number varchar(15);

alter table employees
rename column phone_number to email;

alter table employees
modify column email varchar(100);


alter table employees
modify column email varchar(100)
after last_name;

alter table employees
modify column email varchar(100)
first;


alter table employees
drop column hourly_pay;

select * from employees;

alter table employees
modify column hourly_pay decimal(5,2)
after last_name;


insert into employees
values (1, "Vaibhav", "Kolte",3.43,"2022-09-05")

insert into employees
values (2,"Pankaj","Patil",12.32,"2016-08-23"),
	(3,"Sharad","Patil",34.90,"2022-12-23"),
	(4,"Sagar","Patel",23,"2021-11-21");
    
insert into employees(employee_id, first_name, last_name)
values(5,"Ganesh","Naik");


select first_name, last_name from employees;

select * from employees where employee_id = 1;

select * from employees where last_name = "patil";

select * from employeeshourly_pay where hourly_pay > 20;

select * from employees where hire_date > "2022-01-01";

select * from employees where hire_date is null;

update employees
set hourly_pay = 17.60
where employee_id = 1;


update employees
set hourly_pay = 17.60,
	hire_date = "2022-01-01"
where employee_id = 5;


-- Disable Safe Updates
SET SQL_SAFE_UPDATES = 0;

-- re-enable Safe Updates
SET SQL_SAFE_UPDATES = 1;

delete from employees where employee_id = 5;

set autocommit = off;

delete from employees;

rollback;

commit;
-- ----------------------------------------------------------------------------

create table test(
	my_date date,
	my_time time,
	my_datetime datetime
);


select * from test;

insert into test values(current_date(), current_time(), now());

insert into test values(current_date() + 1, null, null);

drop table test;

-- ----------------------------------------------------------------------

create table products(
	product_id int,
    product_name varchar(25) unique,
    price decimal(4,2)
);

alter table products
add constraint unique(product_name);

select * from products;

insert into products
values (100,"Vada pav", 15),
	(101,"Kachori",20),
    (102,"Pani puri",30);

insert into products values(103, "Pani puri", 20);
-- getting error -> Error Code: 1062. Duplicate entry 'Pani puri' for key 'products.product_name'

-- Not null
create table fruits(
	id int,
    fruits_name varchar(25),
    price decimal(4,2) not null
);

alter table products
modify price decimal(4, 2) not null;

insert into products values(104, "Soda", null);
-- Error Code: 1048. Column 'price' cannot be null


drop table employees;

create table employees(
	employee_id int,
    first_name varchar(20),
    last_name varchar(20),
    hourly_pay decimal(4,2),
    hire_date date,
    constraint check_hourly_pay check (hourly_pay > 10)
);


alter table employees
add constraint check_hourly_pay check (hourly_pay >= 10);

select * from employees;

-- if you already added some record in the table which is violate this rules
-- Error Code: 3819. Check constraint 'check_hourly_pay' is violated.

insert into employees values(6, "Sham", "Kharche", 8.50, "2022-02-04");
-- Error Code: 3819. Check constraint 'check_hourly_pay' is violated.

-- remove check 
alter table employees drop check check_hourly_pay;
-- -----------------------------------------------------------

-- default
create table products(
	product_id int,
    product_name varchar(25),
    price decimal(4, 2) default 0
);

alter table products
alter price set default 0;

select * from products;

insert into products (product_id, product_name)
values (103,"straw"),
	(104,"frok"),
    (105,"spoon");


create table transactions(
	transaction_id int,
    amount decimal(5, 2),
    transaction_date datetime default now()
)


select * from transactions;

insert into transactions
values (1, 43.99);
-- insert into transactions values (1, 4003.99)


insert into transactions (transaction_id, amount)
values (2, 83.99);

drop table transactions;
-- ----------------------------------------------------------------------------------------------
-- primary key
create table transactions(
	transaction_id int primary key,
    amount decimal(5,2)
);

select * from transactions;

-- add primary key if you not added at the time of table creation
alter table products
add constraint
primary key(product_id);


insert into transactions
values (102,3.21);

insert into transactions values (102, 10.99);
-- Error Code: 1062. Duplicate entry '102' for key 'transactions.PRIMARY'

insert into transactions value (null, 12.50);
-- Error Code: 1048. Column 'transaction_id' cannot be null

select amount from transactions where transaction_id = 102;

-- ----------------------------------------------------------------------------------------------
-- auto increment

drop table transactions;

create table transactions(
	transaction_id int primary key auto_increment,
    amount decimal(5,2)
);
-- Note: default auto increment value is 1

select * from transactions;

insert into transactions value (32.99), (22.50);
-- Error Code: 1136. Column count doesn't match value count at row 1

insert into transactions (amount) value (32.99),(22.50);

alter table transactions auto_increment = 1000;

insert into transactions (amount) values (99.99);

insert into transactions (amount) values (50.99);

delete from transactions;
-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  
-- To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.

-- first do  Disable Safe Updates
SET SQL_SAFE_UPDATES = 0;

-- then delete records
delete from transactions;

-- after that re-enable Safe Updates
SET SQL_SAFE_UPDATES = 1;

insert into transactions (amount) values (11.99);
insert into transactions (amount) values (20.99);

-- ----------------------------------------------------------------------------------------------
-- foreign key
create table customers(
	customer_id int primary key auto_increment,
    first_name varchar(25),
    last_name varchar(25)
);

select * from customers;

insert into customers (first_name, last_name) 
values ("Vaibhav","Kolte"),
	("Pankaj","Patil"),
    ("Sharad","Patil");
    
drop table transactions;

create table transactions(
	transaction_id int primary key auto_increment,
    amount decimal(5,2),
    customer_id int,
    foreign key(customer_id) references customers(customer_id)
);

select * from transactions;

-- remove foreign key
alter table transactions
drop foreign key transactions_ibfk_1;

-- add foreign key with specific name
alter table transactions
add constraint fk_customer_id
foreign key (customer_id) references customers(customer_id);

insert into transactions (amount, customer_id) 
values (11.99, 1),
	(23.67, 3),
    (32.34, 1),
    (234.89, 2);

delete from customers where customer_id = 3;
-- Error Code: 1451. Cannot delete or update a parent row: 
-- a foreign key constraint fails (`mydb`.`transactions`, CONSTRAINT `fk_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`))

insert into transactions (amount, customer_id) 
values (11.99, null);

insert into customers (first_name, last_name) values ("Sagar","Patel");

-- inner join

select * from transactions
inner join customers
on transactions.customer_id = customers.customer_id;


select transaction_id, amount, first_name, last_name from transactions
inner join customers
on transactions.customer_id = customers.customer_id;


-- left join
select * from transactions
left join customers
on transactions.customer_id = customers.customer_id;

select transaction_id, amount, first_name, last_name from transactions
left join customers
on transactions.customer_id = customers.customer_id;


-- right join
select * from transactions
right join customers
on transactions.customer_id = customers.customer_id;

-- left join
select transaction_id, amount, first_name, last_name from transactions
right join customers
on transactions.customer_id = customers.customer_id;


-- ----------------------------------------------------------------------------------------------
-- functions

select count(amount) from transactions;

-- set column name
select count(amount) as count from transactions;

select max(amount) as maximum from transactions;

select min(amount) as minimum from transactions;

select avg(amount) as average from transactions;

select sum(amount) as Sum from transactions;

select * from customers;

select concat(first_name, " ", last_name) as customer_name from customers;
-- ----------------------------------------------------------------------------------------------
-- and or not

select * from employees;

alter table employees 
add column job varchar(25) after hourly_pay;

update employees
set job = "Manager" where employee_id = 1;

update employees
set job = "Cook" where employee_id = 5;

update employees
set job = "Asst. Manager" where employee_id = 4;

update employees
set job = "Janitor" where employee_id = 6;

update employees
set hourly_pay = 30.00, hire_date = "2020-01-23" where employee_id = 5;

select * from employees where hire_date < "2021-01-01" and job = "Cook";

select * from employees where hire_date < "2021-01-01" or job = "Cook";

select * from employees where not job = "Manager" and not job = "Asst. Manager";

select * from employees where hire_date between "2020-01-01" and "2021-12-31";

select * from employees where job in ("Cook", "Cashier", "Janitor");
-- ----------------------------------------------------------------------------------------------
-- wild card % _
-- Used to substitute one or more characters in string

select * from employees where first_name like "S%";

select * from employees where hire_date like "2022%";

select * from employees where job like "_ook";

select * from employees where job like "%na%";

select * from employees where job like "_a%";
-- ----------------------------------------------------------------------------------------------
-- order by

select * from employees order by hire_date;
-- default order assending

select * from employees order by last_name asc;

select * from employees order by last_name desc;

select * from transactions order by amount;

select * from transactions order by amount asc, transaction_id desc;
-- ----------------------------------------------------------------------------------------------
-- limit
-- Limit clause is used to limit the number of records.
-- Useful if you're working with a lot of data.
-- Can be used to display a large data on pages ( pagination ).

select * from customers;

select * from customers limit 1;

select * from customers order by first_name asc limit 2;

select * from customers limit 2, 1;

INSERT INTO customers (first_name, last_name) VALUES
('John', 'Doe'),
('Jane', 'Smith'),
('Michael', 'Johnson'),
('Emily', 'Davis'),
('Daniel', 'Martinez'),
('Laura', 'Garcia'),
('David', 'Miller'),
('Sarah', 'Rodriguez'),
('James', 'Wilson'),
('Emma', 'Anderson'),
('Robert', 'Thomas'),
('Olivia', 'Taylor'),
('William', 'Moore'),
('Sophia', 'Jackson'),
('Richard', 'Martin'),
('Mia', 'Lee'),
('Joseph', 'Perez'),
('Charlotte', 'Thompson'),
('Charles', 'White'),
('Amelia', 'Harris'),
('Matthew', 'Sanchez'),
('Ava', 'Clark'),
('Anthony', 'Ramirez'),
('Isabella', 'Lewis'),
('Thomas', 'Robinson'),
('Mason', 'Walker'),
('Alexander', 'Young'),
('Lucas', 'Allen'),
('Henry', 'King'),
('Benjamin', 'Wright'),
('Elijah', 'Scott'),
('Sebastian', 'Green'),
('Jackson', 'Baker'),
('Logan', 'Adams'),
('Ethan', 'Nelson'),
('Jack', 'Hill'),
('Liam', 'Campbell'),
('Noah', 'Mitchell'),
('Oliver', 'Carter'),
('Jacob', 'Roberts'),
('James', 'Turner'),
('Ryan', 'Phillips'),
('Evelyn', 'Parker'),
('Ella', 'Evans'),
('Chloe', 'Edwards'),
('Avery', 'Collins'),
('Scarlett', 'Stewart'),
('Mila', 'Simmons'),
('Harper', 'Bennett'),
('Grace', 'Russell');

select * from customers limit 40, 10;
-- ----------------------------------------------------------------------------------------------
-- union
-- Union combines the results of two or more select statements

create table income(
	income_name varchar(50),
	amount decimal(5,2)
);

insert into income values
	("order", 30),
    ("merchandise", 200),
    ("service", 12);
    
select * from income;

create table expenses( expense_name varchar(50), amount decimal(7,2));

insert into expenses values
	("wages",-5343),
    ("tax",-100),
    ("repairs",4220.32);
    
select * from expenses;

select * from income union select * from expenses;

select * from customers union select * from products;


select * from employees union select * from customers;
-- Error Code: 1222. The used SELECT statements have a different number of columns


select first_name, last_name from employees 
union 
select first_name, last_name from customers;
-- union does not allow duplicate



select first_name, last_name from employees 
union all
select first_name, last_name from customers;
-- union all allow duplicate
-- ----------------------------------------------------------------------------------------------
-- self join
-- join another copy of a table to itself
-- used to compare rows of the same table
-- helps to display a heirarchy of data

select * from customers;

delete from customers where customer_id > 10;

alter table customers add referral_id int;

update customers 
set referral_id = 1 where customer_id = 2;

update customers 
set referral_id = 2 where customer_id in (3, 4);

select * from customers as a
inner join customers as b
on referral_id = customer_id;
-- Error Code: 1052. Column 'referral_id' in on clause is ambiguous

select * from customers as a
inner join customers as b
on a.referral_id = b.customer_id;


select a.customer_id, a.first_name, a.last_name, b.first_name, b.last_name
from customers as a
inner join customers as b
on a.referral_id = b.customer_id;

select a.customer_id, a.first_name, a.last_name, concat(b.first_name, " ", b.last_name) as referred_by
from customers as a
inner join customers as b
on a.referral_id = b.customer_id;


select * from employees;

alter table employees add supervisor_id int;

update employees set supervisor_id = 4 where employee_id in (2, 3, 5, 6);

update employees set supervisor_id = 1 where employee_id = 4;

select a.first_name, a.last_name, a.job, concat(b.first_name, " ", b.last_name) as reported_by, b.job
from employees as a
inner  join employees as b
on a.supervisor_id = b.employee_id;

select a.first_name, a.last_name, a.job, concat(b.first_name, " ", b.last_name) as reported_by, b.job
from employees as a
left  join employees as b
on a.supervisor_id = b.employee_id;

select a.first_name, a.last_name, a.job, concat(b.first_name, " ", b.last_name) as reported_by, b.job
from employees as a
right  join employees as b
on a.supervisor_id = b.employee_id;

-- ----------------------------------------------------------------------------------------------
-- views
-- a virtual table based on the result-set of an sql statement
-- the fields in a view are fields from one or more real tables in the database
-- They're not real tables, but can be interacted with as if they were

select * from employees;

create view employee_attendance as select first_name, last_name
from employees;

select * from employee_attendance;

select * from employee_attendance order by last_name desc;

select * from customers;

alter table customers
add column emial varchar(50);

alter table customers drop column emial;

alter table customers
add column email varchar(50);

update customers set email = "sagar@gmail.com"  where customer_id = 4;

delete from customers where customer_id > 4;

create view customer_emails as select email from customers;

select * from customer_emails;
-- ----------------------------------------------------------------------------------------------
-- index (BTree data structure)
-- Indexes are used to find values within a specific column more quickly
-- MySQL normally searches sequentially through a column
-- The long the column, the more sexpensive the operation is
-- Update takes more time, select takes less time

select * from transactions;

show indexes from customers;

create index last_name_idx on customers(last_name);

select * from customers where last_name = "Patil";

create index last_name_first_name_idx on customers(last_name, first_name);

alter table customers drop index last_name_idx;

select * from customers 
where last_name ="Kolte" AND first_name = "Vaibhav";
-- ----------------------------------------------------------------------------------------------
-- subquery
-- a query within another query
-- query (subquery)

select * from employees;

select avg(hourly_pay) from employees;

select first_name, last_name, hourly_pay, (select avg(hourly_pay) from employees) as avgerage from employees;

select first_name, 
        last_name, hourly_pay, 
        (select avg(hourly_pay) from employees) as avgerage, 
		(hourly_pay > (select avg(hourly_pay) from employees)) as is_pay_avg 
        from employees;
        
        
select first_name, last_name, hourly_pay
from employees
where hourly_pay > (select avg(hourly_pay) from employees);


select * from transactions;

select customer_id from transactions where customer_id is not null;

select distinct customer_id from transactions where customer_id is not null;

select * from customers;

select customer_id, first_name, last_name from customers 
where customer_id in (select distinct customer_id from transactions where customer_id is not null);


select customer_id, first_name, last_name from customers 
where customer_id not in (select distinct customer_id from transactions where customer_id is not null);
-- ----------------------------------------------------------------------------------------------
-- group by 
-- arrgregate all rows by a specific column often used with aggregate functions
-- ex. sum(), max(), min(), avg(), count()

select * from transactions;

alter table transactions
add column order_date date;

update transactions
set amount = 4.99, customer_id = 3, order_date = "2023-01-01" where transaction_id = 1000;

update transactions
set amount = 2.89, customer_id = 2, order_date = "2023-01-01" where transaction_id = 1001;

update transactions
set amount = 3.38, customer_id = 3, order_date = "2023-01-02" where transaction_id = 1002;

update transactions
set amount = 4.99, customer_id = 1, order_date = "2023-01-02" where transaction_id = 1003;

insert into transactions (amount, customer_id, order_date)
values (1, null, "2023-01-03"),
	(2.49, 4, "2023-01-03"),
    (5.48, null, "2023-01-03");
    
select * from transactions;

select sum(amount), order_date
from transactions
group by order_date;

select min(amount), order_date
from transactions
group by order_date;

select max(amount), order_date
from transactions
group by order_date;

select avg(amount), order_date
from transactions
group by order_date;

select count(amount), order_date
from transactions
group by order_date;


select sum(amount), customer_id
from transactions
group by customer_id;

select sum(amount), customer_id
from transactions
group by customer_id where sum(amount) > 1;
-- select sum(amount), customer_id from transactions group by customer_id where sum(amount) > 1


select count(amount), customer_id
from transactions
group by customer_id having count(amount) > 1;

select count(amount), customer_id
from transactions
group by customer_id having count(amount) > 1 and customer_id is not null;

-- ----------------------------------------------------------------------------------------------
-- rollup 
-- Extension of the group by clause
-- produces another row and shows the grand total ( super-aggregate value)

select * from transactions;

select sum(amount), order_date
from transactions
group by order_date;

select sum(amount), order_date
from transactions
group by order_date with rollup;

select count(transaction_id), order_date
from transactions
group by order_date with rollup;

select count(transaction_id) as "# of orders", customer_id
from transactions
group by customer_id with rollup;

select sum(hourly_pay) as "hourly_pay", employee_id
from employees
group by employee_id with rollup;
-- ----------------------------------------------------------------------------------------------
-- on delete set null = when a FK is deleted, replace FK with NULL
-- on delete cascade = when a FK is deleted, delete row

select * from customers;
select * from transactions;

delete from customers where customer_id = 4;
-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`mydb`.`transactions`, CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`))

-- for execute above record need to run this 
set foreign_key_checks = 0;

set foreign_key_checks = 1;

insert into customers
values (4, "Suchita", "Kolte", 2, "suchita@gmail.com");

-- if you not create table at first time do this or check this
create table transactions(
	transaction_id int primary key,
    amount decimal(5, 2),
    customer_id int,
    order_date date,
    foreign key (customer_id) references customers(customer_id)
    on delete set null
);

-- if you already create table and want to use "on delete set null" do this
alter table transactions drop foreign key fk_customer_id;

-- Note: if foreign key is not exists which you want to delelte getting error like this
-- Error Code: 1091. Can't DROP 'fk_customer_id'; check that column/key exists


alter table transactions
add constraint fk_customer_id
foreign key(customer_id) references customers(customer_id)
on delete set null;

select * from customers;
select * from transactions;

delete from customers where customer_id = 4;

select * from customers;
select * from transactions;

insert into customers
values (4, "Suchita", "Kolte", 2, "suchita@gmail.com");

alter table transactions drop foreign key fk_customer_id;

alter table transactions
add constraint fk_customer_id
foreign key(customer_id) references customers(customer_id)
on delete cascade;

update transactions set customer_id = 4 where transaction_id = 1005;

select * from customers;
select * from transactions;

delete from customers where customer_id = 4;

select * from customers;
select * from transactions;
-- ----------------------------------------------------------------------------------------------
-- Stored procedure
-- id prepared SQL code that you can save great if there's a query the you write often.
			-- reduce network traffic
            -- increases performance
            -- secure, admin can grant permission to use 
            -- increases memory usage of every connection

select distinct first_name, last_name
from transactions
inner join customers
on transactions.customer_id = customers.customer_id;

delimiter $$
create procedure get_customers()
begin
	select * from customers;
end $$
delimiter ;


call get_customers();

drop procedure get_customers;

delimiter $$
create procedure find_customer(in id int)
begin
	select * from customers where customer_id = id;
end $$
delimiter ;

call find_customer(1);

drop procedure find_customer;

delimiter $$
create procedure find_customer(in f_name varchar(50),
								in l_name varchar(50))
begin
	select * from customers
	where first_name = f_name and last_name = l_name;
end $$
delimiter ;

call find_customer("Vaibhav", "Kolte");
-- ----------------------------------------------------------------------------------------------
-- Trigger 
-- When an event happens, to something
-- ex. (insert, update, delete)
-- checks data, handles errors, auditing tables

select * from employees;

alter table employees
add column salary decimal(10, 2) after hourly_pay;


update employees
set salary = hourly_pay * 2080;
-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  
-- To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.


-- first do  Disable Safe Updates
SET SQL_SAFE_UPDATES = 0;

update employees
set salary = hourly_pay * 2080;

-- after that re-enable Safe Updates
SET SQL_SAFE_UPDATES = 1;


create trigger before_hourly_pay_update
before update on employees
for each row
set new.salary = (new.hourly_pay * 2080);

show triggers;

select * from employees;

update employees
set hourly_pay = 50
where employee_id = 1;

update employees 
set hourly_pay = hourly_pay + 1;


-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------










































































































































































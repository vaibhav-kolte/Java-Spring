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

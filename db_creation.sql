-- SPRINT-2: Database Setup

create database quickroute_db;
use quickroute_db;

create table customers(
customer_id varchar(20) primary key,
customer_name varchar(100) not null,
city varchar(50),
delivery_zone_id VARCHAR(10),
preferred_time_slot VARCHAR(30),
customer_type VARCHAR(20) not null,
account_since DATE
);
select * from customers;

create table orders(
order_id varchar(20) primary key,
customer_id varchar(20) not null,
foreign key (customer_id) references customers(customer_id),
order_date date,
delivery_zone_id varchar(10),
package_weight_kg decimal(5,2),
service_type varchar(20),
priority varchar(10),
total_value decimal(10,2)
);
select * from orders;

create table drivers(
driver_id varchar(10) primary key,
driver_name varchar(100) not null,
hire_date date,
rating decimal(3,2),
employment_type varchar(20),
is_active varchar(3) not null
);
select * from drivers;

create table vehicles(
vehicle_id varchar(10) primary key,
vehicle_type varchar(20),
fuel_type varchar(20),
max_payload_kg decimal(7,2),
depot varchar(10),
last_service_date date,
is_active varchar(3) not null
);
select * from vehicles;

create table deliveries(
delivery_id varchar(20) primary key,
order_id varchar(20) not null,
foreign key (order_id) references orders(order_id),
driver_id varchar(10),
foreign key (driver_id) references drivers(driver_id),
vehicle_id varchar(10),
foreign key (vehicle_id) references vehicles(vehicle_id),
assigned_date date,
actual_delivery_date date,
status varchar(20) not null,
delivery_attempt tinyint,
distance_km decimal(6,2),
delivery_duration_min int
);
select * from deliveries;

-- SPRINT-3: Basic Analysis/ Data Exploration

-- 1. What is the total number of customers? 
select count(*) as "Total Customers" from customers;

-- 2. What is the total number of orders? 
select count(*) as "Total number of Orders" from orders;

-- 3. What is the total number of deliveries?
select count(*) as "Total number of Deliveries" from deliveries;

-- 4. What are the different service types available? 
select distinct(service_type) as "Types of Services" from orders;

-- 5. How many drivers are currently active?
select count(*) as "Total Active Drivers" from drivers where is_active = "Yes";

-- 6. What are the different vehicle types? 
select distinct(vehicle_type) as "Types of Vehicles" from vehicles;

-- 7. What is the total order value? 
select sum(total_value) as "Total Orders Value" from orders;

-- 8. What is the average package weight? 
select avg(package_weight_kg) as "Average Package Weight" from orders;
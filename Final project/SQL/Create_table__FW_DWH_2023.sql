-------------------------------------------------------------------------------------
--create database
-------------------------------------------------------------------------------------

--create database dwh_demo_nj;

-------------------------------------------------------------------------------------
--create shema
-------------------------------------------------------------------------------------

create schema if not exists dwh_bookings;

create schema if not exists dwh_bookings_reject;

-------------------------------------------------------------------------------------
--create table shema dwh_bookings
-------------------------------------------------------------------------------------

create table if not exists dwh_bookings.dim_calendar
as
with dates as (
    select dd::date as dt
    from generate_series
            ('2017-01-01'::timestamptz,
             '2024-01-01'::timestamptz,
             '1 day'::interval) dd)
select  
    to_char(dt, 'yyyymmdd')::int as id,
    dt as date,    
    date_part('isodow', dt)::int as day,
    date_part('week', dt)::int as week_number,
    date_part('month', dt)::int as month,
    date_part('isoyear', dt)::int as year,
    (date_part('isodow', dt)::smallint between 1 and 5)::int as week_day,
    (to_char(dt, 'yyyymmdd')::int in (
       20170101,20170102,20170103,20170104,20170105,
       20170106,20170107,20170108,201723024,20170223,
       20170308,20170612,20171104,20171103))::int as holiday
from dates
order by dt;

alter table if exists dwh_bookings.dim_calendar drop constraint if exists dim_calendar_pkey cascade;
alter table if exists dwh_bookings.dim_calendar add primary key (id);

-------------------------------------------------------------------------------------

create table if not exists dwh_bookings.dim_airports(
id serial4 primary key,
airport_code bpchar(3) not null unique,
airport_name_ru varchar(200) not null,
airport_name_en varchar(200) not null,
city_ru varchar(100) not null,
city_en varchar(100) not null,
longitude decimal not null,
latitude decimal not null,
timezone text not null);

-------------------------------------------------------------------------------------

create table if not exists dwh_bookings.dim_aircrafts(
id serial4 primary key,
aircraft_code bpchar(3) not null unique,
model_ru varchar(300) not null,
model_en varchar(300) not null,
"range" int4 not null);

-------------------------------------------------------------------------------------

create table if not exists dwh_bookings.dim_tariff(
id serial4 primary key,
fare_conditions varchar(10) not null unique);

-------------------------------------------------------------------------------------

create table if not exists dwh_bookings.dim_passengers(	
id serial4 primary key, 
passenger_id  varchar(20) unique not null,
firstname varchar(70) not null,
lastname varchar(70) not null,
email varchar(50) not null,
phone varchar(50) not null);

-------------------------------------------------------------------------------------
--table_fact

create table if not exists dwh_bookings.fact_flights(
passenger_id int not null references dwh_bookings.dim_passengers(id),
actual_departure_id_calendar int not null references dwh_bookings.dim_calendar(id),
actual_departure_time varchar(20) not null,
actual_arrival_id_calendar int not null references dwh_bookings.dim_calendar(id),
actual_arrival_time varchar(20) not null,
delay_departure varchar(20) not null,
delay_arrival varchar(20) not null,
model_id int not null references dwh_bookings.dim_aircrafts(id),
departure_airport_id int not null references dwh_bookings.dim_airports(id),
arrival_airport_id int not null references dwh_bookings.dim_airports(id),
fare_condition_id int not null references dwh_bookings.dim_tariff(id),
amount numeric(10,2) not null);

-------------------------------------------------------------------------------------
--create rejected-table shema dwh_bookings_reject
-------------------------------------------------------------------------------------

create table if not exists dwh_bookings_reject.reject_dim_airports(
id serial4,
airport_code bpchar(3),
airport_name_ru varchar(200),
airport_name_en varchar(200),
city_ru varchar(100),
city_en varchar(100) ,
longitude decimal,
latitude decimal,
timezone text,
created_at timestamp,
error text);

-------------------------------------------------------------------------------------

create table if not exists dwh_bookings_reject.reject_dim_aircrafts(
id  serial4,
aircraft_code bpchar(3),
model_ru varchar(300),
model_en varchar(300),
"range" int4,
created_at timestamp,
error text);

-------------------------------------------------------------------------------------

create table if not exists dwh_bookings_reject.reject_dim_tariff(
id serial4,
aircraft_code bpchar(3),
fare_conditions varchar(10),
created_at timestamp,
error text);

-------------------------------------------------------------------------------------

create table if not exists dwh_bookings_reject.reject_dim_passengers(	
id serial4,
passenger_id  varchar(20), 
firstname varchar(70) ,
lastname varchar(70),
email varchar(50),
phone varchar(50),
created_at timestamp,
error text);

-------------------------------------------------------------------------------------
--table_fact

create table if not exists dwh_bookings_reject.reject_fact_flights(
flight_id int,
passenger_id varchar(20),
actual_departure timestamptz,
actual_arrival timestamptz,
scheduled_departure timestamptz,
scheduled_arrival timestamptz,
actual_departure_id int,
actual_arrival_id int,
aircraft_code bpchar(3),
departure_airport bpchar(3),
arrival_airport bpchar(3),
fare_conditions varchar(10),
amount numeric(10, 2),
created_at timestamp,
error text);


	
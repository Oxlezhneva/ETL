--------------------------------------------------------------------
--select запросы shema dwh_bookings
--------------------------------------------------------------------
select * from dwh_bookings.dim_calendar; 

select * from dwh_bookings.dim_passengers;

select * from dwh_bookings.dim_airports; 

select * from dwh_bookings.dim_tariff;

select * from dwh_bookings.dim_aircrafts; 
--------------------------------------------------------------------
select * from dwh_bookings.fact_flights;


-------------------------------------------------------------------
--select запросы shema dwh_bookings_reject
--------------------------------------------------------------------
select * from  dwh_bookings_reject.reject_dim_passengers;

select * from dwh_bookings_reject.reject_dim_airports; 

select * from dwh_bookings_reject.reject_dim_tariff; 

select * from dwh_bookings_reject.reject_dim_aircrafts; 
--------------------------------------------------------------------
select * from dwh_bookings_reject.reject_fact_flights;

--------------------------------------------------------------------
--select запросы shema bookings
--------------------------------------------------------------------
select * from bookings.seats; 

select * from bookings.ticket_flights;

select * from bookings.tickets;

select * from bookings.flights
where flight_id = 10504;

select * from bookings.airports_data;

select * from bookings.aircrafts_data;
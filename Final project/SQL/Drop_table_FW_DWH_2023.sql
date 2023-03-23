--------------------------------------------------------------------
--drop table shema dwh_bookings
--------------------------------------------------------------------

drop table if exists dwh_bookings.dim_calendar cascade;

drop table if exists dwh_bookings.dim_passengers cascade;

drop table if exists dwh_bookings.dim_airports cascade ;

drop table if exists dwh_bookings.dim_tariff cascade;

drop table if exists dwh_bookings.dim_aircrafts cascade; 
--------------------------------------------------------------------
drop table if exists dwh_bookings.fact_flights cascade; 


--------------------------------------------------------------------
--drop reject-table shema dwh_bookings_reject
--------------------------------------------------------------------

drop table if exists  dwh_bookings_reject.reject_dim_passengers;

drop table if exists dwh_bookings_reject.reject_dim_passengers;

drop table if exists dwh_bookings_reject.reject_dim_airports; 

drop table if exists dwh_bookings_reject.reject_dim_tariff; 

drop table if exists dwh_bookings_reject.reject_dim_aircrafts; 
--------------------------------------------------------------------
drop table if exists dwh_bookings_reject.reject_fact_flights;
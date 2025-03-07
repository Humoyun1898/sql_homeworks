
create database lesson3_homework

create table baggage_check 
		(id bigint primary key,
		check_result varchar(50),
		created_at bigint,
		updated_at bigint,
		booking_id bigint,
		passenger_id bigint,
		constraint fk_baggage foreign key (booking_id) references booking (bookingid),
		constraint fk_baggage1 foreign key (passenger_id) references passengers (id))

create table security_check
		(id bigint primary key,
		check_result varchar(20),
		comments varchar(655),
		created_at datetime,
		updated_at datetime,
		passenger_id bigint,
		constraint fk_sucurity foreign key (passenger_id) references passengers (id))

create table booking
		(bookingid bigint primary key,
		flight_id bigint,
		status varchar(20),
		booking_platform varchar(20),
		created_at datetime,
		updated_at datetime,
		passenger_id bigint,
		constraint fk_booking foreign key (passenger_id) references passengers (id))

create table no_fly_list 
		(id bigint primary key,
		active_from date,
		active_to date,
		no_fly_reason varchar(255),
		created_at datetime,
		updated_at datetime,
		psgnr_id bigint,
		constraint fk_noflylist foreign key (psgnr_id) references passengers (id))

create table passengers
		(id bigint primary key,
		first_name varchar(50),
		last_name varchar(50),
		date_of_birth date,
		country_of_citizenship varchar(50),
		country_of_residence varchar(50),
		passport_number varchar(20),
		created_at datetime,
		updated_at datetime)

create table baggage
		(id bigint,
		weight_in_kg decimal(4,2),
		created_date datetime,
		update_date datetime,
		booking_id bigint,
		constraint fk_baggage4 foreign key (booking_id) references booking (bookingid))

create table flights 
		(flight_id bigint primary key,
		departing_gate varchar(20),
		arriving_gate varchar(20),
		created_at datetime,
		updated_at datetime,
		airline_id bigint,
		departing_airport_id bigint,
		arriving_airport_id bigint,
		constraint fk_flights1 foreign key (airline_id) references airline (id),
		constraint fk_flights2 foreign key (departing_airport_id) references airport  (id),
		constraint fk_flights3 foreign key (arriving_airport_id) references airport (id))

create table flight_manifest
		(id bigint primary key,
		created_at datetime,
		update_at datetime,
		booking_id bigint,
		flight_id bigint,
		constraint fk_flightsmanifest foreign key (booking_id) references booking (bookingid),
		constraint fk_flightsmanifest2 foreign key (flight_id) references flights (flight_id))

create table airport 
		(id bigint primary key,
		airport_name varchar(50),
		country_name varchar (50),
		state varchar(50),
		city varchar(50),
		created_at datetime,
		updated_at datetime)

create table airline
		(id bigint primary key,
		airline_code varchar(30),
		airlin_name bigint,
		airline_country varchar(50),
		created_at datetime,
		updated_at datetime)

create table boarding_pass 
		(id bigint primary key,
		qr_code varchar(50),
		created_at datetime,
		updated_at datetime,
		booking_id bigint,
		constraint boarding_pass1 foreign key (booking_id) references booking (bookingid))


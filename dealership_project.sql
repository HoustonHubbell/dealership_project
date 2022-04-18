CREATE TABLE salesperson (
  salesperson_id SERIAL PRIMARY KEY,
  first_name VARCHAR(30),
  last_name VARCHAR(30)
);

CREATE TABLE car (
  car_id SERIAL PRIMARY KEY,
  make VARCHAR(20),
  model VARCHAR(20),
  vin VARCHAR(20),
  color VARCHAR(20),
  year_ INTEGER
);

CREATE TABLE customer (
  customer_id SERIAL PRIMARY KEY,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  billing_info VARCHAR(100),
  email VARCHAR(30),
  phone_number INTEGER,
  city VARCHAR(20)
);

CREATE TABLE invoice (
  invoice_id SERIAL PRIMARY KEY,
  date_ DATE DEFAULT CURRENT_DATE,
  amount NUMERIC(7,2),
  salesperson_id INTEGER,
  customer_id INTEGER,
  car_id INTEGER,
  FOREIGN KEY(salesperson_id) REFERENCES salesperson(salesperson_id),
  FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
  FOREIGN KEY(car_id) REFERENCES car(car_id)
);

CREATE TABLE service_ticket (
  service_ticket_id SERIAL PRIMARY KEY,
  date_ DATE DEFAULT CURRENT_DATE,
  service_ticket_amount NUMERIC(5,2),
  service_type VARCHAR(100),
  customer_id INTEGER,
  part_id INTEGER,
  mechanic_id INTEGER,
  car_id INTEGER,
  FOREIGN KEY(part_id) REFERENCES part(part_id),
  FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
  FOREIGN KEY(car_id) REFERENCES car(car_id),
  FOREIGN KEY(mechanic_id) REFERENCES mechanic(mechanic_id)
);

CREATE TABLE service_history (
  service_history_id SERIAL PRIMARY KEY,
  car_id INTEGER,
  service_ticket_id INTEGER,
  date_ DATE DEFAULT CURRENT_DATE,
  FOREIGN KEY(car_id) REFERENCES car(car_id),
  FOREIGN KEY(service_ticket_id) REFERENCES service_ticket(service_ticket_id)
);

CREATE TABLE mechanic (
  mechanic_id SERIAL PRIMARY KEY,
  first_name VARCHAR(20),
  last_name VARCHAR(20)
);

CREATE TABLE part (
  part_id SERIAL PRIMARY KEY,
  part_name VARCHAR(40)
);

--ALTER TABLE customer ALTER COLUMN phone_number TYPE VARCHAR;

--Customer Function
create or replace function add_customer(_customer_id INTEGER, _first_name VARCHAR, _last_name VARCHAR, _billing_info VARCHAR, _email VARCHAR, _phone_number VARCHAR, _city VARCHAR)
returns void
AS $MAIN$
begin 
	insert into customer(customer_id, first_name, last_name, billing_info, email, phone_number, city)
	values(_customer_id, _first_name, _last_name, _billing_info, _email, _phone_number, _city);
end;
$MAIN$
language plpgsql;

select add_customer(3, 'Brad', 'Pitt', '0098-2102-4242-6534', 'not_my_man@baldlivesmatter.edu', '123-456-7890', 'Omaha');

SELECT *
FROM customer;


--Salesperson Function
create or replace function add_salesperson(_salesperson_id INTEGER, _first_name VARCHAR, _last_name VARCHAR)
returns void
AS $MAIN$
begin 
	insert into salesperson(salesperson_id, first_name, last_name)
	values(_salesperson_id, _first_name, _last_name);
end;
$MAIN$
language plpgsql;

select add_salesperson(2, 'Ricky', 'Gervais');

select *
from salesperson;


--Car Function
create or replace function add_car(_car_id INTEGER, _make VARCHAR, _model VARCHAR, _vin VARCHAR, _color VARCHAR, _year_ INTEGER)
returns void
AS $MAIN$
begin 
	insert into car(car_id, make, model, vin, color, year_)
	values(_car_id, _make, _model, _vin, _color, _year_);
end;
$MAIN$
language plpgsql;

select add_car(1, 'Lambourghini', 'Hatchback', 'W213D45G6743', 'Teal', 2022);

select add_car(2, 'Maseratti', 'Mini-Van', 'D4532TS7612Y', 'Fecal Brown', 2022);

select add_car(3, 'Rolls Royce', 'Box Truck', 'T213D45G674', 'Baby-Burp White', 2022);

select *
from car;


--Mechanic Function
create or replace function add_mechanic(_mechanic_id INTEGER, _first_name VARCHAR, _last_name VARCHAR)
returns void
AS $MAIN$
begin 
	insert into mechanic(mechanic_id, first_name, last_name)
	values(_mechanic_id, _first_name, _last_name);
end;
$MAIN$
language plpgsql;

select add_mechanic(1, 'Dusty', 'Jorgenson');
select add_mechanic(2, 'Rusty', 'Bucklesworth');
select add_mechanic(3, 'Doofus', 'Grumbleton');

select *
from mechanic;


-- Part Function
create or replace function add_part(_part_id INTEGER, _part_name VARCHAR)
returns void
AS $MAIN$
begin 
	insert into part(part_id, part_name)
	values(_part_id, _part_name);
end;
$MAIN$
language plpgsql;

select add_part(1, 'Plumbous');
select add_part(2, 'Flim-Flam');
select add_part(3, 'Doo-hickey');
select add_part(4, 'Watchamacallit');
select add_part(5, 'Blinker Fluid');

select * 
from part;


-- Invoice Function
create or replace function add_invoice(_invoice_id INTEGER, _date_ TIMESTAMP without time zone, _amount NUMERIC, _salesperson_id INTEGER, _customer_id INTEGER, _car_id INTEGER)
returns void
AS $MAIN$
begin 
	insert into invoice(invoice_id, date_, amount, salesperson_id, customer_id, car_id)
	values(_invoice_id, _date_, _amount, _salesperson_id, _customer_id, _car_id);
end;
$MAIN$
language plpgsql;

select add_invoice(1, NOW()::TIMESTAMP, 5000.00, 1, 1, 3);
select add_invoice(2, NOW()::TIMESTAMP, 9546.28, 2, 2, 1);
select add_invoice(3, NOW()::TIMESTAMP, 8634.97, 1, 3, 2);

select * 
from invoice;


-- Service Ticket Function
create or replace function add_service_ticket(_service_ticket_id INTEGER, _date_ TIMESTAMP without time zone, _service_ticket_amount NUMERIC, _service_type VARCHAR, _customer_id INTEGER, _part_id INTEGER, _mechanic_id INTEGER, _car_id INTEGER)
returns void
AS $MAIN$
begin 
	insert into service_ticket(service_ticket_id, date_, service_ticket_amount, service_type, customer_id, part_id, mechanic_id, car_id)
	values(_service_ticket_id, _date_, _service_ticket_amount, _service_type, _customer_id, _part_id, _mechanic_id, _car_id);
end;
$MAIN$
language plpgsql;

select add_service_ticket(1, NOW()::TIMESTAMP, 900.58, 'Oil Change', 1, 1, 1, 1);
select add_service_ticket(2, NOW()::TIMESTAMP, 45.00, 'Tire Rotation', 3, 4, 3, 3);
select add_service_ticket(3, NOW()::TIMESTAMP, 426.76, 'Plumbous Refactoring', 2, 1, 2, 2);

select * 
from service_ticket;


--Service History Function
DROP FUNCTION add_to_service_history;
create or replace function add_to_service_history(_service_history_id INTEGER, _car_id INTEGER, _service_ticket_id INTEGER, _date_ TIMESTAMP WITHOUT TIME ZONE)
returns void
AS $MAIN$
begin 
	insert into service_history(service_history_id, car_id, service_ticket_id, date_)
	values(_service_history_id, _car_id, _service_ticket_id, _date_);
end;
$MAIN$
language plpgsql;

select add_to_service_history(1, 2, 1, NOW()::TIMESTAMP);
select add_to_service_history(2, 3, 2, NOW()::TIMESTAMP);
select add_to_service_history(3, 1, 3, NOW()::TIMESTAMP);


select * 
from service_history;
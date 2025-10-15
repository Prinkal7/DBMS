CREATE DATABASE insurance;
CREATE TABLE PERSON (
    driver_id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(255) );
    
CREATE TABLE CAR (
    reg_num VARCHAR(20) PRIMARY KEY,
    model VARCHAR(50),
    year INT
);

CREATE TABLE ACCIDENT (
    report_num INT PRIMARY KEY,
    accident_date DATE,
    location VARCHAR(100)
);

CREATE TABLE OWNS (
    driver_id VARCHAR(20),
    reg_num VARCHAR(20),
    PRIMARY KEY (driver_id, reg_num),
    FOREIGN KEY (driver_id) REFERENCES PERSON(driver_id),
    FOREIGN KEY (reg_num) REFERENCES CAR(reg_num) );
    
CREATE TABLE PARTICIPATED (
    driver_id VARCHAR(20),
    reg_num VARCHAR(20),
    report_num INT,
    damage_amount INT,
    PRIMARY KEY (driver_id, reg_num, report_num),
    FOREIGN KEY (driver_id) REFERENCES PERSON(driver_id),
    FOREIGN KEY (reg_num) REFERENCES CAR(reg_num),
    FOREIGN KEY (report_num) REFERENCES ACCIDENT(report_num)
);
 
INSERT INTO ACCIDENT (reprt_num,accident_date,location)VALUES
('11','01-JAN-03','MYSORE ROAD'),
('12','02-FEB-04','SOUTH ENDCIRCLE'),
('13','21-JAN-03','BULL TEMPLE ROAD'),
('14','17-FEB-03','MYSORE ROAD'),
('15','04-MAR-05','KANAKPURA ROAD');

INSERT INTO person (driver_id, name, address) VALUES
('A01', 'Richard', 'Srinivas nagar'),
('A02', 'Pradeep', 'Rajaji nagar'),
('A03', 'Smith', 'Ashok nagar'),
('A04', 'Venu', 'N R Colony'),
('A05', 'John', 'Hanumanth nagar');

INSERT INTO car (reg_num, model, year) VALUES
('KA052250', 'Indica', 1990),
('KA031181', 'Lancer', 1957),
('KA095477', 'Toyota', 1998),
('KA053408', 'Honda', 2008),
('KA041702', 'Audi', 2005);

INSERT INTO owns (driver_id, reg_num) VALUES
('A01', 'KA052250'),
('A02', 'KA031181'),
('A03', 'KA095477'),
('A04', 'KA053408'),
('A05', 'KA041702');

INSERT INTO accident (report_num, accident_date, location) VALUES
(11, '2003-01-01', 'Mysore Road'),
(12, '2004-02-02', 'South end circle'),
(13, '2003-01-21', 'Bull Temple Road'),
(14, '2008-02-17', 'Mysore Road'),
(15, '2004-03-05', 'Kanakpura Road');

INSERT INTO participated (driver_id, reg_num, report_num, damage_amount) VALUES
('A01', 'KA052250', 11, 10000),
('A02', 'KA031181', 12, 50000),
('A03', 'KA095477', 13, 25000),
('A04', 'KA053408', 14, 3000),
('A05', 'KA041702', 15, 5000);

select * from insurance.person;
select * from insurance.car;
select * from insurance.accident;
select * from insurance.owns;
select * from insurance.participated;
select accident_date,location from insurance.accident;
select driver_id from insurance.participated where damage_amount>=25000;
update insurance.participated set damage_amount=25000 where reg_num='KA053408' and report_num=12;
insert into insurance.accident values (16,'2008-03-08','Domlur');
update insurance.participated set damage_amount=50000 where reg_num='KA053408' and report_num=12;
select * from insurance.car order by year asc;
select count(*) from insurance.car where model='Lancer';
select count(*) total from insurance.accident where accident_date like '2008%';
select * from insuranc.participated order by damage_amount desc;
select avg(damage_amount) from insurance.participated;
delete from insurance.participated where damage_amount<(select * from(select avg(damage_amount) from insuranceA.participated) as a);
select name from insurance.person p1, insurance.participated p2 where p1.driver_id=p2.driver_id and damage_amount>(select * from(select avg(damage_amount) from insurance.participated) as a);
select max(damage_amount) from insuranceA.participated; 
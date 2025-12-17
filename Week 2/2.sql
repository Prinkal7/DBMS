CREATE DATABASE insurance;
USE insurance;

CREATE TABLE person (
    driver_id VARCHAR(10),
    name VARCHAR(20),
    address VARCHAR(30),
    PRIMARY KEY (driver_id)
);

CREATE TABLE car (
    reg_num VARCHAR(10),
    model VARCHAR(10),
    year INT,
    PRIMARY KEY (reg_num)
);

CREATE TABLE accident (
    report_num INT,
    accident_date DATE,
    location VARCHAR(20),
    PRIMARY KEY (report_num)
);

CREATE TABLE owns (
    driver_id VARCHAR(10),
    reg_num VARCHAR(10),
    PRIMARY KEY (driver_id, reg_num),
    FOREIGN KEY (driver_id) REFERENCES person(driver_id),
    FOREIGN KEY (reg_num) REFERENCES car(reg_num)
);

CREATE TABLE participated (
    driver_id VARCHAR(10),
    reg_num VARCHAR(10),
    report_num INT,
    damage_amount INT,
    PRIMARY KEY (driver_id, reg_num, report_num),
    FOREIGN KEY (driver_id) REFERENCES person(driver_id),
    FOREIGN KEY (reg_num) REFERENCES car(reg_num),
    FOREIGN KEY (report_num) REFERENCES accident(report_num)
);

INSERT INTO person VALUES
('A01','Richard','Srinivas nagar'),
('A02','Pradeep','Rajaji nagar'),
('A03','Smith','Ashok nagar'),
('A04','Venu','N R Colony'),
('A05','Jhon','Hanumanth nagar');

INSERT INTO car VALUES
('KA052250','Indica',1990),
('KA031181','Lancer',1957),
('KA095477','Toyota',1998),
('KA053408','Honda',2008),
('KA041702','Audi',2005);

INSERT INTO accident VALUES
(11,'2003-01-01','Mysore Road'),
(12,'2004-02-02','South end Circle'),
(13,'2003-01-21','Bull temple Road'),
(14,'2008-02-17','Mysore Road'),
(15,'2005-03-04','Kanakpura Road');

INSERT INTO owns VALUES
('A01','KA052250'),
('A02','KA053408'),
('A03','KA031181'),
('A04','KA095477'),
('A05','KA041702');

INSERT INTO participated VALUES
('A01','KA052250',11,10000),
('A02','KA053408',12,50000),
('A03','KA095477',13,25000),
('A04','KA031181',14,3000),
('A05','KA041702',15,5000);

-- UPDATE
UPDATE participated
SET damage_amount = 25000
WHERE reg_num='KA053408' AND report_num=12;

-- QUERIES
SELECT * FROM participated;

SELECT accident_date, location
FROM accident;

SELECT driver_id
FROM participated
WHERE damage_amount >= 25000;

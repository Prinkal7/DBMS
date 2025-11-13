CREATE DATABASE SupplierParts;
USE SupplierParts;
CREATE TABLE Supplier (
    sid INT PRIMARY KEY,
    sname VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Parts (
    pid INT PRIMARY KEY,
    pname VARCHAR(50),
    color VARCHAR(20)
);

CREATE TABLE Catalog (
    sid INT,
    pid INT,
    cost Decimal(10,2),
    PRIMARY KEY (sid, pid),
    FOREIGN KEY (sid) REFERENCES Supplier(sid),
    FOREIGN KEY (pid) REFERENCES Parts(pid)
);
INSERT INTO Supplier VALUES
(1, 'Acme Widget Suppliers', 'New York'),
(2, 'Global Parts Co', 'London'),
(3, 'Super Supplies', 'Paris');

INSERT INTO Parts VALUES
(101, 'Bolt', 'Red'),
(102, 'Nut', 'Blue'),
(103, 'Screw', 'Red'),
(104, 'Washer', 'Green');

INSERT INTO Catalog VALUES
(1, 101, 10.00),
(1, 102, 15.00),
(2, 101, 12.00),
(2, 103, 20.00),
(3, 101, 11.00),
(3, 102, 16.00),
(3, 103, 18.00),
(3, 104, 25.00);

SELECT DISTINCT p.pname
FROM Parts p
JOIN Catalog c ON p.pid = c.pid;

SELECT s.sname
FROM Supplier s, Catalog c
WHERE s.sid = c.sid
GROUP BY s.sid, s.sname
HAVING COUNT(DISTINCT c.pid) = (SELECT COUNT(*) FROM Parts);

SELECT s.sname
FROM Supplier s
JOIN Catalog c ON s.sid = c.sid
JOIN Parts p ON c.pid = p.pid
WHERE p.color = 'Red'
GROUP BY s.sid, s.sname
HAVING COUNT(DISTINCT p.pid) = (
    SELECT COUNT(*) FROM Parts WHERE color = 'Red'
);

SELECT p.pname
FROM Parts p
WHERE p.pid IN (
    SELECT c.pid
    FROM Catalog c
    JOIN Supplier s ON c.sid = s.sid
    WHERE s.sname = 'Acme Widget Suppliers'
)
AND p.pid NOT IN (
    SELECT c.pid
    FROM Catalog c
    JOIN Supplier s ON c.sid = s.sid
    WHERE s.sname = 'Acme Widget Suppliers'
);

SELECT DISTINCT c1.sid
FROM Catalog c1
JOIN (
    SELECT pid, AVG(cost) AS avg_cost
    FROM Catalog
    GROUP BY pid
) c2 ON c1.pid = c2.pid
WHERE c1.cost > c2.avg_cost;

SELECT p.pname, s.sname, c.cost
FROM Catalog c
JOIN Supplier s ON c.sid = s.sid
JOIN Parts p ON c.pid = p.pid
WHERE c.cost = (
    SELECT MAX(c2.cost)
    FROM Catalog c2
    WHERE c2.pid = c.pid
);


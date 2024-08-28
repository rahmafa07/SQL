CREATE DATABASE TEST_MEGA
USE TEST_MEGA

CREATE TABLE Cabang(
	KodeCabang INT NOT NULL PRIMARY KEY,
	NamaCabang VARCHAR(50)
)

INSERT INTO Cabang VALUES(115, 'Jakarta'),
(145,'Ciputat'),
(175,'Pandeglang'),
(190,'Bekasi')

CREATE TABLE Motor(
	KodeMotor VARCHAR(5) NOT NULL PRIMARY KEY,
	NamaMotor VARCHAR(50)
)

INSERT INTO Motor VALUES('001', 'Suzuki'),
('002','Honda'),
('003','Yamaha'),
('004','Kawasaki')

CREATE TABLE Pembayaran(
	NoKontrak VARCHAR(10) NOT NULL PRIMARY KEY,
	TglBayar DATETIME,
	JumlahBayar INT,
	KodeCabang INT,
	NoKwitansi VARCHAR(12),
	KodeMotor VARCHAR(5),
	FOREIGN KEY(KodeCabang) REFERENCES Cabang(KodeCabang),
	FOREIGN KEY(KodeMotor) REFERENCES Motor(KodeMotor)
)

INSERT INTO Pembayaran VALUES
(1151500001, '2014-10-20 17:14:13', 200000, 115, 14102000001, '001'),
(1451500002, '2014-10-20 16:14:13', 300000, 145, 14102000002, '001'),
(1151500003, '2014-10-20 09:14:13', 350000, 115, 14102000003, '003'),
(1751500004, '2014-10-19 16:14:13', 500000, 175, 14101900001, '002')


--Jawaban
--1 Primary Key = KodeCabang, KodeMotor, NoKontrak
--Foreign Key = KodeCabang, KodeMotor

--2
SELECT * FROM Pembayaran WHERE TglBayar > '2014-10-20 00:00:00'

--3
INSERT INTO Cabang VALUES(200, 'Tangerang')

--4
UPDATE Pembayaran SET KodeMotor='001' WHERE KodeCabang='115'

--5
SELECT P.NoKontrak, P.TglBayar, P.JumlahBayar, P.KodeCabang, C.NamaCabang,
P.NoKwitansi, P.KodeMotor, M.NamaMotor
FROM Pembayaran P
LEFT JOIN Cabang C ON P.KodeCabang = C.KodeCabang
LEFT JOIN Motor M ON P.KodeMotor = M.KodeMotor

--6
SELECT C.KodeCabang, C.NamaCabang, P.NoKontrak, P.NoKwitansi 
FROM Cabang C
LEFT JOIN Pembayaran P ON C.KodeCabang = P.KodeCabang

--7
SELECT C.KodeCabang, C.NamaCabang, COALESCE(P.TotalData,0) TotalData, COALESCE(Z.TotalBayar,0) TotalBayar
FROM Cabang C
LEFT JOIN (
	SELECT P.KodeCabang, COUNT(P.KodeCabang) TotalData FROM Pembayaran P GROUP BY P.KodeCabang
)P ON C.KodeCabang = P.KodeCabang
OUTER APPLY(
	SELECT SUM(P.JumlahBayar) TotalBayar FROM Pembayaran P WHERE P.KodeCabang = C.KodeCabang
)Z 
GROUP BY C.KodeCabang, C.NamaCabang, P.TotalData, Z.TotalBayar



-- =========================
-- DROP & CREATE DATABASE
-- =========================
DROP DATABASE IF EXISTS HospitalDB;
CREATE DATABASE HospitalDB;
USE HospitalDB;

-- =========================
-- TABLES
-- =========================

-- PATIENT
CREATE TABLE Patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    phone VARCHAR(15)
);

-- DOCTOR
CREATE TABLE Doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    specialization VARCHAR(50)
);

-- ROOM
CREATE TABLE Room (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_type VARCHAR(30),
    room_cost DECIMAL(10,2),
    status VARCHAR(20)
);

-- APPOINTMENT
CREATE TABLE Appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,

    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

-- MEDICINE
CREATE TABLE Medicine (
    medicine_id INT AUTO_INCREMENT PRIMARY KEY,
    medicine_name VARCHAR(50),
    price DECIMAL(10,2)
);

-- LAB TEST
CREATE TABLE Lab_Test (
    test_id INT AUTO_INCREMENT PRIMARY KEY,
    test_name VARCHAR(50),
    test_cost DECIMAL(10,2)
);

-- BILLING
CREATE TABLE Billing (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    room_id INT,
    total_bill DECIMAL(10,2),

    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
    FOREIGN KEY (room_id) REFERENCES Room(room_id)
);

-- BILLING MEDICINE
CREATE TABLE Billing_Medicine (
    id INT AUTO_INCREMENT PRIMARY KEY,
    bill_id INT,
    medicine_id INT,
    quantity INT,

    FOREIGN KEY (bill_id) REFERENCES Billing(bill_id),
    FOREIGN KEY (medicine_id) REFERENCES Medicine(medicine_id)
);

-- BILLING TEST
CREATE TABLE Billing_Test (
    id INT AUTO_INCREMENT PRIMARY KEY,
    bill_id INT,
    test_id INT,

    FOREIGN KEY (bill_id) REFERENCES Billing(bill_id),
    FOREIGN KEY (test_id) REFERENCES Lab_Test(test_id)
);

-- PAYMENT
CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    bill_id INT,
    total_amount DECIMAL(10,2),
    amount_paid DECIMAL(10,2),
    remaining_balance DECIMAL(10,2),
    payment_method VARCHAR(20),

    FOREIGN KEY (bill_id) REFERENCES Billing(bill_id)
);

-- =========================
-- TRIGGER
-- =========================
DELIMITER $$

CREATE TRIGGER calc_total_bill
BEFORE INSERT ON Billing
FOR EACH ROW
BEGIN
    DECLARE rprice DECIMAL(10,2);

    SELECT room_cost INTO rprice
    FROM Room
    WHERE room_id = NEW.room_id;

    SET NEW.total_bill = rprice;
END$$

DELIMITER ;

-- =========================
-- INSERT PATIENTS
-- =========================
INSERT INTO Patient VALUES
(NULL,'Ali Khan','Male',25,'03001234567'),
(NULL,'Sara Ahmed','Female',30,'03111234567'),
(NULL,'Usman Tariq','Male',40,'03221234567'),
(NULL,'Ayesha Noor','Female',22,'03331234567'),
(NULL,'Bilal Hussain','Male',35,'03441234567'),
(NULL,'Hina Malik','Female',28,'03551234567'),
(NULL,'Zain Ali','Male',29,'03661234567'),
(NULL,'Fatima Noor','Female',24,'03771234567');

-- =========================
-- INSERT DOCTORS
-- =========================
INSERT INTO Doctor VALUES
(NULL,'Dr. Ahmed','General'),
(NULL,'Dr. Sana','Dermatologist'),
(NULL,'Dr. Ali','Cardiologist'),
(NULL,'Dr. Usman','Orthopedic'),
(NULL,'Dr. Hina','Gynecologist'),
(NULL,'Dr. Bilal','Neurologist'),
(NULL,'Dr. Ayesha','Pediatrician'),
(NULL,'Dr. Tariq','ENT'),
(NULL,'Dr. Farhan','Surgeon'),
(NULL,'Dr. Nadia','Psychiatrist');

-- =========================
-- INSERT ROOMS
-- =========================
INSERT INTO Room VALUES
(NULL,'General',2000,'Available'),
(NULL,'Private',5000,'Available'),
(NULL,'ICU',8000,'Available'),
(NULL,'VIP',10000,'Available'),
(NULL,'Semi-Private',3500,'Available'),
(NULL,'Emergency',4000,'Occupied'),
(NULL,'General Ward',1500,'Empty'),
(NULL,'Isolation',6000,'Empty');

-- =========================
-- INSERT APPOINTMENTS
-- =========================
INSERT INTO Appointment VALUES
(NULL,1,1,'2026-05-01'),
(NULL,2,2,'2026-05-02'),
(NULL,3,3,'2026-05-03'),
(NULL,4,4,'2026-05-04'),
(NULL,5,5,'2026-05-05'),
(NULL,6,6,'2026-05-06'),
(NULL,7,7,'2026-05-07'),
(NULL,8,8,'2026-05-08');

-- =========================
-- INSERT MEDICINES
-- =========================
INSERT INTO Medicine VALUES
(NULL,'Panadol',50),
(NULL,'Augmentin',200),
(NULL,'Brufen',100),
(NULL,'Disprin',30),
(NULL,'Flagyl',120),
(NULL,'Insulin Injection',500),
(NULL,'Pain Killer Injection',300),
(NULL,'Vitamin B12 Injection',250),
(NULL,'Antibiotic Injection',600),
(NULL,'Tetanus Injection',700);

-- =========================
-- INSERT LAB TESTS
-- =========================
INSERT INTO Lab_Test VALUES
(NULL,'X-Ray',0),
(NULL,'Blood Test',800),
(NULL,'Urine Test',500),
(NULL,'CT Scan',3000),
(NULL,'MRI',5000),
(NULL,'Sugar Test',400),
(NULL,'ECG',600),
(NULL,'Liver Function Test',1200),
(NULL,'Kidney Function Test',1500),
(NULL,'Cholesterol Test',900),
(NULL,'Thyroid Test',1100),
(NULL,'Dengue Test',700);

-- =========================
-- INSERT BILLING
-- =========================
INSERT INTO Billing (patient_id, doctor_id, room_id) VALUES
(1,1,1),
(2,2,2),
(3,3,3),
(4,4,4),
(5,5,5);

-- =========================
-- INSERT BILLING MEDICINE
-- =========================
INSERT INTO Billing_Medicine VALUES
(NULL,1,1,2),
(NULL,1,2,1),
(NULL,2,3,2),
(NULL,3,4,1),
(NULL,4,5,2),
(NULL,5,6,1);

-- =========================
-- INSERT BILLING TEST
-- =========================
INSERT INTO Billing_Test VALUES
(NULL,1,1),
(NULL,1,2),
(NULL,2,3),
(NULL,2,4),
(NULL,3,5),
(NULL,4,6),
(NULL,5,7);

-- =========================
-- INSERT PAYMENT
-- =========================
INSERT INTO Payment VALUES
(NULL,1,2000,2000,0,'Cash'),
(NULL,2,5000,5000,0,'Card'),
(NULL,3,8000,8000,0,'Cash'),
(NULL,4,10000,7000,3000,'Cash'),
(NULL,5,3500,3500,0,'Card');

-- =========================
-- FINAL OUTPUT
-- =========================
SELECT * FROM Patient;
SELECT * FROM Doctor;
SELECT * FROM Room;
SELECT * FROM Appointment;
SELECT * FROM Medicine;
SELECT * FROM Lab_Test;
SELECT * FROM Billing;
SELECT * FROM Billing_Medicine;
SELECT * FROM Billing_Test;
SELECT * FROM Payment;
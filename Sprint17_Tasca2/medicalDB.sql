-- ########################
-- STRUCTURE
-- ########################

-- Drop schema &  tables
DROP SCHEMA IF EXISTS clinical;

-- Create schema
CREATE SCHEMA clinical ;

-- Set the path
USE clinical;

-- Create tb_medical_services
CREATE TABLE tb_medical_services (
	med_service_id INT NOT NULL,
	description CHARACTER VARYING(50) NOT NULL,
	surgical CHARACTER  NOT NULL,
	short_code CHARACTER(3)  NOT NULL,
	CONSTRAINT PK_tb_med_services PRIMARY KEY(med_service_id)
	);

-- Create table tb_users  
CREATE TABLE tb_users (
	user_id INT NOT NULL,
	user_name CHARACTER(10)  NOT NULL,
	user_type CHARACTER(10)  NOT NULL,
	full_name CHARACTER VARYING(50) NOT NULL,
	register_dt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	medical_license_nbr CHARACTER(10),
	med_service_id INT,
   CONSTRAINT PK_tb_users PRIMARY KEY(user_id),
	CONSTRAINT FK_users_med_services FOREIGN KEY (med_service_id) REFERENCES tb_medical_services(med_service_id)
	);

-- Create table tb_patient  
CREATE TABLE tb_patient (
	patient_id INT NOT NULL,
	ehr_number INT,
	name CHARACTER VARYING(50),
	sex  CHARACTER,
	birth_dt DATE,
	residence CHARACTER VARYING(100),
	insurance CHARACTER VARYING(50),
	CONSTRAINT PK_tb_patient PRIMARY KEY(patient_id)
	);

-- Create table tb_encounter  
CREATE TABLE tb_encounter (
	encounter_id INT NOT NULL,
	patient_id INT NOT NULL,
	encounter_type CHARACTER VARYING(50) NOT NULL,
	arrival_dt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	discharge_dt TIMESTAMP,
	med_service_id INT NOT NULL,
	CONSTRAINT PK_tb_encounter PRIMARY KEY(encounter_id),
	CONSTRAINT FK_encounter_patient FOREIGN KEY (patient_id) REFERENCES tb_patient(patient_id),
	CONSTRAINT FK_encounter_med_service FOREIGN KEY (med_service_id) REFERENCES tb_medical_services(med_service_id)
	);

-- Create table tb_orders_catalog  
CREATE TABLE tb_orders_catalog (
	order_code INT NOT NULL, 
	category CHARACTER VARYING(50) NOT NULL, 
	subcategory CHARACTER VARYING(50) NOT NULL, 
	order_desc CHARACTER VARYING(50) NOT NULL, 
	cost REAL NOT NULL,
	CONSTRAINT PK_tb_orders_catalog PRIMARY KEY(order_code)
	);

-- Create table tb_orders  
CREATE TABLE tb_orders (
	order_id INT NOT NULL, 
	order_code INT NOT NULL, 
	encounter_id INT NOT NULL, 
	status CHARACTER VARYING(50), 
	created_dt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	status_dt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
	created_by_user INT NOT NULL,
	CONSTRAINT PK_tb_orders PRIMARY KEY(order_id),
	CONSTRAINT FK_orders_catalog FOREIGN KEY (order_code) REFERENCES tb_orders_catalog (order_code),
	CONSTRAINT FK_orders_encounter FOREIGN KEY (encounter_id) REFERENCES tb_encounter(encounter_id),
	CONSTRAINT FK_orders_users FOREIGN KEY (created_by_user) REFERENCES tb_users(user_id)
	);

-- ########################
-- DATA
-- ########################

-- Format dates;
SET datestyle = YMD;        

-- Data tb_med_services;
INSERT INTO clinical.tb_medical_services(med_service_id, description, surgical, short_code) VALUES(1,'Cardiología','N','CAR');
INSERT INTO clinical.tb_medical_services(med_service_id, description, surgical, short_code) VALUES(2,'Cirugía General y Digestiva','S','CGD');
INSERT INTO clinical.tb_medical_services(med_service_id, description, surgical, short_code) VALUES(3,'Radiodiagnóstico','N','RXD');
INSERT INTO clinical.tb_medical_services(med_service_id, description, surgical, short_code) VALUES(4,'Urología','S','URO');
INSERT INTO clinical.tb_medical_services(med_service_id, description, surgical, short_code) VALUES(5,'Urgencias','N','URG');

-- Data tb_users
INSERT INTO clinical.tb_users(user_id, user_name, user_type, full_name, register_dt, medical_license_nbr, med_service_id) VALUES(1,'11133355A','Asist','Dr. Martí','2015-03-01','46111A',1);
INSERT INTO clinical.tb_users(user_id, user_name, user_type, full_name, register_dt, medical_license_nbr, med_service_id) VALUES(2,'22244466B','Asist','Dr. López','2017-01-01','46222M',1);
INSERT INTO clinical.tb_users(user_id, user_name, user_type, full_name, register_dt, medical_license_nbr, med_service_id) VALUES(3,'12312344C','Asist','Dra. Pintos','2018-08-01','30220C',3);
INSERT INTO clinical.tb_users(user_id, user_name, user_type, full_name, register_dt, medical_license_nbr, med_service_id) VALUES(4,'33345665D','Asist','Dra. Adriana','2015-03-01','43881R',2);
INSERT INTO clinical.tb_users(user_id, user_name, user_type, full_name, register_dt, medical_license_nbr, med_service_id) VALUES(5,'77791982E','Asist','Dra. Barceló','2017-01-01','48932A',2);
INSERT INTO clinical.tb_users(user_id, user_name, user_type, full_name, register_dt, medical_license_nbr, med_service_id) VALUES(6,'44332772F','Asist','Dra. Rivera','2020-02-01','46555T',3);
INSERT INTO clinical.tb_users(user_id, user_name, user_type, full_name, register_dt, medical_license_nbr, med_service_id) VALUES(7,'88544588G','Asist','Dra. Palop','2016-01-01','47830B',2);
INSERT INTO clinical.tb_users(user_id, user_name, user_type, full_name, register_dt, medical_license_nbr, med_service_id) VALUES(8,'99853585H','Asist','Dr. Abad','2015-07-01','36190A',1);
INSERT INTO clinical.tb_users(user_id, user_name, user_type, full_name, register_dt, medical_license_nbr, med_service_id) VALUES(9,'32132185Z','NoAsist','Teresa Abad','2018-12-01',NULL,NULL);
INSERT INTO clinical.tb_users(user_id, user_name, user_type, full_name, register_dt, medical_license_nbr, med_service_id) VALUES(10,'99853585H','NoAsist','Pau Ribas','2015-03-01',NULL,NULL);
INSERT INTO clinical.tb_users(user_id, user_name, user_type, full_name, register_dt, medical_license_nbr, med_service_id) VALUES(11,'12388834P','Asist','Dr. Pellicer','2015-07-01','36190A',4);
INSERT INTO clinical.tb_users(user_id, user_name, user_type, full_name, register_dt, medical_license_nbr, med_service_id) VALUES(12,'99811077R','Asist','Dra. Lucas','2015-07-01','36190A',4);
INSERT INTO clinical.tb_users(user_id, user_name, user_type, full_name, register_dt, medical_license_nbr, med_service_id) VALUES(13,'644544488M','Asist','Dr. Peris','2020-01-01','47333B',2);

-- Data tb_patient
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(1, 1001, 'Pep', 'M', '1965-06-14', 'Carrer Principal', 'Pública');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(2, 1002, 'Carlos', 'M', '1989-02-10', 'Carrer de dalt', 'Mapfre');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(3, 1003, 'Eva', 'F', '1970-01-04', 'Carrer Lluna', 'DKV') ;
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(4, 1003, 'Xavi', 'M', '1956-10-03', 'Carrer nord', 'Muface');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(5, 1004, 'Elena', 'F', '1977-06-25', 'Carrer sud', 'Zurich');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(6, 1005, 'Marta', 'F', '1998-11-07', 'Carrer oest', 'Caser');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(7, 1006, 'Lluís', 'M', '1998-11-07', 'Av. Diagonal', 'Muface');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(8, 1007, 'Sara', 'F', '1965-11-07', 'Carrer de dalt', 'Mapfre');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(9, 1008, 'Tamara', 'F', '1995-11-07', 'Av. del Mar', 'Muface');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(10, 1009, 'Paco', 'M', '1992-11-07', 'Carrer Lluna', 'No disponible');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(11, 1010, 'Claudia', 'F', '1988-11-07', 'Carrer Principal', 'Pública');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(12, 1011, 'Miriam', 'F', '1978-11-07', 'Pl. Constitució', 'Muface');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(13, 1012, 'Pau', 'M', '1953-11-07', 'Av. Diagonal', 'Sanitas');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(14, 1013, 'Sheila', 'F', '1951-11-07', 'Carrer de dalt ', 'Mapfre');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(15, 1014, 'Antonio', 'M', '2000-11-07', 'Av. del Mar', 'Muface');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(16, 1015, 'Ada', 'F', '2010-11-07', 'Carrer Lluna', 'No disponible');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(17, 1016, 'Pedro', 'M', '2005-11-07', 'Carrer Principal', 'Muface');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(18, 1017, 'Pol', 'M', '2003-11-07', 'Pl. Constitució', 'Pública');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(19, 1018, 'Antonia', 'F', '1998-11-07', 'Carrer Principal', 'Mapfre');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(20, 1019, 'Mireia', 'F', '1994-11-07', 'Carrer Lluna', 'No disponible');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(21, 1020, 'Maria', 'F', '1999-11-07', 'Av. del Mar', 'Muface');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(22, 1021, 'Moises', 'M', '1982-11-07', 'Carrer de dalt', 'Sanitas');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(23, 1022, 'Cristina', 'F', '1985-11-07', 'Av. Diagonal', 'Sanitas');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(24, 1023, 'Marc', 'M', '1988-11-07', 'Carrer de dalt', 'No disponible');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(25, 1024, 'Julia', 'F', '1984-11-07', 'Av. del Mar', 'Pública');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(26, 1025, 'Ainara', 'F', '1980-11-07', 'Carrer Lluna', 'No disponible');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(27, 1026, 'Marisa', 'F', '1973-11-07', 'Carrer Principal', 'No disponible');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(28, 1027, 'John', 'M', '1991-11-07', 'Pl. Constitució', 'Sanitas');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(29, 1028, 'Rudy', 'M', '1968-11-07', 'Av. del Mar', 'Sanitas');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(30, 1029, 'Cristian Jose', 'M', '1962-11-07', 'Carrer Lluna', 'No disponible');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(31, 1030, 'Josep', 'M', '1949-11-07', 'Carrer Principal', 'Mapfre');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(32, 1031, 'Maise', 'F', '1945-11-07', 'Carrer de dalt', 'No disponible');
INSERT INTO clinical.tb_patient(patient_id, ehr_number, name, sex, birth_dt, residence, insurance) VALUES(33, 1032, 'Lola', 'F', '1971-11-07', 'Carrer Principal', 'Pública');

-- Data tb_encounter
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(65091,31,'Consulta Externa','2016-04-12 08:59:00','2016-04-12 22:50:00',1);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(66971,31,'Consulta Externa','2016-05-16 11:12:34','2016-05-16 18:20:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(75753,1,'Consulta Externa','2016-06-16 12:26:59','2016-06-16 15:00:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(77276,11,'Consulta Externa','2016-01-07 08:10:00','2016-01-07 15:30:00',1);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(78919,11,'Urgencia','2018-07-26 13:23:55','2018-07-27 15:00:00',4);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(94555,3,'Urgencia','2019-07-19 11:17:00','2019-07-21 12:15:00',1);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(145239,3,'Consulta Externa','2016-07-01 08:09:00','2016-07-01 15:30:00',1);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(335523,2,'Consulta Externa','2017-12-12 15:36:00','2017-12-12 15:40:00',2);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(349048,13,'Consulta Externa','2019-03-06 08:00:00','2019-03-06 15:30:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(368324,5,'Consulta Externa','2019-11-04 12:23:00','2019-11-04 16:30:00',1);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(382468,6,'Consulta Externa','2016-11-03 11:35:00','2016-11-03 15:30:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(415648,5,'Consulta Externa','2017-05-12 08:08:00','2017-05-12 15:30:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(416315,8,'Consulta Externa','2017-01-05 13:24:00','2017-01-05 16:00:00',2);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(458151,12,'Urgencia','2016-03-29 08:09:00','2016-03-29 15:00:00',1);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(466419,15,'Consulta Externa','2016-07-04 12:21:43','2016-07-04 15:30:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(534591,17,'Consulta Externa','2016-07-06 08:01:00','2016-07-06 16:30:00',1);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(578388,30,'Consulta Externa','2009-08-14 12:10:00','2016-07-21 10:03:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(580497,31,'Consulta Externa','2019-02-27 13:26:00','2019-02-27 15:30:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(612514,31,'Consulta Externa','2016-02-22 10:31:02','2016-02-22 15:30:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(626017,21,'Consulta Externa','2016-10-06 11:44:00','2016-10-06 15:30:00',1);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(626026,22,'Consulta Externa','2019-10-14 16:36:00','2019-10-14 16:45:00',4);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(636475,28,'Consulta Externa','2018-09-27 08:16:00','2018-09-27 15:30:00',1);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(644696,18,'Consulta Externa','2016-07-06 08:54:23','2016-07-06 15:30:00',1);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(651186,31,'Consulta Externa','2017-09-25 10:10:58','2017-09-25 12:02:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(691529,31,'Consulta Externa','2019-10-07 12:48:00','2019-10-07 15:30:00',2);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(697588,32,'Consulta Externa','2016-02-08 16:30:07','2016-02-08 16:50:00',1);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(705906,4,'Consulta Externa','2016-01-27 08:28:00','2016-01-27 15:30:00',1);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(732332,3,'Consulta Externa','2016-09-16 08:51:00','2016-09-16 15:30:00',4);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(750284,31,'Consulta Externa','2016-07-13 20:07:00','2016-07-13 20:30:00',2);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(788684,5,'Consulta Externa','2016-06-15 10:48:23','2016-06-15 15:30:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(796041,7,'Urgencia','2017-06-27 18:18:00','2017-06-27 19:30:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(796745,5,'Consulta Externa','2016-02-11 08:11:00','2016-02-11 15:30:00',1);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(801833,9,'Consulta Externa','2016-06-20 10:58:13','2016-06-20 15:30:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(862462,10,'Consulta Externa','2019-10-28 16:21:00','2019-10-28 16:30:00',1);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(874080,7,'Urgencia','2019-12-18 09:39:00','2019-12-18 15:30:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(879797,14,'Consulta Externa','2017-09-08 09:39:46','2017-09-08 16:30:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(905346,31,'Consulta Externa','2016-02-25 11:19:00','2016-02-25 15:30:00',1);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(920935,32,'Consulta Externa','2019-06-11 08:12:00','2019-06-11 15:30:00',1);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(932297,33,'Urgencia','2016-02-18 13:51:00','2016-02-18 15:00:00',2);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(935442,14,'Consulta Externa','2019-10-14 19:25:00','2019-10-14 20:00:00',1);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(952783,16,'Consulta Externa','2019-11-11 09:31:00','2019-11-11 15:30:00',1);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(983497,7,'Consulta Externa','2016-06-16 11:41:00','2016-06-16 15:30:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(990247,6,'Consulta Externa','2016-04-19 14:52:00','2016-04-19 15:30:00',1);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(1003307,16,'Consulta Externa','2016-04-14 09:45:00','2016-04-14 15:30:00',1);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(1012472,15,'Consulta Externa','2016-05-06 15:11:00','2016-05-06 15:30:00',1);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(1017014,15,'Consulta Externa','2019-12-16 17:23:00','2019-12-16 17:30:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(1021911,15,'Consulta Externa','2017-05-29 10:49:00','2017-05-29 19:30:00',1);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(1042455,21,'Consulta Externa','2016-02-08 11:08:00','2016-02-08 19:30:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(1087486,29,'Consulta Externa','2019-03-12 23:06:00','2019-03-13 00:05:00',2);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(1103632,30,'Consulta Externa','2019-12-02 09:22:00','2019-12-02 15:30:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(10363733,16,'Ingreso Programado','2016-02-08 08:47:00','2016-02-13 10:33:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(10417872,16,'Ingreso Urgente','2016-06-17 23:15:00','2016-06-23 15:32:00',4);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(10694717,5,'Ingreso Programado','2016-02-05 08:26:00','2016-02-09 19:12:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(10963484,2,'Urgencia','2016-01-25 08:21:00','2016-01-29 12:48:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11025100,5,'Ingreso Programado','2016-01-26 07:06:00','2016-01-29 17:00:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11046260,7,'Ingreso Urgente','2016-02-17 07:27:00','2016-02-18 09:57:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11053098,9,'Ingreso Programado','2016-05-23 08:28:00','2016-05-28 18:50:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11155949,8,'Ingreso Programado','2016-05-02 08:52:00','2016-05-06 15:23:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11240766,6,'Ingreso Programado','2016-03-01 07:15:00','2016-03-02 11:23:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11268371,3,'Ingreso Programado','2016-02-15 08:03:00','2016-02-19 15:57:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11269924,6,'Ingreso Programado','2016-01-11 08:37:00','2016-01-15 13:38:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11274397,16,'Ingreso Programado','2016-01-12 07:30:00','2016-01-16 15:04:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11309674,3,'Ingreso Programado','2016-03-04 07:10:00','2016-03-08 18:02:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11311138,18,'Ingreso Programado','2016-01-15 07:12:00','2016-01-19 16:31:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11314182,12,'Ingreso Programado','2016-01-11 09:06:00','2016-01-19 17:31:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11323622,27,'Ingreso Programado','2016-01-28 07:38:00','2016-02-01 15:42:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11323999,16,'Ingreso Programado','2016-03-08 09:00:00','2016-03-11 16:33:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11324990,21,'Urgencia','2016-01-18 07:29:00','2016-01-22 17:17:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11346702,29,'Ingreso Programado','2016-01-07 09:37:00','2016-01-09 14:22:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11346997,28,'Ingreso Programado','2016-01-19 08:45:00','2016-01-22 15:27:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11356518,16,'Ingreso Programado','2016-01-18 07:11:00','2016-01-22 18:14:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11364844,15,'Ingreso Urgente','2016-01-26 08:36:00','2016-01-29 16:29:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11379561,9,'Ingreso Urgente','2016-01-12 08:15:00','2016-01-16 13:51:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11387155,10,'Ingreso Programado','2016-01-19 07:27:00','2016-01-23 14:45:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11387479,16,'Ingreso Programado','2016-01-26 07:08:00','2016-01-29 14:33:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11408319,2,'Ingreso Programado','2016-01-15 07:31:00','2016-01-20 15:00:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11412198,16,'Ingreso Programado','2016-02-08 08:57:00','2016-02-15 16:59:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11423495,17,'Ingreso Programado','2016-02-15 07:30:00','2016-02-16 16:33:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11423570,16,'Ingreso Programado','2016-01-21 07:12:00','2016-01-23 17:56:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11426225,11,'Ingreso Programado','2016-01-29 07:17:00','2016-02-02 19:12:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11434862,17,'Ingreso Programado','2016-01-25 07:16:00','2016-01-29 20:07:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11435938,14,'Ingreso Programado','2016-01-18 08:43:00','2016-01-22 12:29:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11444105,16,'Ingreso Programado','2016-02-11 07:11:00','2016-02-12 09:57:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11463386,12,'Ingreso Programado','2016-01-28 08:43:00','2016-01-30 13:37:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11466315,16,'Ingreso Programado','2016-01-08 08:20:00','2016-01-13 12:26:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11477068,10,'Ingreso Urgente','2016-01-22 07:11:00','2016-01-27 11:55:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11494654,4,'Ingreso Urgente','2016-01-29 08:02:00','2016-02-01 16:05:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11495918,10,'Ingreso Urgente','2016-01-14 07:01:00','2016-01-20 16:04:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11496400,19,'Ingreso Programado','2016-01-18 08:40:00','2016-01-21 19:44:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11496690,15,'Ingreso Programado','2016-01-08 07:11:00','2016-01-09 11:11:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11515795,16,'Ingreso Urgente','2016-01-15 07:15:00','2016-01-20 05:50:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11516744,6,'Ingreso Programado','2015-12-30 07:02:00','2016-01-02 15:06:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11547602,1,'Ingreso Programado','2016-01-28 08:59:00','2016-02-02 18:05:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11557170,25,'Ingreso Urgente','2016-01-13 07:00:00','2016-01-18 12:54:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11557185,16,'Ingreso Programado','2016-02-24 07:09:00','2016-03-02 15:41:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11577940,21,'Ingreso Programado','2016-02-01 07:36:00','2016-02-05 17:02:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11579397,16,'Ingreso Programado','2016-02-15 07:07:00','2016-02-19 15:55:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11579647,16,'Ingreso Programado','2016-02-01 08:19:00','2016-02-05 12:32:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11588064,7,'Ingreso Programado','2016-02-09 08:49:00','2016-02-12 17:03:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11592697,16,'Ingreso Programado','2016-01-15 13:50:00','2016-01-16 14:07:00',4);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11597878,16,'Ingreso Programado','2016-02-08 07:22:00','2016-02-12 12:03:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11612862,4,'Ingreso Programado','2016-01-11 07:30:00','2016-01-13 12:01:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11617274,16,'Ingreso Programado','2016-03-21 07:07:00','2016-03-22 11:59:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11631481,6,'Ingreso Programado','2016-02-26 07:07:00','2016-03-02 14:12:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11632792,3,'Ingreso Programado','2016-01-13 07:18:00','2016-01-13 11:42:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11658882,16,'Ingreso Programado','2016-02-09 07:17:00','2016-02-12 18:11:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11666570,16,'Ingreso Programado','2016-01-18 07:25:00','2016-01-21 11:08:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11668786,4,'Ingreso Programado','2016-01-20 07:09:00','2016-01-25 14:15:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11687014,16,'Ingreso Urgente','2015-08-24 15:43:00','2016-07-26 14:24:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11691278,16,'Ingreso Programado','2016-02-04 07:35:00','2016-02-08 16:57:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11691543,6,'Ingreso Programado','2016-01-25 07:18:00','2016-01-28 13:26:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11693879,16,'Ingreso Programado','2016-02-22 08:19:00','2016-02-26 17:24:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11694898,9,'Ingreso Urgente','2016-02-01 07:12:00','2016-02-05 17:03:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11701607,16,'Ingreso Urgente','2016-01-11 07:34:00','2016-01-14 17:24:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11705396,9,'Ingreso Programado','2016-01-27 08:37:00','2016-01-30 14:49:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11719766,16,'Ingreso Programado','2016-01-29 07:58:00','2016-02-01 11:39:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11724071,16,'Ingreso Programado','2016-02-05 07:03:00','2016-02-08 13:09:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11734190,16,'Ingreso Programado','2016-02-16 08:40:00','2016-02-19 17:55:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11735839,22,'Ingreso Programado','2016-01-13 13:14:00','2016-01-14 09:59:00',4);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11745383,16,'Ingreso Programado','2016-01-11 07:11:00','2016-01-12 15:21:00',2);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11749744,16,'Ingreso Urgente','2016-01-22 07:47:00','2016-01-23 15:08:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11752968,26,'Ingreso Programado','2016-01-07 09:40:00','2016-01-08 12:49:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11753627,6,'Ingreso Programado','2016-01-13 07:07:00','2016-01-17 13:57:00',4);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11767183,16,'Ingreso Programado','2016-02-03 07:20:00','2016-02-05 12:06:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11771850,16,'Ingreso Programado','2016-02-04 08:58:00','2016-02-05 10:19:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11772308,21,'Ingreso Programado','2016-02-29 09:00:00','2016-03-04 16:17:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11772320,16,'Ingreso Programado','2016-03-14 08:40:00','2016-03-18 15:10:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11775194,18,'Ingreso Programado','2016-01-29 07:30:00','2016-02-02 20:07:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11775542,9,'Ingreso Programado','2016-02-16 07:20:00','2016-02-19 13:23:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11777685,3,'Ingreso Programado','2016-01-13 07:25:00','2016-01-14 13:51:00',4);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11779257,9,'Ingreso Programado','2016-02-03 07:08:00','2016-02-11 12:45:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11785864,2,'Ingreso Programado','2016-01-29 07:06:00','2016-01-31 13:58:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11787440,4,'Ingreso Urgente','2016-02-05 07:12:00','2016-02-07 13:06:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11796024,3,'Ingreso Urgente','2016-01-07 07:04:00','2016-01-11 17:17:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11803108,6,'Ingreso Urgente','2016-02-01 08:36:00','2016-02-02 13:37:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11807052,13,'Ingreso Programado','2016-02-05 06:58:00','2016-02-09 11:47:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11811018,13,'Ingreso Programado','2016-03-11 07:11:00','2016-03-12 11:17:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11816109,11,'Ingreso Programado','2016-01-08 07:03:00','2016-01-10 15:40:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11817162,16,'Ingreso Urgente','2017-01-25 07:04:00','2017-02-03 12:24:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11818831,10,'Ingreso Programado','2016-01-08 13:56:00','2016-01-09 14:24:00',4);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11819185,11,'Ingreso Programado','2016-01-22 07:13:00','2016-01-25 17:46:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11822341,10,'Ingreso Programado','2016-05-31 07:07:00','2016-06-01 10:25:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11825644,15,'Ingreso Programado','2016-02-16 07:35:00','2016-02-17 13:23:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11827570,14,'Ingreso Urgente','2016-01-12 07:06:00','2016-01-14 09:57:00',2);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11831221,15,'Ingreso Urgente','2016-01-19 08:22:00','2016-01-21 09:29:00',2);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11833617,16,'Ingreso Programado','2016-02-22 07:23:00','2016-02-26 17:22:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11833913,4,'Ingreso Programado','2016-02-22 07:05:00','2016-02-23 09:05:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11834876,7,'Ingreso Programado','2016-02-01 08:05:00','2016-02-12 16:50:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11842234,1,'Ingreso Programado','2016-01-13 07:11:00','2016-01-15 13:52:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11845841,1,'Ingreso Programado','2016-02-23 10:17:00','2016-02-27 17:42:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11849659,19,'Ingreso Programado','2016-02-15 07:10:00','2016-02-18 21:09:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11857484,22,'Urgencia','2016-03-15 07:19:00','2016-03-18 13:41:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11857493,29,'Urgencia','2016-01-13 07:57:00','2016-01-15 13:52:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11862252,26,'Urgencia','2016-01-11 07:03:00','2016-01-12 12:36:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11863641,24,'Ingreso Programado','2016-02-19 07:39:00','2016-02-23 15:51:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11885195,16,'Ingreso Programado','2016-02-23 07:18:00','2016-02-26 18:23:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11885729,26,'Ingreso Programado','2016-01-11 08:49:00','2016-01-15 15:45:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11886210,16,'Ingreso Urgente','2016-01-14 07:03:00','2016-01-18 12:11:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11895394,16,'Ingreso Urgente','2016-03-07 09:55:00','2016-03-11 13:59:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11901439,16,'Ingreso Programado','2016-03-22 10:29:00','2016-03-23 13:07:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11903343,15,'Urgencia','2016-01-08 07:14:00','2016-01-14 13:49:00',4);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11903656,14,'Ingreso Programado','2016-01-18 06:59:00','2016-01-22 15:39:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11908119,16,'Ingreso Programado','2016-01-20 07:16:00','2016-01-25 14:46:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11911816,17,'Ingreso Programado','2016-03-15 08:58:00','2016-03-18 17:51:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11919305,10,'Ingreso Programado','2016-01-21 07:06:00','2016-01-23 14:26:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11919941,1,'Ingreso Programado','2016-03-17 09:25:00','2016-03-21 17:20:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11921586,6,'Urgencia','2016-03-11 07:03:00','2016-03-16 12:12:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11928281,9,'Urgencia','2016-04-26 07:36:00','2016-04-27 12:09:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11932659,18,'Ingreso Programado','2016-02-29 07:24:00','2016-03-03 14:40:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11933490,16,'Ingreso Programado','2016-01-15 07:26:00','2016-01-17 16:26:00',4);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11938118,16,'Urgencia','2016-01-19 07:18:00','2016-01-20 17:02:00',2);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11940633,19,'Urgencia','2016-01-22 07:08:00','2016-01-22 18:42:00',4);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11943319,19,'Ingreso Programado','2016-01-22 07:18:00','2016-01-22 20:02:00',4);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11944940,18,'Ingreso Programado','2016-02-17 15:08:00','2016-02-18 13:25:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11948321,26,'Ingreso Programado','2016-01-14 07:45:00','2016-01-15 11:37:00',2);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11949782,26,'Urgencia','2016-02-29 07:19:00','2016-03-04 13:07:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11950311,7,'Ingreso Programado','2016-01-15 07:35:00','2016-01-17 13:56:00',2);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11950341,18,'Ingreso Programado','2016-03-01 07:21:00','2016-03-04 15:51:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11950362,15,'Urgencia','2016-01-14 07:12:00','2016-01-14 19:21:00',2);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11950579,12,'Urgencia','2016-01-20 07:06:00','2016-01-22 12:28:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11955552,14,'Ingreso Programado','2016-02-05 07:05:00','2016-02-09 16:58:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11958246,6,'Ingreso Programado','2016-01-11 13:35:00','2016-01-12 12:13:00',4);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11958559,7,'Ingreso Programado','2016-01-22 07:24:00','2016-01-23 15:09:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11959048,11,'Ingreso Programado','2016-01-14 09:45:00','2016-01-15 10:30:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11961049,11,'Ingreso Programado','2016-01-08 13:47:00','2016-01-09 14:25:00',4);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11962017,17,'Ingreso Programado','2017-02-08 07:03:00','2017-02-14 19:58:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11963664,19,'Ingreso Programado','2016-02-19 07:31:00','2016-02-20 11:37:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11966931,21,'Urgencia','2016-03-21 09:15:00','2016-03-24 14:50:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11969696,16,'Urgencia','2016-01-27 07:02:00','2016-01-28 10:02:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11974023,2,'Ingreso Programado','2016-01-19 17:58:00','2016-01-21 13:56:00',4);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11977300,1,'Ingreso Programado','2016-03-18 07:04:00','2016-03-20 16:45:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11977617,16,'Urgencia','2016-04-05 09:27:00','2016-04-08 17:56:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11979904,12,'Urgencia','2016-01-18 13:58:00','2016-01-18 18:35:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11984044,16,'Ingreso Programado','2016-01-27 07:41:00','2016-01-28 10:02:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11984109,16,'Ingreso Programado','2016-01-11 07:07:00','2016-01-11 14:43:00',4);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11984729,14,'Ingreso Programado','2016-04-18 07:42:00','2016-04-21 16:59:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11986674,2,'Urgencia','2016-04-04 07:23:00','2016-04-08 14:39:00',3);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11987587,12,'Ingreso Programado','2016-01-27 07:57:00','2016-01-28 14:41:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11988058,11,'Urgencia','2016-01-29 07:32:00','2016-02-01 14:04:00',5);
INSERT INTO clinical.tb_encounter(encounter_id, patient_id, encounter_type, arrival_dt, discharge_dt, med_service_id) VALUES(11989445,3,'Ingreso Programado','2016-02-12 07:32:00','2016-02-14 19:12:00',3);


-- Data tb_orders_catalog
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (2144, 'Laboratorio', 'Laboratorio', 'Creatinina..Srm', 0.34);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1374, 'Cardiologia', 'Cardioversión', 'Cardioversión electrica programada', 114.11);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (3967, 'Cardiologia', 'Cardioversión', 'Cardioversión electrica urgente', 114.11);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (6777, 'Cardiologia', 'Ecocardiografía', 'Ecocardiografía transtorácica (AR)', 81.03);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1368, 'Cardiologia', 'Esfuerzo', 'Prueba de esfuerzo', 168.18);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (6923, 'Cardiologia', 'Gestión', 'Solicitud Estudio hemodinámico Urgente', 40.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (6929, 'Cardiologia', 'Gestión', 'Solicitud Estudio hemodinámico Programad', 40.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1369, 'Cardiologia', 'Holter', 'Holter de ritmo cardiaco', 46.85);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1371, 'Cardiologia', 'Holter', 'Holter de presión arterial', 62.13);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (6781, 'Cardiologia', 'Holter', 'Lectura Holter Ritmo Cardiaco', 40.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (6800, 'Cardiologia', 'Primeras', 'Cardiología no presencial', 40.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (8299, 'Cardiologia', 'Primeras', 'Primera consulta cardiología', 65.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (7158, 'Cardiologia', 'Primeras', 'Revisión postquirúrgica no presencial', 40.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (4459, 'Cardiologia', 'Sucesivas', 'Consulta sucesiva cardiología', 40.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (8114, 'Hematologia', 'Médula', 'Consulta Hematología Pruebas', 40.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1499, 'Hematologia', 'Médula', 'Aspiración médula ósea', 30.41);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1500, 'Hematologia', 'Médula', 'Biopsia médula ósea', 66.29);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (7824, 'Hematologia', 'Primeras', 'Hematología No Presencial', 40.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (8104, 'Hematologia', 'Primeras', 'HEM No Presencial Anemia Preoperatoria', 40.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (8106, 'Hematologia', 'Primeras', 'HEM Anticoagulación Oral  No Presencial', 40.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (3694, 'Hematologia', 'Primeras', 'Primera consulta hematología', 65.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (4745, 'Hematologia', 'Primeras', 'Primera Consulta Anticoagulación Oral', 65.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (8677, 'Hematologia', 'Primeras', 'Primera consulta hematología Virtual', 65.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1498, 'Hematologia', 'Sucesivas', 'Consulta sucesiva hematología', 40.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (7635, 'Hematologia', 'Sucesivas', 'Consulta Sucesiva Anticoagulación', 40.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (7636, 'Hematologia', 'Sucesivas', 'Consulta Sucesiva Anticoagulación Oral', 40.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (8672, 'Hematologia', 'Sucesivas', 'Consulta Sucesiva Anticoagulación Virtual', 40.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (8673, 'Hematologia', 'Sucesivas', 'Consulta sucesiva hematología Virtual', 40.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (7825, 'Hematologia', 'Sucesivas', 'Consulta HDI Hematología', 40.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (8718, 'Laboratorio', 'Laboratorio', 'ELISA Ac. Coronavirus. . Srm', 10.32);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (8622, 'Laboratorio', 'Laboratorio', 'PCR Coronavirus. . Exudado Nasofaríngeo', 64.67);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (8820, 'Laboratorio', 'Laboratorio', 'PCR Corona/Gripe/VRS. . Exudado Nasofaríngeo', 64.67);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (7971, 'Laboratorio', 'Laboratorio', 'Antígeno Gripe A/Gripe B . . Exudado', 7.1);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (4122, 'Laboratorio', 'Laboratorio', 'Orina, Estudio Mycoplasma-Ureaplasma', 12.1);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1750, 'Laboratorio', 'Laboratorio', 'Biopsia Páncreas ,Estudio Anpat', 163.22);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (2084, 'Laboratorio', 'Laboratorio', 'Calcio..Srm', 0.63);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (5186, 'Laboratorio', 'Laboratorio', 'Tiroglobulina..Srm', 30.27);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (4135, 'Laboratorio', 'Laboratorio', 'Urea..Liq', 3.76);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (2114, 'Laboratorio', 'Laboratorio', 'Colesterol de HDL..Srm', 3.3);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1652, 'Laboratorio', 'Laboratorio', 'Analisis Bioquimico de Liquido Sinovial', 11.89);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (7973, 'Laboratorio', 'Laboratorio', 'Fenotipo Eritrocitario..San', 9.75);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (2216, 'Laboratorio', 'Laboratorio', 'Hemograma..San', 3.26);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (3978, 'M.Interna', 'Ecografía', 'Ecografía torácica (AR)', 75.31);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (6709, 'M.Interna', 'Ecografía', 'MIN Ecografía Torácica', 75.31);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (6708, 'M.Interna', 'Ecografía', 'MIN Ecografía abdominal', 65.98);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (6707, 'M.Interna', 'Ecografía', 'MIN Ecocardiografía transtorácica', 81.03);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (6711, 'M.Interna', 'Ecografía', 'MIN Ecografía intervencionista', 214.87);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (6712, 'M.Interna', 'Ecografía', 'MIN Ecografía doppler de troncos supra', 136.95);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (3975, 'M.Interna', 'Ecografía', 'Ecografía venosa de compresión (AR)', 136.95);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (6710, 'M.Interna', 'Ecografía', 'MIN Ecografía venosa de compresión', 136.95);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (7386, 'M.Interna', 'Primeras', 'Primera Consulta No Presencial', 40.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (7718, 'M.Interna', 'Primeras', 'MIN Crónicos No Presencial', 40.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1602, 'M.Interna', 'Primeras', 'Primera consulta MIN-General', 65.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (5917, 'M.Interna', 'Primeras', 'Primera consulta MIN-Riesgo vascular', 65.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (5919, 'M.Interna', 'Primeras', 'Primera consulta MIN-Enf Tromboembólica', 65.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (7169, 'M.Interna', 'Primeras', 'Primera consulta MIN', 65.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1365, 'M.Interna', 'Pruebas', 'Paracentesis', 141.49);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1366, 'M.Interna', 'Pruebas', 'Toracocentesis', 209.93);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1367, 'M.Interna', 'Pruebas', 'Drenaje neumotorax', 154.15);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1364, 'M.Interna', 'Pruebas', 'Puncion lumbar', 214.87);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1581, 'M.Interna', 'Sucesivas', 'Consulta sucesiva MIN', 40.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (7696, 'M.Interna', 'Sucesivas', 'Consulta Sucesiva MIN Crónicos', 40.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1453, 'ORL', 'Primeras', 'Primera consulta ORL', 65.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (7209, 'ORL', 'Primeras', 'ORL no presencial', 40.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1458, 'ORL', 'Pruebas', 'Otomicroscopia', 37.07);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1459, 'ORL', 'Pruebas', 'Exploración vestibular básica', 37.07);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1461, 'ORL', 'Pruebas', 'Fibroendoscopia(endoscopia flexible)', 37.07);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1462, 'ORL', 'Pruebas', 'Telelaringoscopia (endoscopia rígida)', 37.07);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1463, 'ORL', 'Pruebas', 'Videoscopia', 37.07);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1464, 'ORL', 'Pruebas', 'Estroboscopia', 37.07);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1465, 'ORL', 'Pruebas', 'Biopsias endoscopicas de laringe', 37.07);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1467, 'ORL', 'Pruebas', 'Rino-Manometria', 37.07);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1468, 'ORL', 'Pruebas', 'Biopsia endoscopica de fosas nasales', 37.07);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (3730, 'ORL', 'Pruebas', 'Trousseau', 37.07);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1455, 'ORL', 'Pruebas', 'Audiometria tonal Liminal', 48.25);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1469, 'ORL', 'Pruebas', 'Audiometría', 48.25);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1457, 'ORL', 'Pruebas', 'Impedanciometria: Timpanometria y reflejo', 52.12);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1454, 'ORL', 'Sucesivas', 'Consulta sucesiva ORL', 40.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (4749, 'ORL', 'Sucesivas', 'Consulta Postquirurgica ORL', 40.02);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (2326, 'Radiología', 'Resonancia Magnética', 'RM Sacro-Sacroilíacas S/C Contraste', 255.15);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (2553, 'Radiología', 'Resonancia Magnética', 'RM Cerebral Sin Contraste', 255.15);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (2554, 'Radiología', 'Resonancia Magnética', 'RM Cerebral Con Contraste', 255.15);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (2474, 'Radiología', 'TAC', 'TC Cara y Senos Sin Contraste', 113.40);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (2475, 'Radiología', 'TAC', 'TC Cara y Senos Con Contraste', 113.40);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (2481, 'Radiología', 'TAC', 'TC Mandíbula S/C Contraste', 113.40);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (2482, 'Radiología', 'TAC', 'TC Cuello Sin Contraste', 113.40);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (2292, 'Radiología', 'Radiología Convencional', 'RX Tobillo AP/L Dcho', 38.30);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (2293, 'Radiología', 'Radiología Convencional', 'RX Tobillo AP/L Izdo', 38.30);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (2294, 'Radiología', 'Radiología Convencional', 'RX Tobillo AP/L Bilateral', 38.30);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (9000, 'Radiología', 'Radiología Convencional', 'RX Tórax PA/L', 24.70);
INSERT INTO clinical.tb_orders_catalog(order_code, category, subcategory, order_desc, cost) VALUES (1001, 'Radiología', 'Radiología Convencional', 'RX Tórax AP Decúbito', 24.70);

-- Data tb_orders
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (100,2084,458151,'Solicitada','2009-06-16 09:12','2011-06-08 14:08',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (101,2216,458151,'Solicitada','2009-06-16 09:12','2011-06-08 14:08',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (102,2144,458151,'Solicitada','2009-06-16 09:12','2011-06-08 14:08',3);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (103,4459,1017014,'Solicitada','2009-12-03 09:50','2013-02-06 14:35',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (104,2216,580497,'Solicitada','2010-02-24 12:21','2013-03-18 03:37',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (105,2216,580497,'Solicitada','2010-03-27 23:54','2019-02-28 02:00',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (106,2216,580497,'Solicitada','2010-03-22 12:43','2011-06-16 10:11',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (107,2144,580497,'Solicitada','2010-02-24 12:21','2013-03-18 03:37',8);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (108,2216,580497,'Solicitada','2010-03-04 08:55','2010-03-04 08:55',8);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (109,2144,580497,'Solicitada','2010-03-04 08:55','2010-03-04 08:55',8);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (110,2144,580497,'Solicitada','2010-03-04 09:00','2010-03-04 09:01',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (111,2216,580497,'Solicitada','2010-03-04 09:00','2010-03-04 09:01',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (112,2114,580497,'Solicitada','2010-02-24 12:21','2013-03-18 03:37',3);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (113,2144,580497,'Solicitada','2010-03-22 12:43','2011-06-16 10:11',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (114,2216,11816109,'Solicitada','2016-01-08 11:18','2016-01-10 18:01',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (115,2144,11816109,'Solicitada','2016-01-08 11:18','2016-01-10 18:01',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (116,2144,11816109,'Realizada','2016-01-08 11:17','2016-01-09 10:55',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (117,2216,11816109,'Realizada','2016-01-08 11:17','2016-01-09 10:10',8);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (118,2216,11701607,'Realizada','2016-01-11 11:11','2016-01-12 09:41',8);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (119,2144,11958246,'Realizada','2016-01-11 13:46','2016-01-11 15:13',8);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (120,2216,11612862,'Realizada','2016-01-11 16:14','2016-01-11 17:20',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (121,2216,11958246,'Realizada','2016-01-11 13:46','2016-01-11 15:02',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (122,2144,11701607,'Realizada','2016-01-11 11:11','2016-01-12 09:48',3);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (123,2216,11274397,'Realizada','2016-01-12 10:28','2016-01-13 10:13',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (124,2216,11557170,'Realizada','2016-01-13 18:55','2016-01-16 11:58',12);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (125,2144,11557170,'Realizada','2016-01-13 18:55','2016-01-16 12:40',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (126,2216,11557170,'Realizada','2016-01-13 18:54','2016-01-14 10:33',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (127,2144,11557170,'Realizada','2016-01-13 18:54','2016-01-14 09:39',8);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (128,2144,11435938,'Realizada','2016-01-18 11:58','2016-01-19 09:20',8);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (129,2216,11435938,'Realizada','2016-01-18 11:58','2016-01-19 09:20',8);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (130,2216,11346997,'Realizada','2016-01-19 15:09','2016-01-20 07:04',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (131,2216,11387155,'Realizada','2016-01-19 12:17','2016-01-20 09:10',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (132,2144,11903656,'Solicitada','2016-01-20 21:50','2016-01-24 10:23',3);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (133,2216,11903656,'Solicitada','2016-01-20 21:50','2016-01-24 10:21',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (134,2216,11435938,'Realizada','2016-01-20 12:46','2016-01-21 10:55',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (135,2144,11477068,'Realizada','2016-01-22 12:14','2016-01-23 09:29',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (136,2216,11477068,'Realizada','2016-01-22 12:14','2016-01-23 09:29',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (137,2216,10963484,'Realizada','2016-01-25 10:00','2016-01-26 09:54',8);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (138,2216,11323622,'Realizada','2016-01-28 12:42','2016-01-29 10:43',11);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (139,2216,11579647,'Realizada','2016-02-01 11:19','2016-02-02 10:14',12);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (140,2216,11691278,'Realizada','2016-02-04 14:02','2016-02-05 10:21',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (141,2216,11658882,'Realizada','2016-02-09 11:03','2016-02-10 09:26',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (142,2216,11734190,'Realizada','2016-02-16 16:07','2016-02-17 09:38',3);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (143,2216,11833617,'Realizada','2016-02-22 11:58','2016-02-23 11:21',11);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (144,2216,11845841,'Realizada','2016-02-23 15:30','2016-02-24 09:54',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (145,2144,458151,'Realizada','2016-02-25 14:30','2016-03-29 12:23',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (146,2216,458151,'Realizada','2016-02-25 14:30','2016-03-29 11:32',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (147,2216,11772308,'Realizada','2016-02-29 14:36','2016-03-01 15:11',8);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (148,2216,11950341,'Solicitada','2016-03-01 09:54','2016-03-03 08:22',12);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (149,2216,11950341,'Realizada','2016-03-02 15:36','2016-03-03 09:38',8);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (150,2216,11950341,'Solicitada','2016-03-03 09:08','2016-03-04 08:19',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (151,2144,11919941,'Realizada','2016-03-17 12:13','2016-03-18 09:26',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (152,2216,11919941,'Realizada','2016-03-17 12:13','2016-03-18 09:08',3);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (153,2216,11155949,'Realizada','2016-05-02 09:51','2016-05-03 12:05',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (154,2144,11155949,'Realizada','2016-05-03 12:55','2016-05-04 09:24',11);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (155,2216,11155949,'Realizada','2016-05-03 12:55','2016-05-04 08:54',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (156,2216,11155949,'Realizada','2016-05-05 12:46','2016-05-06 11:03',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (157,2144,11155949,'Realizada','2016-05-05 12:46','2016-05-06 10:21',8);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (158,2216,11962017,'Realizada','2017-02-08 07:40','2017-02-08 09:21',8);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (159,2144,11962017,'Solicitada','2017-02-08 17:49','2017-02-09 12:21',8);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (160,2216,11962017,'Realizada','2017-02-08 17:49','2017-02-09 10:03',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (161,2216,11962017,'Solicitada','2017-02-08 18:39','2017-02-09 10:35',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (162,2144,11962017,'Realizada','2017-02-08 18:15','2017-02-11 09:50',3);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (163,2084,11962017,'Realizada','2017-02-08 18:26','2017-02-08 19:11',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (164,2144,11962017,'Solicitada','2017-02-08 21:28','2017-02-09 12:24',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (165,2216,11962017,'Solicitada','2017-02-08 21:28','2017-02-09 10:35',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (166,2144,11962017,'Realizada','2017-02-08 18:26','2017-02-08 19:11',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (167,2216,11962017,'Realizada','2017-02-08 18:15','2017-02-11 09:50',8);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (168,2216,11962017,'Realizada','2017-02-08 18:26','2017-02-08 19:11',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (169,2144,11962017,'Realizada','2017-02-08 18:39','2017-02-09 10:03',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (170,2216,11962017,'Realizada','2017-02-11 13:26','2017-02-12 08:19',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (171,2144,11962017,'Realizada','2017-02-11 13:26','2017-02-12 08:41',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (172,2216,636475,'Realizada','2018-09-25 10:31','2018-09-27 10:57',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (173,2114,636475,'Realizada','2018-09-25 10:31','2018-09-27 14:41',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (174,2144,636475,'Realizada','2018-09-25 10:31','2018-09-27 14:41',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (175,2114,920935,'Realizada','2019-05-27 12:55','2019-06-11 12:22',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (176,2144,920935,'Realizada','2019-05-27 12:55','2019-06-11 12:23',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (177,2216,920935,'Realizada','2019-05-27 12:55','2019-06-11 14:18',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (178,2216,11984109,'Solicitada','2016-01-11 08:21','2016-01-12 08:32',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (179,2084,11735839,'Realizada','2016-01-13 13:41','2016-01-13 16:15',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (180,2144,11735839,'Realizada','2016-01-13 13:41','2016-01-13 16:15',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (181,2216,11735839,'Realizada','2016-01-13 13:41','2016-01-13 14:53',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (182,2216,11515795,'Solicitada','2016-01-17 14:30','2016-01-18 09:10',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (183,2216,11515795,'Realizada','2016-01-17 12:16','2016-01-17 14:05',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (184,2216,11356518,'Realizada','2016-01-18 11:46','2016-01-19 09:20',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (185,2144,11356518,'Realizada','2016-01-18 11:46','2016-01-19 09:20',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (186,2216,11515795,'Realizada','2016-01-18 19:35','2016-01-18 20:17',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (187,2216,11515795,'Realizada','2016-01-18 02:13','2016-01-18 02:27',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (188,3730,11938118,'Realizada','2016-01-19 11:40','2016-01-19 13:22',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (189,2216,11666570,'Realizada','2016-01-19 13:00','2016-01-20 07:04',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (190,2084,11938118,'Realizada','2016-01-20 08:09','2016-01-20 09:34',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (191,2216,11025100,'Realizada','2016-01-26 14:21','2016-01-27 08:30',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (192,2216,11691543,'Realizada','2016-01-25 19:44','2016-01-26 09:40',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (193,2144,11025100,'Realizada','2016-01-26 14:21','2016-01-27 08:47',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (194,2216,11025100,'Realizada','2016-01-26 14:20','2016-01-26 18:15',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (195,2216,11387479,'Realizada','2016-01-26 12:29','2016-01-27 10:04',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (196,2144,11494654,'Realizada','2016-01-29 15:42','2016-01-30 10:18',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (197,2216,11494654,'Realizada','2016-01-29 15:42','2016-01-30 10:18',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (198,2216,11705396,'Realizada','2016-01-28 10:06','2016-01-29 07:03',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (199,2084,11779257,'Realizada','2016-02-03 17:45','2016-02-03 19:59',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (200,2216,11779257,'Realizada','2016-02-03 13:31','2016-02-03 14:25',1);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (201,2216,11779257,'Realizada','2016-02-03 17:47','2016-02-04 09:16',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (202,2144,11779257,'Realizada','2016-02-03 17:47','2016-02-04 08:40',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (203,2144,11779257,'Realizada','2016-02-03 13:31','2016-02-03 14:24',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (204,2216,11779257,'Realizada','2016-02-03 14:51','2016-02-03 15:22',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (205,2144,11779257,'Realizada','2016-02-03 17:45','2016-02-03 19:52',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (206,2084,11779257,'Realizada','2016-02-03 17:47','2016-02-04 08:40',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (207,2216,11779257,'Realizada','2016-02-03 17:45','2016-02-03 19:30',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (208,2144,11779257,'Realizada','2016-02-05 12:41','2016-02-07 09:26',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (209,2084,11779257,'Realizada','2016-02-05 12:41','2016-02-07 09:26',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (210,2144,11779257,'Realizada','2016-02-05 10:38','2016-02-05 12:03',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (211,2216,11779257,'Realizada','2016-02-05 10:38','2016-02-05 11:36',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (212,2216,11779257,'Realizada','2016-02-05 12:41','2016-02-07 08:56',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (213,2216,10363733,'Realizada','2016-02-08 12:45','2016-02-09 09:41',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (214,2144,11588064,'Realizada','2016-02-09 15:03','2016-02-10 09:59',11);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (215,2216,11588064,'Realizada','2016-02-09 15:03','2016-02-10 09:27',11);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (216,2084,11779257,'Realizada','2016-02-10 12:29','2016-02-11 08:22',11);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (217,2216,11779257,'Realizada','2016-02-10 12:29','2016-02-11 07:25',12);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (218,2216,10363733,'Realizada','2016-02-11 10:12','2016-02-11 11:45',12);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (219,1369,10363733,'Realizada','2016-02-11 14:03','2016-02-12 13:31',12);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (220,2216,11849659,'Realizada','2016-02-15 10:50','2016-02-16 09:29',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (221,2216,11863641,'Realizada','2016-02-19 11:28','2016-02-20 09:04',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (222,2144,11863641,'Realizada','2016-02-19 11:28','2016-02-20 09:09',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (223,2216,11557185,'Realizada','2016-02-24 18:11','2016-02-25 10:51',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (224,2216,11557185,'Realizada','2016-02-24 15:15','2016-02-24 15:24',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (225,2144,11557185,'Realizada','2016-02-24 18:11','2016-02-25 10:21',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (226,2144,11557185,'Realizada','2016-02-24 18:11','2016-02-27 09:52',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (227,2216,11557185,'Realizada','2016-02-24 18:11','2016-02-27 09:47',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (228,2216,11309674,'Realizada','2016-03-04 08:32','2016-03-07 10:32',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (229,2216,11309674,'Realizada','2016-03-04 11:08','2016-03-04 11:41',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (230,2144,11309674,'Realizada','2016-03-04 08:31','2016-03-07 10:16',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (231,2144,11309674,'Realizada','2016-03-04 16:45','2016-03-05 09:41',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (232,2216,11309674,'Realizada','2016-03-04 16:45','2016-03-05 09:40',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (233,2216,11895394,'Realizada','2016-03-07 12:10','2016-03-08 09:17',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (234,2216,11323999,'Realizada','2016-03-08 12:31','2016-03-09 09:44',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (235,2216,11921586,'Realizada','2016-03-11 09:30','2016-03-12 09:27',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (236,2216,11772320,'Realizada','2016-03-14 12:25','2016-03-15 12:12',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (237,2216,11977300,'Realizada','2016-03-19 10:16','2016-03-19 10:46',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (238,2144,145239,'Realizada','2016-06-13 12:24','2016-07-01 12:38',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (239,2216,145239,'Realizada','2016-06-13 12:24','2016-07-01 10:57',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (240,2216,11817162,'Realizada','2017-01-25 07:50','2017-01-25 09:20',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (241,2144,11817162,'Realizada','2017-01-25 10:27','2017-01-28 09:41',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (242,2216,11817162,'Solicitada','2017-01-25 17:23','2017-01-29 13:57',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (243,2216,11817162,'Realizada','2017-01-25 22:29','2017-01-25 23:10',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (244,2144,11817162,'Realizada','2017-01-25 10:25','2017-01-26 09:45',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (245,2216,11817162,'Realizada','2017-01-25 10:27','2017-01-28 09:28',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (246,2216,11817162,'Realizada','2017-01-25 10:25','2017-01-25 17:51',2);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (247,2216,11817162,'Realizada','2017-01-26 08:11','2017-01-26 09:34',3);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (248,2084,77276,'Solicitada','2009-02-09 09:30','2015-12-02 12:15',3);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (249,2144,77276,'Solicitada','2009-02-09 09:30','2015-12-02 12:15',3);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (250,2216,77276,'Solicitada','2009-02-09 09:30','2015-12-02 12:15',3);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (251,2216,11516744,'Realizada','2015-12-30 09:38','2016-01-02 08:27',3);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (252,2144,11516744,'Realizada','2015-12-30 09:38','2016-01-02 09:22',3);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (253,2144,77276,'Realizada','2015-12-30 12:58','2016-01-07 14:41',3);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (254,2216,77276,'Realizada','2015-12-30 12:58','2016-01-07 13:21',3);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (255,2144,11516744,'Realizada','2015-12-30 09:38','2015-12-31 09:57',3);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (256,2216,11516744,'Realizada','2015-12-30 09:38','2015-12-31 09:48',3);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (257,2216,11516744,'Solicitada','2015-12-31 09:39','2016-01-02 13:22',3);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (258,2144,11516744,'Solicitada','2015-12-31 09:39','2016-01-02 13:22',3);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (259,2144,11818831,'Realizada','2016-01-08 14:14','2016-01-08 15:43',3);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (260,2216,11818831,'Realizada','2016-01-08 14:14','2016-01-08 15:03',3);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (261,3730,11745383,'Realizada','2016-01-11 13:37','2016-01-11 14:42',3);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (262,2084,11827570,'Realizada','2016-01-12 13:55','2016-01-12 20:59',3);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (263,3730,11827570,'Realizada','2016-01-12 13:56','2016-01-12 18:06',3);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (264,2084,11827570,'Realizada','2016-01-13 13:24','2016-01-14 08:01',3);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (265,2084,11827570,'Realizada','2016-01-13 08:16','2016-01-13 09:31',3);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (266,2084,11827570,'Solicitada','2016-01-13 13:23','2016-01-13 13:42',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (267,2216,11959048,'Realizada','2016-01-14 11:15','2016-01-14 12:09',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (268,2216,11495918,'Realizada','2016-01-14 11:16','2016-01-15 09:13',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (269,2144,11592697,'Realizada','2016-01-15 15:59','2016-01-15 17:13',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (270,2216,11592697,'Realizada','2016-01-15 16:00','2016-01-15 16:58',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (271,2216,11408319,'Realizada','2016-01-15 12:03','2016-01-16 11:58',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (272,2216,11311138,'Realizada','2016-01-15 09:53','2016-01-16 11:58',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (273,2144,11408319,'Realizada','2016-01-15 12:03','2016-01-16 12:11',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (274,2216,11324990,'Realizada','2016-01-18 11:42','2016-01-19 09:21',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (275,2216,11311138,'Realizada','2016-01-18 15:07','2016-01-19 09:20',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (276,2144,11324990,'Realizada','2016-01-18 11:42','2016-01-19 09:21',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (277,2216,11495918,'Realizada','2016-01-19 11:24','2016-01-19 13:05',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (278,6707,11495918,'Realizada','2016-01-20 10:27','2016-01-20 12:44',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (279,2144,11668786,'Solicitada','2016-01-20 14:08','2016-01-21 10:38',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (280,2144,11668786,'Realizada','2016-01-20 16:55','2016-01-23 09:28',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (281,2216,11668786,'Solicitada','2016-01-20 14:08','2016-01-21 16:29',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (282,2144,11668786,'Realizada','2016-01-20 18:55','2016-01-20 20:01',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (283,2216,11950579,'Realizada','2016-01-20 20:27','2016-01-20 20:51',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (284,2216,11668786,'Realizada','2016-01-20 18:55','2016-01-20 19:45',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (285,2216,11668786,'Realizada','2016-01-20 16:55','2016-01-23 09:28',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (286,2216,11668786,'Realizada','2016-01-22 08:27','2016-01-22 10:50',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (287,2144,11668786,'Realizada','2016-01-22 08:27','2016-01-22 11:25',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (288,2216,11364844,'Realizada','2016-01-26 15:30','2016-01-27 09:33',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (289,2144,11364844,'Realizada','2016-01-26 15:30','2016-01-27 09:44',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (290,2144,11775194,'Realizada','2016-01-29 11:15','2016-01-30 10:16',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (291,2216,11775194,'Realizada','2016-01-29 11:15','2016-01-30 10:16',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (292,2216,11426225,'Realizada','2016-01-29 12:37','2016-01-30 10:18',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (293,2216,11785864,'Solicitada','2016-01-30 13:13','2016-02-01 08:42',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (294,2216,11426225,'Realizada','2016-01-30 12:09','2016-01-31 08:48',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (295,2216,11785864,'Realizada','2016-01-30 13:11','2016-01-30 14:19',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (296,2144,11426225,'Realizada','2016-01-30 12:09','2016-01-31 09:08',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (297,2216,11719766,'Realizada','2016-01-30 12:56','2016-01-30 16:56',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (298,2216,11577940,'Realizada','2016-02-01 09:20','2016-02-02 09:49',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (299,2144,11577940,'Realizada','2016-02-01 09:20','2016-02-02 10:15',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (300,2216,11834876,'Realizada','2016-02-01 20:39','2016-02-02 13:02',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (301,2144,11834876,'Solicitada','2016-02-01 10:12','2016-02-02 08:19',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (302,2216,11834876,'Solicitada','2016-02-01 10:12','2016-02-02 08:19',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (303,2144,11834876,'Realizada','2016-02-01 14:48','2016-02-02 10:11',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (304,2084,11834876,'Solicitada','2016-02-01 20:39','2016-02-02 11:51',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (305,2144,11834876,'Solicitada','2016-02-01 20:39','2016-02-02 11:51',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (306,2216,11834876,'Solicitada','2016-02-01 14:48','2016-02-02 11:50',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (307,2216,11834876,'Solicitada','2016-02-02 09:50','2016-02-03 08:40',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (308,2144,11577940,'Realizada','2016-02-02 11:58','2016-02-03 09:43',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (309,2216,11577940,'Realizada','2016-02-02 11:58','2016-02-03 09:15',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (310,2216,11767183,'Realizada','2016-02-04 12:02','2016-02-04 12:54',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (311,2216,11834876,'Realizada','2016-02-04 10:57','2016-02-05 10:21',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (312,2084,11834876,'Realizada','2016-02-04 10:57','2016-02-05 12:20',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (313,2144,11834876,'Realizada','2016-02-04 10:57','2016-02-05 12:20',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (314,2144,11807052,'Realizada','2016-02-05 11:41','2016-02-06 10:25',4);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (315,2216,11807052,'Realizada','2016-02-05 11:41','2016-02-06 10:25',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (316,2144,796745,'Realizada','2016-02-09 11:10','2016-02-11 09:59',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (317,2114,796745,'Realizada','2016-02-09 11:10','2016-02-11 09:59',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (318,2216,796745,'Realizada','2016-02-09 11:10','2016-02-11 11:52',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (319,2216,11834876,'Realizada','2016-02-09 11:18','2016-02-10 10:19',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (320,2144,11834876,'Realizada','2016-02-09 11:18','2016-02-10 10:14',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (321,2084,11834876,'Realizada','2016-02-09 11:18','2016-02-10 10:14',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (322,2216,11268371,'Realizada','2016-02-15 12:27','2016-02-16 10:24',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (323,2216,11693879,'Realizada','2016-02-22 11:22','2016-02-23 10:53',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (324,2216,11885195,'Realizada','2016-02-23 09:47','2016-02-24 09:54',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (325,2216,11631481,'Realizada','2016-02-26 16:25','2016-02-26 16:51',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (326,2144,11631481,'Solicitada','2016-02-26 17:48','2016-02-28 09:45',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (327,2216,11631481,'Solicitada','2016-02-26 17:48','2016-02-28 09:45',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (328,2144,11631481,'Realizada','2016-02-26 16:25','2016-02-26 17:10',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (329,2144,11631481,'Realizada','2016-02-26 22:43','2016-02-26 23:33',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (330,2216,11631481,'Realizada','2016-02-26 22:43','2016-02-26 23:10',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (331,2144,11631481,'Realizada','2016-02-27 14:17','2016-02-28 08:37',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (332,2216,11631481,'Realizada','2016-02-27 08:14','2016-02-27 08:38',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (333,2216,11631481,'Realizada','2016-02-27 14:17','2016-02-28 08:29',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (334,2216,11631481,'Realizada','2016-02-28 23:21','2016-02-29 11:09',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (335,2144,11949782,'Realizada','2016-02-29 11:28','2016-03-01 09:37',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (336,2144,11631481,'Realizada','2016-02-28 23:21','2016-02-29 10:57',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (337,2216,11949782,'Realizada','2016-02-29 11:28','2016-03-01 09:23',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (338,2216,11949782,'Realizada','2016-03-03 09:13','2016-03-03 09:44',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (339,2216,11911816,'Realizada','2016-03-15 15:12','2016-03-16 09:17',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (340,2216,11911816,'Realizada','2016-03-16 16:38','2016-03-17 09:15',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (341,2216,11911816,'Solicitada','2016-03-16 16:33','2016-03-17 08:08',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (342,2144,11966931,'Realizada','2016-03-21 12:01','2016-03-22 10:06',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (343,2216,11966931,'Realizada','2016-03-21 12:01','2016-03-22 09:28',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (344,2216,11977617,'Realizada','2016-04-05 16:46','2016-04-06 08:45',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (345,2144,11977617,'Realizada','2016-04-06 14:44','2016-04-07 10:54',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (346,2084,11977617,'Realizada','2016-04-06 14:44','2016-04-07 10:54',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (347,2216,11977617,'Solicitada','2016-04-07 20:34','2016-04-08 09:05',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (348,2216,11977617,'Realizada','2016-04-06 14:44','2016-04-07 10:31',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (349,2144,11977617,'Realizada','2016-04-07 13:22','2016-04-08 09:22',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (350,7636,11977617,'Realizada','2016-04-07 14:54','2016-05-11 14:37',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (351,2216,11977617,'Realizada','2016-04-07 13:22','2016-04-08 09:22',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (352,2216,11977617,'Solicitada','2016-04-08 10:13','2016-04-10 10:40',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (353,2216,11984729,'Realizada','2016-04-18 11:27','2016-04-19 09:50',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (354,2216,732332,'Realizada','2016-09-07 12:57','2016-09-16 13:35',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (355,2114,732332,'Realizada','2016-09-07 12:57','2016-09-16 11:02',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (356,2144,732332,'Realizada','2016-09-07 12:57','2016-09-16 11:02',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (357,1581,78919,'Cancelada','2009-02-09 14:58','2009-02-09 14:59',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (358,1454,416315,'Cancelada','2009-06-02 09:09','2009-06-02 09:09',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (359,1454,750284,'Cancelada','2009-09-16 13:05','2009-09-16 13:05',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (360,1454,691529,'Solicitada','2009-08-28 10:42','2009-09-08 11:36',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (361,2216,952783,'Cancelada','2009-11-13 11:59','2009-11-13 11:59',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (362,1454,1087486,'Cancelada','2009-12-23 10:49','2009-12-23 10:49',5);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (363,2144,952783,'Cancelada','2009-11-13 11:59','2009-11-13 11:59',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (364,2216,11687014,'Realizada','2015-08-28 10:11','2015-08-28 11:48',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (365,2216,11466315,'Realizada','2016-01-08 11:15','2016-01-09 09:57',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (366,2216,11961049,'Realizada','2016-01-08 14:13','2016-01-08 14:40',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (367,2144,11466315,'Realizada','2016-01-08 11:15','2016-01-09 10:18',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (368,2216,11903343,'Realizada','2016-01-08 19:17','2016-01-09 10:03',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (369,2144,11903343,'Realizada','2016-01-08 19:17','2016-01-09 10:18',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (370,2144,11961049,'Realizada','2016-01-08 14:13','2016-01-08 15:01',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (371,2216,11466315,'Realizada','2016-01-09 11:39','2016-01-10 09:10',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (372,2216,11466315,'Realizada','2016-01-10 11:28','2016-01-11 10:24',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (373,2144,11466315,'Realizada','2016-01-10 11:28','2016-01-11 09:51',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (374,2216,11269924,'Realizada','2016-01-11 09:20','2016-01-12 10:52',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (375,2144,11885729,'Realizada','2016-01-11 14:03','2016-01-12 09:46',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (376,2216,11885729,'Realizada','2016-01-11 14:03','2016-01-12 10:03',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (377,2216,11903343,'Realizada','2016-01-12 09:28','2016-01-12 10:29',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (378,2144,11903343,'Realizada','2016-01-12 09:28','2016-01-12 10:29',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (379,2144,11314182,'Realizada','2016-01-12 07:59','2016-01-12 09:48',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (380,2216,11314182,'Realizada','2016-01-12 07:59','2016-01-12 10:00',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (381,2216,11379561,'Realizada','2016-01-12 13:20','2016-01-13 08:16',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (382,2216,11314182,'Solicitada','2016-01-13 11:37','2016-01-15 09:22',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (383,2144,11314182,'Realizada','2016-01-13 11:37','2016-01-14 09:41',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (384,2216,11314182,'Realizada','2016-01-13 08:59','2016-01-14 11:27',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (385,2216,11314182,'Realizada','2016-01-14 13:17','2016-01-15 09:13',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (386,2216,11314182,'Solicitada','2016-01-15 21:08','2016-01-15 21:09',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (387,2144,11314182,'Realizada','2016-01-15 21:10','2016-01-16 08:36',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (388,2216,11314182,'Realizada','2016-01-15 21:10','2016-01-16 08:10',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (389,2216,11314182,'Realizada','2016-01-15 21:09','2016-01-16 08:36',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (390,2084,11950311,'Realizada','2016-01-16 13:31','2016-01-17 07:41',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (391,2144,11314182,'Realizada','2016-01-16 12:56','2016-01-18 10:35',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (392,2216,11314182,'Realizada','2016-01-16 12:56','2016-01-18 13:00',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (393,2216,11496400,'Realizada','2016-01-18 14:36','2016-01-19 09:20',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (394,2216,11979904,'Realizada','2016-01-18 15:43','2016-01-18 15:58',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (395,2216,11314182,'Realizada','2016-01-18 11:53','2016-01-18 12:55',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (396,2144,11496400,'Realizada','2016-01-19 11:39','2016-01-21 10:01',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (397,2144,11819185,'Realizada','2016-01-22 13:05','2016-01-25 11:39',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (398,2216,11819185,'Realizada','2016-01-22 13:05','2016-01-25 10:42',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (399,2144,11819185,'Realizada','2016-01-22 13:03','2016-01-23 09:29',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (400,2216,11819185,'Realizada','2016-01-22 13:03','2016-01-23 09:29',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (401,2216,11434862,'Realizada','2016-01-25 12:59','2016-01-26 09:28',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (402,2216,11434862,'Realizada','2016-01-28 08:31','2016-01-28 10:35',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (403,2216,11434862,'Solicitada','2016-01-28 10:36','2016-01-28 10:38',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (404,2216,11547602,'Realizada','2016-01-28 13:31','2016-01-29 09:34',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (405,2144,11547602,'Realizada','2016-01-28 13:31','2016-01-29 09:54',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (406,2216,11694898,'Realizada','2016-02-01 11:25','2016-02-02 09:49',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (407,2216,11694898,'Solicitada','2016-02-02 09:47','2016-02-03 08:40',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (408,2216,11955552,'Realizada','2016-02-05 14:07','2016-02-06 10:25',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (409,2216,11724071,'Realizada','2016-02-05 10:59','2016-02-06 07:04',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (410,2216,11787440,'Realizada','2016-02-05 18:12','2016-02-05 18:56',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (411,2144,11955552,'Realizada','2016-02-05 14:07','2016-02-06 10:25',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (412,2216,10694717,'Realizada','2016-02-05 12:41','2016-02-06 10:26',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (413,2144,11597878,'Realizada','2016-02-08 09:07','2016-02-09 09:54',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (414,2216,11597878,'Realizada','2016-02-08 09:07','2016-02-09 09:42',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (415,2216,11412198,'Realizada','2016-02-09 08:27','2016-02-09 09:38',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (416,2144,11412198,'Realizada','2016-02-09 10:07','2016-02-10 09:42',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (417,2144,11412198,'Realizada','2016-02-09 08:27','2016-02-09 09:49',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (418,2216,11412198,'Solicitada','2016-02-09 10:07','2016-02-11 08:33',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (419,2144,11412198,'Solicitada','2016-02-09 14:56','2016-02-11 08:34',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (420,2216,11412198,'Realizada','2016-02-09 14:56','2016-02-10 09:20',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (421,2144,11579397,'Realizada','2016-02-15 09:08','2016-02-16 09:41',6);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (422,2216,11579397,'Realizada','2016-02-15 09:08','2016-02-16 09:29',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (423,2216,11775542,'Realizada','2016-02-16 13:02','2016-02-17 12:27',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (424,2216,11775542,'Realizada','2016-02-17 16:28','2016-02-18 11:36',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (425,2144,11932659,'Realizada','2016-02-29 08:41','2016-02-29 09:47',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (426,2144,11932659,'Realizada','2016-02-29 19:57','2016-03-01 10:55',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (427,2084,11932659,'Realizada','2016-02-29 08:41','2016-02-29 09:47',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (428,2216,11932659,'Realizada','2016-02-29 08:41','2016-02-29 09:28',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (429,2216,11932659,'Realizada','2016-02-29 19:57','2016-03-01 10:34',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (430,2084,11932659,'Realizada','2016-02-29 19:57','2016-03-01 10:55',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (431,2216,11811018,'Realizada','2016-03-11 12:41','2016-03-12 07:03',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (432,2144,11986674,'Realizada','2016-04-04 11:42','2016-04-05 09:54',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (433,2216,11986674,'Realizada','2016-04-04 11:42','2016-04-05 09:40',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (434,2216,11053098,'Realizada','2016-05-23 09:19','2016-05-23 10:05',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (435,2144,11053098,'Realizada','2016-05-23 14:47','2016-05-24 09:53',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (436,2216,11053098,'Realizada','2016-05-23 14:47','2016-05-24 09:31',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (437,2216,11053098,'Realizada','2016-05-25 11:22','2016-05-26 10:16',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (438,2144,11053098,'Realizada','2016-05-25 11:22','2016-05-26 10:16',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (439,2216,11053098,'Realizada','2016-05-28 12:18','2016-05-28 13:00',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (440,2144,349048,'Realizada','2019-01-02 10:53','2019-03-06 11:46',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (441,2114,349048,'Realizada','2019-01-02 10:53','2019-03-06 11:46',7);
INSERT INTO clinical.tb_orders(order_id, order_code, encounter_id, status, created_dt, status_dt, created_by_user) VALUES (442,2216,349048,'Realizada','2019-01-02 10:53','2019-03-06 12:49',7);

CREATE TABLE PHU_GROUP
(
	PHU_GROUP_ID INT IDENTITY(1,1),
	PHU_GROUP_NAME VARCHAR(255),
	CREATED_DATE DATETIME,
	UPDATED_DATE DATETIME,
	CONSTRAINT PK_PG PRIMARY KEY(PHU_GROUP_ID)
)
GO

CREATE TABLE AGE_GROUP
(
	AGE_GROUP_ID INT IDENTITY(1,1),
	AGE_GROUP_TYPE VARCHAR(255),
	CREATED_DATE DATETIME,
	UPDATED_DATE DATETIME,
	CONSTRAINT PK_AG PRIMARY KEY(AGE_GROUP_ID)
)
GO

CREATE TABLE COMPILED_CASE_DETAILS
(
	ID INT IDENTITY(1,1),
	OBJECT_ID VARCHAR(255),
	ROW_ID VARCHAR(255),
	DATE_REPORTED DATETIME,
	PHU_ID INT,
	AGE_GROUP_ID INT,
	GENDER VARCHAR(255),
	EXPOSURE VARCHAR(255),
	CASE_STATUS VARCHAR(255),
	PROVINCE VARCHAR(255),
	CREATED_DATE DATETIME,
	UPDATED_DATE DATETIME,
	CONSTRAINT PK_CCD PRIMARY KEY(ID)
)
GO

CREATE TABLE CASE_REPORT
(
	CASE_REPORT_ID INT IDENTITY(1,1),
	ID INT,
	OUTCOME VARCHAR(255),
	GENDER VARCHAR(255),
	REPORTING_PHU_ID INT,
	SPECIMEN_DATE DATE,
	CASE_REPORTED_DATE DATE,
	TEST_REPORTED_DATE DATE,
	CASE_ACQUISITION_INFO VARCHAR(255),
	ACCURATE_EPISODE_DT DATE,
	OUTBREAK_RELATED VARCHAR(255),
	AGE_ID INT,
	CREATED_DATE DATETIME,
	UPDATED_DATE DATETIME,
	CONSTRAINT PK_CR PRIMARY KEY(CASE_REPORT_ID)
)
GO

CREATE TABLE OUTBREAK_GROUP
(
	OUTBREAK_GROUP_ID INT IDENTITY(1,1),
	OUTBREAK_GROUP_NAME VARCHAR(255),
	CREATED_DATE DATETIME,
	UPDATED_DATE DATETIME,
	CONSTRAINT PK_OG PRIMARY KEY(OUTBREAK_GROUP_ID)
)
GO

CREATE TABLE ONGOING_OUTBREAK_PHU
(
	ONGOING_OUTBREAK_PHU_ID INT IDENTITY(1,1),
	DATE DATE,
	PHU_NUM INT,
	OUTBREAK_GROUP_ID INT,
	NUMBER_ONGOING_OUTBREAKS INT,
	CREATED_DATE DATETIME,
	UPDATED_DATE DATETIME,
	CONSTRAINT PK_OOP PRIMARY KEY(ONGOING_OUTBREAK_PHU_ID)
)
GO

CREATE TABLE VACCINES_BY_AGE
(
	VACCINES_BY_AGE_ID INT IDENTITY(1,1),
	DATE DATE,
	PHU_ID INT,
	AGE_GROUP_ID INT,
	AT_LEAST_ONE_DOSE_CUMULATIVE INT,
	SECOND_DOSE_CUMULATIVE INT,
	FULLY_VACCINATED_CUMULATIVE INT,
	THIRD_DOSE_CUMULATIVE INT,
	CREATED_DATE DATETIME,
	UPDATED_DATE DATETIME,
	CONSTRAINT PK_VBA PRIMARY KEY(VACCINES_BY_AGE_ID)
)
GO

CREATE TABLE PHU
(
	ID INT IDENTITY(1,1),
	PHU_ID VARCHAR(255),
	PHU VARCHAR(255),
	PHU_GROUP_ID INT,
	ADDRESS VARCHAR(255),
	CITY VARCHAR(255),
	POSTALCODE VARCHAR(255),
	WEBSITE VARCHAR(255),
	LATITUDE VARCHAR(255),
	LONGITUDE VARCHAR(255),
	CREATED_DATE DATETIME,
	UPDATED_DATE DATETIME,
	CONSTRAINT PK_P PRIMARY KEY(ID)
)
GO

ALTER TABLE COMPILED_CASE_DETAILS
ADD CONSTRAINT FK_CCD_AG
FOREIGN KEY(AGE_GROUP_ID)
REFERENCES AGE_GROUP
ON UPDATE NO ACTION
GO

ALTER TABLE CASE_REPORT
ADD CONSTRAINT FK_CR_AG
FOREIGN KEY(AGE_ID)
REFERENCES AGE_GROUP
ON UPDATE NO ACTION
GO

ALTER TABLE VACCINES_BY_AGE
ADD CONSTRAINT FK_VBA_AG
FOREIGN KEY(AGE_GROUP_ID)
REFERENCES AGE_GROUP
ON UPDATE NO ACTION
GO

ALTER TABLE ONGOING_OUTBREAK_PHU
ADD CONSTRAINT FK_OOP_OG
FOREIGN KEY(OUTBREAK_GROUP_ID)
REFERENCES OUTBREAK_GROUP
ON UPDATE NO ACTION
GO

ALTER TABLE PHU
ADD CONSTRAINT FK_P_PG
FOREIGN KEY(PHU_GROUP_ID)
REFERENCES PHU_GROUP
ON UPDATE NO ACTION
GO

ALTER TABLE COMPILED_CASE_DETAILS
ADD CONSTRAINT FK_CCD_P
FOREIGN KEY(PHU_ID)
REFERENCES PHU
ON UPDATE NO ACTION
GO

ALTER TABLE CASE_REPORT
ADD CONSTRAINT FK_CR_P
FOREIGN KEY(REPORTING_PHU_ID)
REFERENCES PHU
ON UPDATE NO ACTION
GO

ALTER TABLE VACCINES_BY_AGE
ADD CONSTRAINT FK_VBA_P
FOREIGN KEY(PHU_ID)
REFERENCES PHU
ON UPDATE NO ACTION
GO

ALTER TABLE ONGOING_OUTBREAK_PHU
ADD CONSTRAINT FK_OOP_P
FOREIGN KEY(PHU_NUM)
REFERENCES PHU
ON UPDATE NO ACTION
GO
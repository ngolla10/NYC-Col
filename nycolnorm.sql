--crash
DROP TABLE IF EXISTS CRASH_2NF;
CREATE TABLE CRASH_2NF (
    COLLISION_ID INTEGER PRIMARY KEY,
    CRASHDATETIME DATE NOT NULL,
    BOROUGH TEXT,
    COUNTY TEXT,
    STATE TEXT,
    ZIPCODE TEXT,
    LATITUDE REAL,
    LONGITUDE REAL
);

INSERT INTO CRASH_2NF 
SELECT DISTINCT
    COLLISION_ID,
    CRASHDATETIME,
    BOROUGH,
    COUNTY,
    STATE,
    ZIPCODE,
    LATITUDE,
    LONGITUDE
FROM CRASH_1NF;

-- vehicle
DROP TABLE IF EXISTS VEHICLE_2NF;
CREATE TABLE VEHICLE_2NF (
    VEHICLE_ID INTEGER PRIMARY KEY,
    COLLISION_ID INTEGER,
    STATE_REGISTRATION TEXT,
    VEHICLE_CATEGORY TEXT,
    VEHICLE_YEAR INTEGER,
    DRIVER_LICENSE_STATUS TEXT,
    DRIVER_LICENSE_JURISDICTION TEXT,
    PRIMARY_CONTRIBUTING_FACTOR TEXT,
    FOREIGN KEY (COLLISION_ID) REFERENCES CRASH_2NF(COLLISION_ID)
);

INSERT INTO VEHICLE_2NF
SELECT DISTINCT 
    VEHICLE_ID,
    COLLISION_ID,
    STATE_REGISTRATION,
    VEHICLE_CATEGORY,
    VEHICLE_YEAR,
    DRIVER_LICENSE_STATUS,
    DRIVER_LICENSE_JURISDICTION,
    PRIMARY_CONTRIBUTING_FACTOR
FROM VEHICLE_1NF
WHERE COLLISION_ID IN (SELECT COLLISION_ID FROM CRASH_2NF);
    --AND (VEHICLE_YEAR IS NULL OR VEHICLE_ID IN (SELECT VEHICLE_ID FROM VEHICLE_2NF));

--person
DROP TABLE IF EXISTS PERSON_2NF;
CREATE TABLE PERSON_2NF (
   PERSON_ID INTEGER PRIMARY KEY,
   COLLISION_ID INTEGER,
   PERSON_TYPE TEXT,
   PERSON_ROLE TEXT,
   PERSON_AGE INTEGER,
   PERSON_SEX TEXT,
   PERSON_INJURY TEXT,
   VEHICLE_ID INTEGER,
   SAFETY_EQUIPMENT TEXT,
   FOREIGN KEY (COLLISION_ID) REFERENCES CRASH_2NF(COLLISION_ID),
   FOREIGN KEY (VEHICLE_ID) REFERENCES VEHICLE_2NF(VEHICLE_ID)
);

INSERT INTO PERSON_2NF
SELECT DISTINCT 
    PERSON_ID,
    COLLISION_ID,
    PERSON_TYPE,
    PERSON_ROLE,
    PERSON_AGE,
    PERSON_SEX,
    PERSON_INJURY,
    VEHICLE_ID,
    SAFETY_EQUIPMENT
FROM PERSON_1NF
WHERE COLLISION_ID IN (SELECT COLLISION_ID FROM CRASH_2NF)
    AND (VEHICLE_ID IS NULL OR VEHICLE_ID IN (SELECT VEHICLE_ID FROM VEHICLE_2NF));
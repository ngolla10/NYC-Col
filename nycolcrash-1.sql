-- Define the table schema
DROP TABLE IF EXISTS CRASH_1NF;
CREATE TABLE CRASH_1NF (
    COLLISION_ID INTEGER PRIMARY KEY,
    CRASHDATETIME DATE NOT NULL,
    BOROUGH TEXT,
    COUNTY TEXT,
    STATE TEXT,
    ZIPCODE TEXT,
    LATITUDE REAL,
    LONGITUDE REAL
);

-- Populate the table with the filtered data
INSERT INTO CRASH_1NF (COLLISION_ID, CRASHDATETIME, BOROUGH, COUNTY, STATE, ZIPCODE, LATITUDE, LONGITUDE)
SELECT
    COLLISION_ID,
   CASE 
        -- Extract year, month, and day from CRASHDATE
        WHEN length(CRASHDATE) = 8 THEN substr(CRASHDATE, 7, 4) || '-' || substr(CRASHDATE, 1, 2) || '-' || substr(CRASHDATE, 4, 2)
        WHEN length(CRASHDATE) = 10 THEN substr(CRASHDATE, 6, 4) || '-' || substr(CRASHDATE, 1, 2) || '-' || substr(CRASHDATE, 4, 2)
        -- Handle missing leading zero
        ELSE substr(CRASHDATE, 6, 4) || '-' || '0' || substr(CRASHDATE, 1, 1) || '-' || substr(CRASHDATE, 3, 2)
    END || 
    ' ' ||
   CASE
        -- Format CRASHTIME in hh:mm:ss format
        WHEN length(CRASHTIME) = 4 THEN '0' || CRASHTIME || ':00'
        ELSE CRASHTIME || ':00'
        
    END AS CRASHDATETIME,
    BOROUGH,
    CASE BOROUGH
        WHEN 'BRONX' THEN 'BRONX'
        WHEN 'BROOKLYN' THEN 'KINGS'
        WHEN 'MANHATTAN' THEN 'NEW YORK'
        WHEN 'QUEENS' THEN 'QUEENS'
        WHEN 'STATEN ISLAND' THEN 'RICHMOND'
        --ELSE NULL
    END AS COUNTY,
    'NY' AS STATE,
    ZIPCODE,
    LATITUDE,
    LONGITUDE
FROM CRASH_0NF
WHERE
    CRASHDATETIME >= '2019-01-01 00:00:00'
    AND BOROUGH IS NOT NULL;

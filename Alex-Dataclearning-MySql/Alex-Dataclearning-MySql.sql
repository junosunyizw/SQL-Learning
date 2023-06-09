
SELECT *
FROM NashvilleHousingData;

--standardize the data format

--salesdate

UPDATE NashvilleHousingData SET SALEDATE = DATE_FORMAT(STR_TO_DATE(SALEDATE, '%M %e, %Y'), '%Y-%m-%d');

SELECT SALEDATE
FROM NashvilleHousingData
ORDER BY 1;

--Populate property address

SELECT *
FROM NashvilleHousingData
WHERE propertyaddress IS NULL
ORDER BY ParcelID;

--Due property address have null value, populate property info if propertyaddress is null with ParcellID

UPDATE NashvilleHousingData SET Propertyaddress = NULL WHERE PropertyAddress ='';

SELECT a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, 
        ifnull(a.PropertyAddress,b.PropertyAddress)
FROM NashvilleHousingData a
JOIN NashvilleHousingData b
ON  a.ParcelID = b.ParcelID AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress is NULL;


--Update function in mysql cannot be used with FROM
UPDATE 
NashvilleHousingData a
JOIN NashvilleHousingData b
ON a.ParcelID = b.ParcelID AND a.UniqueID <> b.UniqueID
SET a.PropertyAddress = ifnull(a.PropertyAddress,b.PropertyAddress)
WHERE a.PropertyAddress is NULL;


--breaking address into indivdual coloumn (address, city, states)

SELECT propertysplitecity
FROM NashvilleHousingData;


SELECT  PropertyAddress,
        substring(PropertyAddress,1,locate(',',PropertyAddress)-1) AS Address,
        substring(PropertyAddress,locate(',',PropertyAddress)+2) AS City
FROM NashvilleHousingData;


--split address
alter TABLE NashvilleHousingData
ADD propertyspliteaddress varchar(50);

UPDATE NashvilleHousingData
SET propertyspliteaddress = substring(PropertyAddress,1,locate(',',PropertyAddress)-1);

--split City
ALTER table NashvilleHousingData
ADD propertysplitecity VARCHAR(50);

UPDATE NashvilleHousingData
SET propertysplitecity = substring(PropertyAddress,locate(',',PropertyAddress)+2);

--split OWNERADRESS

UPDATE NashvilleHousingData SET OwnerAddress = NULL WHERE OwnerAddress = '';

SELECT OwnerAddress, Ownersplitaddress,Ownersplitcity,Ownersplitstate
FROM NashvilleHousingData;

SELECT OwnerAddress,
      substring_index(substring_index(OwnerAddress,',',1),',',-1) AS Address,
      substring_index(substring_index(OwnerAddress,',',2),',',-1) AS City,
      substring_index(substring_index(OwnerAddress,',',3),',',-1) AS State
FROM NashvilleHousingData;

alter TABLE NashvilleHousingData
ADD Ownersplitaddress varchar(50);
UPDATE NashvilleHousingData
SET Ownersplitaddress = substring_index(substring_index(OwnerAddress,',',1),',',-1);

alter TABLE NashvilleHousingData
ADD Ownersplitcity varchar(50);
UPDATE NashvilleHousingData
SET Ownersplitcity = substring_index(substring_index(OwnerAddress,',',2),',',-1);

alter TABLE NashvilleHousingData
ADD Ownersplitstate varchar(50);
UPDATE NashvilleHousingData
SET Ownersplitstate = substring_index(substring_index(OwnerAddress,',',3),',',-1);

--change Y and N to Yes and No in 'Sold as vacant' field(case when)

SELECT DISTINCT (SoldAsVacant), count(SoldAsVacant)
FROM NashvilleHousingData
GROUP BY SoldAsVacant
ORDER BY 2;

SELECT SoldAsVacant,
        CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
        WHEN SoldAsVacant = 'N' THEN 'No'
        ELSE SoldAsVacant
        END
FROM NashvilleHousingData;


UPDATE 
NashvilleHousingData
SET
SoldAsVacant =  CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
                WHEN SoldAsVacant = 'N' THEN 'No'
                ELSE SoldAsVacant
                END;


--remove duplicates (windowns function & cte & row_number) require inner join to solve this problem(https://stackoverflow.com/questions/71269809/target-table-of-delete-is-not-updatable-while-deleting-duplicates-in-mysql)


WITH rownumcte AS 
(
SELECT UniqueID,
      row_number() OVER (PARTITION BY parcelid,propertyaddress,saleprice,saledate,legalreference ORDER BY uniqueid) row_num
FROm NashvilleHousingData
ORDER BY ParcelID
)
SELECT *
FROM NashvilleHousingData hd INNER JOIN rownumcte r on hd.UniqueID = r.UNIQUEID
WHERE ROW_num > 1;


--delete unused colums 

SELECT *
FROM NashvilleHousingData

ALTER TABLE NashvilleHousingData
DROP COLUMN taxdistrict

ALTER TABLE NashvilleHousingData
DROP COLUMN saledate


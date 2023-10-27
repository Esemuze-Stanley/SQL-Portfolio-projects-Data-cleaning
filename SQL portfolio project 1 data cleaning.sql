desc nashville

-- Cleaning data in SQl Querries

select *from portfolioproject.nashville;

-- Standardized date format

select saledate
from portfolioproject.nashville

-- populate property address

select propertyaddress
from portfolioproject.nashville
where propertyaddress is null;

select *
from portfolioproject.nashville
where propertyaddress is null;

select *
from portfolioproject.nashville
where propertyaddress is not null;

select a.parcelID, a.propertyaddress, b.parcelID, b.propertyaddress
From portfolioproject.nashville a
    JOIN portfolioproject.nashville b
    and a.[uniqueID] <> b.[uniqueID]
WHERE a.propertyaddress is null;

select a.parcelID, a.propertyaddress, b.parcelID, b.propertyaddress, ISNULL(a.propertyaddress, b.propertyaddress)
From portfolioproject.nashville a
    JOIN portfolioproject.nashville b
    and a.[uniqueID] <> b.[uniqueID]
WHERE a.propertyaddress is null;

update a
SET propertyaddress = isnull(a.propertyaddress, b.propertyaddress) 
from portfolioproject.nashville a
   join portfolioproject.nashville b
   and a.[uniqueid] <> b.[uniqueid]
where a.propertyaddress is null;

-- Breaking out Address into individual columns (Address, city, state)

 select *
from portfolioproject.nashville
-- where propertyaddress is null
order by parcelID;

select propertyaddress
from portfolioproject.nashville
-- where propertyaddress is null
-- order by parcelID;


SELECT
SUBSTRING(propertyaddress, 1, CHARINDEX(',' propertyaddress) -1) as address,
SUBSTRING(propertyaddress, 1, CHARINDEX(',' propertyaddress) -1) as address,
-- CHARINDEX(',' propertyaddress)
from portfolioproject.nashville;

Alter table nashville
Add saleDateconverted date

-- update nashville
-- set saledateconverted = CONVERT(date, saledate)

Alter table nashville
Add column propertysplitaddress nvarchar(255);

select owneraddress from nashville;
desc nashville;

update nashville set propertysplitcity = substring(propertyaddress, charindex(',', propertyaddress) + 1, len(propertyaddress));

select
parsename(replace(owneraddress, ',',',') ,1)
from nashville;

select
parsename(replace(owneraddress, ',',',') ,1)
parsename(replace(owneraddress, ',',',') ,2)
parsename(replace(owneraddress, ',',',') ,3)
from portfolio.nashville

-- change Y and N Yes and No in "sold out" vacant field

select disctinct(soldasvacant), countsoldasvacant)
from nashville
group by soldasvacant;

select soldasvacant
 , case when soldasvacant = 'Y' then 'Yes'
		when soldasvacant = 'N' then 'No'
        else soldasvacant
        END
 from portfolioproject.nashville;

-- update nashville
-- set soldasvacant = case when soldasvacant = 'Y' then 'Yes'
-- 		when soldasvacant = 'N' then 'No'
--         else soldasvacant
--         END 

--Remove Duplicate 

SELECT *
FROM portfolioproject.nashville;

select *,
   ROW_NUMBER() OVER (
   PARTITION BY parcelID,
                propertyaddress,
                saleprice,
                saledate,
                Legalreference
                ORDER BY 
                   uniqueID
                   ) row_num
from portfolioproject.nashville                 
ORDER BY parcelID;

with RowNumCTE AS(
select *,
   ROW_NUMBER() OVER (
   PARTITION BY parcelID,
                propertyaddress,
                saleprice,
                saledate,
                Legalreference
                ORDER BY 
                   uniqueID
                   ) row_num
from portfolioproject.nashville                 
-- ORDER BY parcelID;
)
select *
from RowNumCTE             
where Row_Num > 1 
order by  propertyaddress

-- Delete Unused Column 

select *
from portfolioproject.nashville

ALTER TABLE nashville
drop column owneraddress    

ALTER TABLE nashville
drop column taxdistrict;

ALTER TABLE nashville
drop column propertyaddress;

ALTER TABLE nashville
drop column saledate;

select *
from portfolioproject.nashville;



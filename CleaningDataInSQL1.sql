-- CLEANING DATA IN SQL QUERIES

Select *
From PortfolioProject..NashvilleHousing

-- Change Date Format for SaleDate

Select SaleDateConverted, CONVERT(Date, SaleDate)
From PortfolioProject..NashvilleHousing

Update NashvilleHousing
Set SaleDate = CONVERT(Date, SaleDate)

ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
Set SaleDateConverted = CONVERT(Date, SaleDate)

-- Populate Property Address Data

Select PropertyAddress
From PortfolioProject..NashvilleHousing
Where PropertyAddress is null

Select *
From PortfolioProject..NashvilleHousing
--Where PropertyAddress is null
Order by ParcelID

-- Populating Property Address Where ParcelD are the same

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
From PortfolioProject..NashvilleHousing a
JOIN PortfolioProject..NashvilleHousing b
on a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

Update a
Set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
From PortfolioProject..NashvilleHousing a
JOIN PortfolioProject..NashvilleHousing b
on a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

-- Breaking Address in Separate Columns (Address, City, State)

Select PropertyAddress
From PortfolioProject..NashvilleHousing

Select
--ParseName(Replace(PropertyAddress, ',', '.'), 3)
ParseName(Replace(PropertyAddress, ',', '.'), 2)
,ParseName(Replace(PropertyAddress, ',', '.'), 1)

ALTER TABLE NashvilleHousing
Add PropertySplitAddress nvarchar(255);

Update NashvilleHousing
Set PropertySplitAddress = ParseName(Replace(PropertyAddress, ',', '.'), 2)

ALTER TABLE NashvilleHousing
Add PropertySplitCity nvarchar(255);

Update NashvilleHousing
Set PropertySplitCity = ParseName(Replace(PropertyAddress, ',', '.'), 1)

From PortfolioProject..NashvilleHousing

--Select 
--SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) as Address
--, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress +1), LEN(PropertyAddress)) as Address

--From PortfolioProject..NashvilleHousing



-- Spliting Owner Address into Address, City, State

 Select OwnerAddress
From PortfolioProject..NashvilleHousing

Select
ParseName(Replace(OwnerAddress, ',', '.'), 3)
,ParseName(Replace(OwnerAddress, ',', '.'), 2)
,ParseName(Replace(OwnerAddress, ',', '.'), 1)

From PortfolioProject..NashvilleHousing

ALTER TABLE NashvilleHousing
Add OwnerSplitAddress nvarchar(255);

Update NashvilleHousing
Set OwnerSplitAddress = ParseName(Replace(OwnerAddress, ',', '.'), 3)

ALTER TABLE NashvilleHousing
Add OwnerSplitCity nvarchar(255);

Update NashvilleHousing
Set OwnerSplitCity = ParseName(Replace(OwnerAddress, ',', '.'), 2)


ALTER TABLE NashvilleHousing
Add OwnerSplitState nvarchar(255);

Update NashvilleHousing
Set OwnerSplitState = ParseName(Replace(OwnerAddress, ',', '.'), 1)

From PortfolioProject..NashvilleHousing

Select *
From PortfolioProject..NashvilleHousing

--  Change Y and N to Yes and No in SoldAsVacant field

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From PortfolioProject..NashvilleHousing
Group by SoldAsVacant
Order by 2

Select SoldAsVacant
,Case When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From PortfolioProject..NashvilleHousing

Update NashvilleHousing
SET SoldAsVacant = Case When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From PortfolioProject..NashvilleHousing

-- Remove Duplicates

--With RowNumCTE AS (
--Select *,
	--ROW_NUMBER() OVER(   
	--PARTITION BY ParcelID,
				 --PropertyAddress,
				 --SalePrice,
				 --SaleDate,
				 --LegalReference
				 --ORDER BY
					--UniqueID
				    --) row_num
				 
--From PortfolioProject..NashvilleHousing
 --Order By ParcelID
 --)
 --Select *
 --From RowNumCTE
 --Where row_num > 1
 --Order By PropertyAddress
 
 --From PortfolioProject..NashvilleHousing


 -- Delete Unused Columns

 Select *
 From PortfolioProject..NashvilleHousing

ALTER TABLE PortfolioProject..NashvilleHousing
DROP Column PropertyAddress, OwnerAddress, TaxDistrict

ALTER TABLE PortfolioProject..NashvilleHousing
DROP Column SaleDate
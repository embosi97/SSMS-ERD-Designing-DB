-- ============================================= 
-- Author:  Jason Brandwein 
-- Create date:  5/08/2020
-- Description: my 3 queries
-- =============================================

-- 1
select *
from Project3.BuildingLocation
where BuildingLocationID > 5 and BuildingLocationId < 10

-- 2
select *
from Project3.BuildingLocation
where BuildingName = 'IB'

-- 3  
select *
from Project3.ClassRoomLocation
where AuthorizedUserId = 22
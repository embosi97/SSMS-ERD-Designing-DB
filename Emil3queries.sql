-- QUERY 1
SELECT BuildingName, ClassTime
FROM Project3.BuildingLocation
WHERE BuildingLocationID > 5;

-- QUERY 2
SELECT BuildingLocationId AS 'Building Location'
FROM Project3.BuildingLocation 
WHERE BuildingName = (SELECT BuildingName
					 FROM Project3.BuildingLocation
					 WHERE BuildingName LIKE 'H%')
ORDER BY BuildingLocationId;

-- QUERY 3
SELECT FirstName, LastName
FROM Project3.ClassRoomLocation
WHERE ClassRoomLocationId = 10;
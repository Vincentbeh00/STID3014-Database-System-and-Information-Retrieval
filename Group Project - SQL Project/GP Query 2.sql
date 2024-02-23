--Create Database
CREATE DATABASE HealthApp2
GO

use HealthApp2 
GO

-- Create User Profile table
CREATE TABLE User_Profile (
	UserID VARCHAR(6) PRIMARY KEY,
	Name VARCHAR(255) NOT NULL,
	Email VARCHAR(255) NOT NULL,
	Age INT NOT NULL,
	Gender CHAR NOT NULL
		CONSTRAINT User_sexCHK
		CHECK (Gender IN ('M','F')),
	ContactInformation VARCHAR(255) NOT NULL
);

-- Create Goals table
CREATE TABLE Goals (
    GoalID VARCHAR (8) PRIMARY KEY,
	InitialDate DATE NOT NULL,
	GoalType VARCHAR(50) NOT NULL,
	GoalName VARCHAR(255) NOT NULL,
	GoalDescription VARCHAR(1000) NOT NULL,
	TargetDate DATE NOT NULL,
	UserID VARCHAR(6) NOT NULL,
	FOREIGN KEY (UserID) REFERENCES User_Profile (UserID)
);

-- Create Notification table
CREATE TABLE Notification (
	NotificationID VARCHAR(8) PRIMARY KEY,
	NotificationName VARCHAR(255) NOT NULL,
	NotificationDate DATE NOT NULL,
	NotificationTime TIME NOT NULL,
	GoalID VARCHAR (8) NOT NULL,
	FOREIGN KEY (GoalID) REFERENCES Goals (GoalID)
);

-- Create Physical_Activity table
CREATE TABLE Physical_Activity (
	PhysicalID VARCHAR(8) PRIMARY KEY,
	WorkoutType CHAR NOT NULL
		CONSTRAINT User_actCHK
		CHECK (WorkoutType IN ('W','R')),
	Distance FLOAT,
	Steps INT,
	Date DATE NOT NULL,
	UserID VARCHAR(6) NOT NULL,
	FOREIGN KEY (UserID) REFERENCES User_Profile (UserID)
);

-- Create Consumption_Tracker table
CREATE TABLE Consumption_Tracker (
   ConsumptionID VARCHAR(8) PRIMARY KEY,
	Date DATE NOT NULL,
	WaterConsumption FLOAT NOT NULL,
	EstimatedCaloricIntake INT NOT NULL,
	UserID VARCHAR(6) NOT NULL,
	FOREIGN KEY (UserID) REFERENCES User_Profile (UserID)
);

-- Create Sleep table
CREATE TABLE Sleep (
	SleepID VARCHAR(8) PRIMARY KEY,
	Date DATE NOT NULL,
	HoursSlept FLOAT NOT NULL,
	UserID VARCHAR(6) NOT NULL,
	FOREIGN KEY (UserID) REFERENCES User_Profile (UserID)
);

-- Create Daily_Mood table
CREATE TABLE Daily_Mood (
	MoodID VARCHAR(8) PRIMARY KEY,
	Date DATE NOT NULL,
	MoodRating INT CHECK (MoodRating BETWEEN 1 AND 10) NOT NULL,
	MoodType CHAR NOT NULL
		CONSTRAINT User_moodCHK
		CHECK (MoodType IN ('B','G','N')),
	UserID VARCHAR(6) NOT NULL,
	FOREIGN KEY (UserID) REFERENCES User_Profile (UserID)
);

-- Create Tips table
CREATE TABLE Tips (
	TipsID VARCHAR(8) PRIMARY KEY,
	TipsType VARCHAR(50) NOT NULL,
	TipsName VARCHAR(255) NOT NULL,
	TipsDescription VARCHAR(1000) NOT NULL,
	TipsContent VARCHAR(MAX) NOT NULL
);

-- Create User_Tips table
CREATE TABLE User_Tips (
	UserID VARCHAR(6),
	TipsID VARCHAR(8),
	PRIMARY KEY (UserID, TipsID),
	FOREIGN KEY (UserID) REFERENCES User_Profile (UserID),
	FOREIGN KEY (TipsID) REFERENCES Tips (TipsID)
);



INSERT INTO User_Profile (UserID, Name, Email, Age, Gender, ContactInformation, Height)
VALUES
	('USR001', 'John Doe', 'john@gmail.com', 30, 'M', '0193311609','178'),
	('USR002', 'Jane Smith', 'jane@gmail.com', 25, 'F', '0126691234','160'),
	('USR003', 'YAP JIA QING' , 'yapjiaqing6099@gmail.com' , 23 ,'M' ,'01111946981' , '170' ),
	('USR004', 'Vincent Beh' , 'vincentbehuum@gmail.com' , 23 ,'M' ,'01121218053', '173' );

	UPDATE User_Profile
SET Email = 'JohnDoe@gmail.com'
WHERE UserID = 'USR001';

	UPDATE User_Profile
SET Email = 'janesmith@gmail.com'
WHERE UserID = 'USR002';

INSERT INTO Goals (GoalID, InitialDate, GoalType, GoalName, GoalDescription, TargetDate, UserID)
VALUES
    ('GOAL001', '2023-07-21', 'Fitness', 'Lose Weight', 'Lose 10 pounds in 2 months', '2023-09-21', 'USR003'),
    ('GOAL002', '2023-07-21', 'Health', 'Drink More Water', 'Drink at least 8 glasses of water daily', '2023-08-31', 'USR001'),
    ('GOAL003', '2023-07-21', 'Fitness', 'Run a 5K', 'Complete a 5K run within 30 minutes', '2023-09-15', 'USR002');
INSERT INTO Notification (NotificationID, NotificationName, NotificationDate, NotificationTime, GoalID)
VALUES
    ('NOTIF001', 'Morning Workout', '2023-07-22', '07:00:00', 'GOAL001'),
    ('NOTIF002', 'Drink Water Reminder', '2023-07-22', '09:00:00', 'GOAL002'),
    ('NOTIF003', 'Evening Run', '2023-07-23', '18:30:00', 'GOAL003');
	-- Insert physical activity records for each user
INSERT INTO Physical_Activity (PhysicalID, WorkoutType, Distance, Steps, Date, UserID)
VALUES
    ('PHY001', 'W', 5.2, 8000, '2023-07-21', 'USR003'),
    ('PHY002', 'W', 3.1, 6000, '2023-07-21', 'USR001'),
    ('PHY003', 'R', 4.0, 7500, '2023-07-21', 'USR002');
-- Insert consumption tracker records for each user
INSERT INTO Consumption_Tracker (ConsumptionID, Date, WaterConsumption, EstimatedCaloricIntake, UserID)
VALUES
	('CONS001', '2023-07-21', 2.5, 1800, 'USR003'),
	('CONS002', '2023-07-21', 8.0, 2000, 'USR001'),
	('CONS003', '2023-07-21', 6.0, 2200, 'USR002'),
	('CONS004', '2023-07-21', 0.5, 800, 'USR003'),
	('CONS005', '2023-07-21', 2.5, 1800, 'USR003'),
	('CONS006', '2023-07-21', 0.6, 500, 'USR003');

INSERT INTO Sleep (SleepID, Date, HoursSlept, UserID)
VALUES
    ('SLP001', '2023-07-21', 7.5, 'USR003'),
    ('SLP002', '2023-07-21', 8.0, 'USR001'),
    ('SLP003', '2023-07-21', 6.5, 'USR002');
-- Insert daily mood records for each user
INSERT INTO Daily_Mood (MoodID, Date, MoodRating, MoodType, UserID)
VALUES
    ('MOOD001', '2023-07-21', 8, 'G', 'USR003'),
    ('MOOD002', '2023-07-21', 7, 'B', 'USR001'),
    ('MOOD003', '2023-07-21', 6, 'N', 'USR002');
-- Insert tips
INSERT INTO Tips (TipsID, TipsType, TipsName, TipsDescription, TipsContent)
VALUES
    ('TIPS001', 'Fitness', 'Running Tips', 'Tips for improving running performance', 'Run at a steady pace and stay hydrated.'),
    ('TIPS002', 'Health', 'Hydration Tips', 'Tips for staying hydrated throughout the day', 'Drink water regularly and carry a reusable water bottle.'),
    ('TIPS003', 'Fitness', 'Weight Loss Tips', 'Tips for achieving weight loss goals', 'Focus on a balanced diet and regular exercise.');
-- Assign tips to users
INSERT INTO User_Tips (UserID, TipsID)
VALUES
    ('USR003', 'TIPS001'),
    ('USR001', 'TIPS002'),
    ('USR002', 'TIPS003');


CREATE VIEW UserProfileWithGoals AS
SELECT u.UserID, u.Name, u.Email, u.Age, u.Gender, u.ContactInformation,
       g.GoalID, g.GoalType, g.GoalName, g.GoalDescription, g.TargetDate
FROM User_Profile u
LEFT JOIN Goals g ON u.UserID = g.UserID;

CREATE VIEW UserPhysicalActivitySummary AS
SELECT u.Name,
       SUM(Steps) AS TotalSteps,
       SUM(Distance) AS TotalDistance
FROM User_Profile u
LEFT JOIN Physical_Activity p ON u.UserID = p.UserID
GROUP BY u.Name;

select * from User_Profile 

ALTER TABLE User_Profile 

ADD Height FLOAT; 


UPDATE User_Profile
SET Age = 25
WHERE UserID = 'USR003';
select * from User_Profile
UPDATE User_Profile
SET  Height= 170
WHERE UserID = 'USR003';
UPDATE User_Profile
SET  Height= 178
WHERE UserID = 'USR001';
UPDATE User_Profile
SET  ContactInformation = '01121218053'
WHERE UserID = 'USR004';

select * from User_Profile

INSERT INTO Goals (GoalID, InitialDate, GoalType, GoalName, GoalDescription, TargetDate, UserID)
VALUES
    ('GOAL004', '2023-07-21', 'Health', 'Eat More Water', '8 glasses of water', '2023-09-21', 'USR003');

CREATE VIEW UserMoodView AS
SELECT u.Name, m.MoodRating, m.MoodType
FROM User_Profile u
JOIN Daily_Mood m ON u.UserID = m.UserID;


CREATE VIEW UserConsumptionView AS
SELECT u.Name, c.WaterConsumption, c.EstimatedCaloricIntake
FROM User_Profile u
JOIN Consumption_Tracker c ON u.UserID = c.UserID;
select * from UserConsumptionView;

Insert into User_Profile values('USR004','Vincent Beh','vincentbehuum@gmail.com',23,'M','01111946981','173')

INSERT INTO Sleep (SleepID, Date, HoursSlept, UserID)
VALUES
    ('SLP004', '2023-07-23', 6.0, 'USR003')

-- Insert daily mood records for each user
INSERT INTO Daily_Mood (MoodID, Date, MoodRating, MoodType, UserID)
VALUES
    ('MOOD004', '2023-07-23', 4, 'B', 'USR003')

INSERT INTO Daily_Mood (MoodID, Date, MoodRating, MoodType, UserID)
VALUES
    ('MOOD005', '2023-07-23', 9, 'G', 'USR003')

select * from Daily_Mood


select n.* from notification as n where GoalID in( select GoalID from Goals where (GoalType ='Fitness' and UserID ='korone1'))

SELECT UserID, SUM(WaterConsumption) AS TotalWaterConsumed
FROM Consumption_Tracker
GROUP BY UserID;

SELECT UserID, Name FROM User_Profile WHERE UserID NOT IN (SELECT UserID FROM Goals);

Select name ,avg(Steps) AS AverageStepsPerDay from User_Profile u, Physical_Activity p
where p.UserID IN(Select u.UserID from User_Profile where u.UserID = 'USR003')
Group by name;

Select name ,avg(Steps) AS AverageStepsPerDay from User_Profile u, Physical_Activity p
where p.UserID IN(Select u.UserID from User_Profile where u.UserID = 'USR001')
Group by name;

Select name ,avg(Steps) AS AverageStepsPerDay from User_Profile u, Physical_Activity p
where p.UserID IN(Select u.UserID from User_Profile where u.UserID = 'USR002')
Group by name;

Select name ,avg(Steps) AS AverageStepsPerDay from User_Profile u, Physical_Activity p
where p.UserID IN(Select u.UserID from User_Profile)
Group by name;

Select t.*,g.GoalName from Tips as t,goals as g,User_Tips as u where (t.TipsType ='@GoalType' and t.TipsType=g.GoalType and u.TipsID = t.TipsID and u.UserID=g.UserID and u.UserID ='@UserID')

SELECT u.Name, g.GoalName, g.GoalDescription, COUNT(n.NotificationID) AS NumNotifications
FROM User_Profile u
LEFT JOIN Goals g ON u.UserID = g.UserID
LEFT JOIN Notification n ON g.GoalID = n.GoalID
GROUP BY u.Name, g.GoalName, g.GoalDescription;

SELECT u.Name, s.Date, s.HoursSlept, m.MoodRating, m.MoodType FROM User_Profile u INNER JOIN Sleep s ON u.UserID = s.UserID INNER JOIN Daily_Mood m ON u.UserID = m.UserID AND s.Date = m.Date;

SELECT u.Name, u.Age, p.Date, p.WorkoutType, p.Distance, p.Steps, c.WaterConsumption,c.EstimatedCaloricIntake, s.HoursSlept FROM User_Profile u, Physical_Activity p, Consumption_Tracker c, Sleep S WHERE p.Date = c.Date and c.Date = s.Date and u.UserID = c.UserID and c.UserID = p.UserID and p.userID = s.UserID

select Date, count(ConsumptionID) as [number of eat/drink], Max(EstimatedCaloricIntake) as [maximum CaloricIntake], MIN(EstimatedCaloricIntake) as [minimum CaloricIntake] ,Max(WaterConsumption) as [Maximum WaterConsumption], MIN(WaterConsumption) as [minimum WaterConsumption] from Consumption_Tracker as c,User_Profile as u where c.UserID=u.UserID and u.UserID ='@UserID' GROUP BY Date

SELECT pa.UserID, u.Name, DATEPART(WEEK, pa.Date) AS WeekNumber, SUM(pa.Distance) AS TotalDistanceCovered FROM Physical_Activity pa JOIN User_Profile u ON pa.UserID = u.UserID GROUP BY pa.UserID, u.Name, DATEPART(WEEK, pa.Date);

SELECT u.UserID, u.Name, AVG(dm.MoodRating) AS AvgMoodRating, 
       MAX(dm.MoodType) AS MostCommonMoodType
FROM User_Profile u
JOIN Daily_Mood dm ON u.UserID = dm.UserID
GROUP BY u.UserID, u.Name;



SELECT u.UserID, u.Name, AVG(dm.MoodRating) AS AvgMoodRating, 

		(SELECT TOP 1 dm.MoodType 

        FROM Daily_Mood dm 

        WHERE dm.UserID = u.UserID 

        GROUP BY dm.MoodType 

        ORDER BY COUNT(*) DESC) AS MostCommonMoodType 

FROM User_Profile u 

JOIN Daily_Mood dm ON u.UserID = dm.UserID 

GROUP BY u.UserID, u.Name; 


Select name, avg(HoursSlept) AS AVGSleepHourByDay from User_Profile u, Sleep sWhere u.UserID = s.UserID Group by Name

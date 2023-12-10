CREATE DATABASE StarStruckTickets;

--1.CREATE TABLE

-- Users table to store user information
CREATE TABLE Users (
    UserID SERIAL PRIMARY KEY,
    UserName VARCHAR(50) UNIQUE NOT NULL,
    FullName VARCHAR(100) NOT NULL,
    UserEmail VARCHAR(50) UNIQUE NOT NULL,
    UserPassword VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL
);

-- Admins table to store admin information
CREATE TABLE Admins (
    AdminID SERIAL PRIMARY KEY,
    AdminEmail VARCHAR(50) UNIQUE NOT NULL,
    AdminPassword VARCHAR(50) NOT NULL
);

-- Events table to store event details
CREATE TABLE Events (
    EventID SERIAL PRIMARY KEY,
    EventName VARCHAR(100) NOT NULL,
    ArtistName VARCHAR(100) NOT NULL,
    EventDate DATE NOT NULL,
    EventLocation VARCHAR(255) NOT NULL,
    SeatCapacity INT,
    TicketPrice DECIMAL(10, 2) NOT NULL,
    SeatPlan BYTEA
);

-- Tickets table to store ticket information (including ticket types)
CREATE TABLE Tickets (
    TicketID SERIAL PRIMARY KEY,
    UserID INT,
    EventID INT,
    TypeName VARCHAR(50) NOT NULL,
    Price DECIMAL(8, 2) NOT NULL,
    Quantity INT NOT NULL,
    PaymentStatus VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (EventID) REFERENCES Events(EventID)
);

-- Payments table to store payment information (reference Tickets instead of EventRegistrations)
CREATE TABLE Payments (
    PaymentID SERIAL PRIMARY KEY,
    TicketID INT,
    Amount DECIMAL(8, 2) NOT NULL,
    PaymentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PaymentMethod VARCHAR(50),
    Status VARCHAR(50) NOT NULL,
    FOREIGN KEY (TicketID) REFERENCES Tickets(TicketID)
);

-- EventRegistrations table to store admin event registrations
CREATE TABLE EventRegistrations (
    RegistrationID SERIAL PRIMARY KEY,
    AdminID INT,
    EventID INT,
    FOREIGN KEY (AdminID) REFERENCES Admins(AdminID),
    FOREIGN KEY (EventID) REFERENCES Events(EventID)
);

-- UserRegistrations table to store user event registrations
CREATE TABLE UserRegistrations (
    RegistrationID SERIAL PRIMARY KEY,
    UserName VARCHAR(50) NOT NULL,
    FullName VARCHAR(100) NOT NULL,
    UserEmail VARCHAR(50) NOT NULL,
    PhoneNumber BIGINT NOT NULL,
    EventID INT,
    FOREIGN KEY (EventID) REFERENCES Events(EventID)
);

--2. INSERT TABLE 

-- Insert into Users table for User Management
INSERT INTO Users (UserName, FullName, UserEmail, UserPassword, PhoneNumber)
VALUES 
    ('johnlee', 'John Lee', 'john.lee@gmail.com', 'john_password', '099123456789'),
    ('samsmith', 'Sam Smith', 'sam.smith@gmail.com', 'sam_password', '09189767783'),
    ('anthonyjones', 'Anthony Jones', 'anthony.jones@gmail.com', 'anthony_password', '09992678901'),
    ('snowwhite', 'Snow White', 'snow.white@gmail.com', 'snow_password', '09123456121'),
    ('michaeljames', 'Michael James', 'michael.james@gmail.com', 'michael_password', '09098734273'),
    ('taylorshees', 'Taylor Shees', 'taylor.shees@gmail.com', 'taylor_password', '09344552216'),
    ('jamesgordon', 'James Gordon', 'james.gordon@gmail.com', 'james_password', '09673425312'),
    ('sophiaharrison', 'Sophia Harrison', 'sophia.harrison@gmail.com', 'sophia_password', '09674621734'),
    ('williamlim', 'William Lim', 'william.lim@gmail.com', 'william_password', '09871232122'),
    ('martinluther', 'Martin Luther', 'martin.luther@gmail.com', 'martin_password', '09755646734');

-- Insert into Admins table for Admin Management (10 admins)
INSERT INTO Admins (AdminEmail, AdminPassword)
VALUES 
    ('Robbie@StarTruck.com', 'Robbie_password'),
    ('Julienne@StarTruck.com', 'Julienne_password'),
    ('Winston@StarTruck.com', 'Winston_password'),
    ('Mhark@StarTruck.com', 'Mhark_password'),
    ('Julbiene@StarTruck.com', 'Julbiene_password'),
    ('Gecelyn@StarTruck.com', 'Gecelyn_password'),
    ('Iris@StarTruck.com', 'Iris_password'),
    ('Rona@StarTruck.com', 'Rona_password'),
    ('Sydney@StarTruck.com', 'Sydney_password'),
    ('Abby@StarTruck.com', 'Abby_password');

-- Insert into Events table for Event Creation
INSERT INTO Events (EventID, EventName, ArtistName, EventDate, EventLocation, SeatCapacity, TicketPrice, SeatPlan)
VALUES 
    (1, 'Robbie World Tour', 'Robbie', '2024-06-27 19:00:00', 'Philippine Arena', 25000, 6000.00, NULL),
    (2,'RIVERMAYA THE REUNION', 'Rivermaya', '2024-02-17 19:00:00', 'SMDC Festival Grounds', 22000, 12000.00, NULL),
    (3, 'COLDPLAY MUSIC OF SPHERES WORLD TOUR', 'Coldplay', '2024-01-19 20:00:00', 'Philippine Arena', 30000, 12000.00, NULL),
    (4, 'ED SHEERAN TOUR', 'Ed Sheeran', '2024-03-09 19:00:00', 'SMDC Festival Grounds', 28000, 10000.00, NULL),
    (5, 'SEVENTEEN TOUR FOLLOW TO BULACAN', 'Seventeen', '2024-01-13 19:30:00', 'Philippine Sports Stadium', 25000, 12000.00, NULL),
    (6, 'THE SHOW NIALL HORAN LIVE ON TOUR 2024', 'Niall Horan', '2024-05-13 18:00:00', 'SM Mall Of Asia Arena', 27000, 10000.00, NULL),
    (7, 'BTS LOVE YOURSELF WORLD TOUR', 'BTS', '2024-04-30 20:00:00', 'Mall of Asia Arena', 30000, 8000.00, NULL),
    (8, 'Adele Live in Concert', 'Adele', '2024-08-15 21:00:00', 'Smart Araneta Coliseum', 22000, 10000.00, NULL),
    (9,'Imagine Dragons Evolve Tour', 'Imagine Dragons', '2024-07-08 18:30:00', 'MOA Concert Grounds', 28000, 7000.00, NULL),
    (10,'Taylor Swift Reputation Stadium Tour', 'Taylor Swift', '2024-06-12 20:15:00', 'Philippine Arena', 25000, 12000.00, NULL);
    
-- Insert into Tickets table for Ticket Management
INSERT INTO Tickets (UserID, EventID, TypeName, Price, Quantity, PaymentStatus)
VALUES 
    (1, 1, 'VIP STANDING', 15000.00, 2, 'Pending'),
    (2, 3, 'UPPERBOX', 7000.00, 1, 'Pending'),
    (3, 5, 'SILVER', 6550.00, 3, 'Pending'),
    (4, 5, 'BRONZE', 2250.00, 1, 'Pending'),
    (5, 4, 'GOLD', 11750.00, 2, 'Pending'),
    (6, 2, 'LOWERBOX', 10000.00, 1, 'Pending'),
    (7, 1, 'GENERAL ADMISSION', 3000.00, 2, 'Pending'),
    (8, 8, 'VIP STANDING', 12000.00, 2, 'Pending'),
    (9, 9, 'UPPERBOX', 6000.00, 1, 'Pending'),
    (10, 10, 'SILVER', 5000.00, 3, 'Pending');
	
-- Insert into Payments table for Payment Processing
INSERT INTO Payments (TicketID, Amount, PaymentDate, PaymentMethod, Status)
VALUES 
    (1, 30000.00, '2023-10-16 12:45:00', 'Gcash', 'Paid'),
    (2, 7000.00, '2023-10-17 09:30:00', 'Visa', 'Paid'),
    (3, 20250.00, DEFAULT, 'Pending', 'Pending'),
    (4, 2250.00, '2023-10-21 14:15:00', 'Gcash', 'Paid'),
    (5, 23500.00, '2023-10-23 20:30:00', 'Visa', 'Paid'),
    (6, 10000.00, DEFAULT, 'Pending', 'Pending'),
    (7, 6000.00, '2023-10-29 16:00:00', 'Gcash', 'Paid'),
    (8, 24000.00, '2023-11-05 15:20:00', 'PayPal', 'Paid'),
    (9, 6000.00, '2023-11-08 11:45:00', 'MasterCard', 'Paid'),
    (10, 1500.00, '2023-11-12 14:30:00', 'Gcash', 'Paid');
	
-- Insert into EventRegistrations table for Admin Event Registrations
INSERT INTO EventRegistrations (AdminID, EventID)
VALUES 
    (1, 1),
    (2, 2),
    (3, 3),
    (2, 4),
    (1, 5),
    (2, 6),
    (1, 8),
    (2, 9),
    (3, 10);

-- Insert into UserRegistrations table for User Event Registrations
INSERT INTO UserRegistrations (UserName, FullName, UserEmail, PhoneNumber, EventID)
VALUES 
    ('alice_smith', 'Alice Smith', 'alice.smith@gmail.com', '09123456789', 1),
    ('bob_jones', 'Bob Jones', 'bob.jones@gmail.com', '09234567890', 3),
    ('emily_white', 'Emily White', 'emily.white@gmail.com', '09345678901', 4),
    ('david_brown', 'David Brown', 'david.brown@gmail.com', '09456789012', 6),
    ('lisa_jones', 'Lisa Jones', 'lisa.jones@gmail.com', '09567890123', 2),
    ('ryan_garcia', 'Ryan Garcia', 'ryan.garcia@gmail.com', '09678901234', 5),
    ('susan_miller', 'Susan Miller', 'susan.miller@gmail.com', '09789012345', 7),
    ('michael_white', 'Michael White', 'michael.white@gmail.com', '09890123456', 8),
    ('olivia_williams', 'Olivia Williams', 'olivia.williams@gmail.com', '09901234567', 9),
    ('andrew_clark', 'Andrew Clark', 'andrew.clark@gmail.com', '09111223344', 10);

-- 3. DELETE

-- Delete unpaid payments
DELETE FROM Payments
USING Tickets
WHERE Payments.Status = 'Pending' AND Payments.TicketID = Tickets.TicketID;

-- Delete payments associated with a specific registration
DELETE FROM Payments
WHERE TicketID IN (
    SELECT TicketID
    FROM Tickets
    WHERE EventID = (
        SELECT EventID
        FROM UserRegistrations
        WHERE RegistrationID = <your_registration_id>
    )
);

-- Delete from EventRegistrations
DELETE FROM EventRegistrations
WHERE EventID IN (
    SELECT EventID
    FROM Events
    GROUP BY EventID
    HAVING COUNT(*) <= 1
);

-- 4. SELECT AND WHERE

-- User login query
SELECT
    UserID,
    UserName,
    FullName,
    UserEmail
FROM
    Users
WHERE
    UserName = 'johnlee' AND
    UserPassword = 'john_password';

-- Select event details for the "RIVERMAYA THE REUNION" event
SELECT
    EventName,          
    EventLocation,     
    EventDate,      
    SeatPlan           
FROM
    Events
WHERE
    EventName = 'RIVERMAYA THE REUNION';

-- Select upcoming events
SELECT
    EventName,     
    EventLocation,  
    EventDate         
FROM
    Events
WHERE
    EventDate >= CURRENT_DATE;

--  Retrieve events that have VIP tickets available
SELECT 
    EventName, 
    EventDate,
    TicketPrice
FROM 
    Events
WHERE 
    SeatCapacity > 0
    AND TicketPrice > 0;

-- Login query to check if an email and password match in the 'Admins' table
SELECT 
    AdminID,
    AdminEmail
FROM 
    Admins
WHERE 
    AdminEmail = 'Robbie@StarTruck.com'
    AND AdminPassword = 'Robbie_password';

--Retrieve information about events where the event date is in the future
SELECT 
    EventName, 
    EventDate, 
    EventLocation
FROM 
    Events
WHERE 
    EventDate >= CURRENT_DATE;

--  Selecting concert schedules for the month of January
SELECT 
    EventID,
    EventName,
    ArtistName,
    EventDate,
    EventLocation
FROM 
    Events
WHERE 
    EXTRACT(MONTH FROM EventDate) = 1;

-- 5. SELECT AND FROM

--. Retrieve event details from the Events table
SELECT 
    EventName, 
    EventDate 
FROM 
    Events;

--  Retrieve all events and their organizers
SELECT 
    EventName, 
    ArtistName
FROM 
    Events;

-- 6.SELECT, WHERE, AND ORDER OR GROUP BY

-- Retrieve upcoming events from the Events table
SELECT 
    EventID,
    EventName,
    ArtistName,
    EventDate,
    EventLocation
FROM 
    Events
WHERE 
    EventDate > CURRENT_DATE
ORDER BY 
    EventDate ASC;

-- 7. INSERT

--Admin registers a new event
INSERT INTO Events (
    EventID, EventName, ArtistName, 
    EventDate, EventLocation, 
    SeatCapacity, 
    TicketPrice, 
    SeatPlan)
VALUES 
    (11,'New Event Name', 'New Artist Name', '2023-12-31 18:00:00', 'New Location', 1000, 50.00, NULL);

--8. SELECT, MULTIPLE JOIN AND WHERE

--  Display event details along with corresponding seat information registered by a specific admin
SELECT 
    Events.EventID,
    Events.EventName,
    Events.ArtistName,
    Events.EventDate,
    Events.EventLocation,
    Events.SeatPlan
FROM 
    Events
JOIN 
    EventRegistrations ON Events.EventID = EventRegistrations.EventID
JOIN 
    Admins ON EventRegistrations.AdminID = Admins.AdminID
WHERE 
    Admins.AdminEmail = 'Robbie@StarTruck.com';

-- Retrieve information for users with pending transactions
SELECT
    U.UserName,       
    P.Amount AS AmountDue,          
    P.PaymentMethod AS ModeOfPayment, 
    U.PhoneNumber        
FROM
    Users U
JOIN 
    Tickets T ON U.UserID = T.UserID
JOIN 
    Payments P ON T.TicketID = P.TicketID
WHERE
    P.Status = 'Pending';   


--9. SELECT AND MULTIPLE JOIN

-- Retrieving user account, event, and transaction details for display in the user interface
SELECT
    Users.UserName, 
    Users.UserEmail, 
    Users.PhoneNumber,
    Payments.PaymentMethod AS ModeOfPayment,
    Events.EventName AS EventTitle, 
    Events.EventDate AS DateTime, 
    Events.EventLocation AS Venue,
    Payments.PaymentDate AS DateTimeTransacted,
    Tickets.Quantity, 
    Tickets.TypeName AS SeatType, 
    Tickets.TicketID, 
    Tickets.Price AS TicketPrice, 
    Payments.Amount,
    'Ticket Purchase' AS Particulars
FROM Users
JOIN Tickets ON Users.UserID = Tickets.UserID
JOIN Events ON Tickets.EventID = Events.EventID
JOIN Payments ON Tickets.TicketID = Payments.TicketID;

-- Retrieve information about administrators and their registered events
SELECT 
    Admins.AdminID, 
    Admins.AdminEmail, 
    EventRegistrations.RegistrationID, 
    Events.EventName, 
    Events.ArtistName, 
    Events.EventDate, 
    Events.EventLocation
FROM 
    Admins
JOIN 
    EventRegistrations ON Admins.AdminID = EventRegistrations.AdminID
JOIN 
    Events ON EventRegistrations.EventID = Events.EventID;

-- Retrieve user information along with the events they have registered for
SELECT 
    Users.UserName, 
    Users.FullName, 
    Events.EventName
FROM 
    Users
JOIN 
    Tickets ON Users.UserID = Tickets.UserID
JOIN 
    Events ON Tickets.EventID = Events.EventID;

-- Retrieve all payments along with user details and the associated event information
SELECT
    Payments.PaymentID, 
    Users.UserName, 
    Users.FullName, 
    Users.UserEmail, 
    Users.PhoneNumber,
    Events.EventName, 
    Tickets.TypeName, 
    Tickets.Price, Payments.Amount, 
    Payments.PaymentDate, 
    Payments.PaymentMethod, 
    Payments.Status
FROM 
    Payments
JOIN 
    Tickets ON Payments.TicketID = Tickets.TicketID
JOIN 
    Users ON Tickets.UserID = Users.UserID
JOIN 
    Events ON Tickets.EventID = Events.EventID;

-- 10. SELECT, MULTIPLE JOIN, WHERE, AND GROUP BY

-- Select ticket type, quantity, total amount, and payment method for a specific user
SELECT
    T.TypeName, 
    T.Quantity,     
    SUM(T.Price * T.Quantity) AS TotalAmount, 
    P.PaymentMethod
FROM
    Tickets T
JOIN
    Users U ON T.UserID = U.UserID 
JOIN
    Payments P ON T.TicketID = P.TicketID
WHERE
    U.UserName = 'johnlee'
GROUP BY
    T.TypeName, T.Quantity, P.PaymentMethod; 

-- 11. SELECT, SINGLE JOIN, AND WHERE

-- Select event information and details, including ticket names and prices per quantity, for the event "RIVERMAYA THE REUNION"
SELECT
    E.EventName,        
    E.EventLocation,   
    E.EventDate,      
    E.SeatPlan,        
    T.TypeName,       
    T.Price,           
    T.Quantity          
FROM
    Events E          
JOIN
    Tickets T ON E.EventID = T.EventID 
WHERE
    E.EventName = 'RIVERMAYA THE REUNION'; 

-- 12. SELECT AND SINGLE JOIN

-- Selecting information for a report on event registrations
SELECT 
    UR.RegistrationID,
    UR.UserName,
    UR.FullName,
    UR.UserEmail,
    UR.PhoneNumber,
    E.EventName,
    E.ArtistName,
    E.EventDate,
    E.EventLocation
FROM 
    UserRegistrations UR
JOIN 
    Events E ON UR.EventID = E.EventID;

-- 13. SELECT, MULTIPLE JOIN, LEFT JOIN, ORDER BY, and GROUP BY

-- Retrieve users, events, and the total amount paid by each user
SELECT 
    U.UserID,
    U.UserName,
    U.FullName,
    U.UserEmail,
    U.PhoneNumber,
    E.EventID,
    E.EventName,
    SUM(P.Amount) AS TotalAmountPaid
FROM 
    Users U
JOIN 
    Tickets T ON U.UserID = T.UserID
JOIN 
    Events E ON T.EventID = E.EventID
LEFT JOIN 
    Payments P ON T.TicketID = P.TicketID
GROUP BY 
    U.UserID, U.UserName, U.FullName, U.UserEmail, U.PhoneNumber, E.EventID, E.EventName
ORDER BY 
    U.UserID, E.EventID;

-- Retrieve events, ticket types, and the number of registrations for each combination
SELECT 
    E.EventID,
    E.EventName,
    T.TypeName AS TicketType,
    COUNT(UR.RegistrationID) AS NumberOfRegistrations
FROM 
    Events E
JOIN 
    Tickets T ON E.EventID = T.EventID
LEFT JOIN 
    UserRegistrations UR ON T.EventID = UR.EventID
GROUP BY 
    E.EventID, E.EventName, T.TypeName
ORDER BY 
    E.EventID, T.TypeName;

-- Retrieve events and the total number of registrations
SELECT 
    E.EventID,
    E.EventName,
    E.ArtistName,
    E.EventDate,
    E.EventLocation,
    COUNT(UR.RegistrationID) AS TotalRegistrations
FROM 
    Events E
LEFT JOIN 
    UserRegistrations UR ON E.EventID = UR.EventID
GROUP BY 
    E.EventID, E.EventName, E.ArtistName, E.EventDate, E.EventLocation
ORDER BY 
    TotalRegistrations DESC;

-- Retrieve users who made payments, ordered by the total amount paid in descending order
SELECT 
    U.UserID,
    U.UserName,
    U.FullName,
    U.UserEmail,
    U.PhoneNumber,
    SUM(P.Amount) AS TotalAmountPaid
FROM 
    Users U
JOIN 
    Tickets T ON U.UserID = T.UserID
JOIN 
    Payments P ON T.TicketID = P.TicketID
GROUP BY 
    U.UserID, U.UserName, U.FullName, U.UserEmail, U.PhoneNumber
ORDER BY 
    TotalAmountPaid DESC;

-- Retrieve users, events, and the total amount paid by each user (including pending payments)
SELECT 
    U.UserID,
    U.UserName,
    U.FullName,
    U.UserEmail,
    U.PhoneNumber,
    E.EventID,
    E.EventName,
    SUM(COALESCE(P.Amount, 0)) AS TotalAmountPaid
FROM 
    Users U
JOIN 
    Tickets T ON U.UserID = T.UserID
JOIN 
    Events E ON T.EventID = E.EventID
LEFT JOIN 
    Payments P ON T.TicketID = P.TicketID
GROUP BY 
    U.UserID, U.UserName, U.FullName, U.UserEmail, U.PhoneNumber, E.EventID, E.EventName
ORDER BY 
    TotalAmountPaid DESC;

-- 14. SELECT AND ORDER BY

-- Retrieve event information ordered by the event date in descending order
SELECT 
    EventName, 
    EventDate, 
    EventLocation
FROM 
    Events
ORDER BY 
    EventDate DESC;

--15. UPDATE TABLE

-- Update the artist name for the 'RIVERMAYA THE REUNION' event
UPDATE Events
SET ArtistName = 'Angela'
WHERE
    EventName = 'RIVERMAYA THE REUNION';

-- Update the quantity for a specific ticket type in the 'RIVERMAYA THE REUNION' event
UPDATE Tickets
SET Quantity = 4 
WHERE
    EventID = (SELECT EventID FROM Events WHERE EventName = 'RIVERMAYA THE REUNION')
    AND TypeName = 'FREE';
	
-- Update the location for the 'RIVERMAYA THE REUNION' event
UPDATE Events
SET EventLocation = 'Batangas State University'
WHERE
    EventName = 'RIVERMAYA THE REUNION';

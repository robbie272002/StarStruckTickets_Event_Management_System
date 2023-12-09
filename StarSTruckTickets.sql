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
    ('johnlee', 'John Lee', 'john.lee@gmail.com', 'john_password', '1234567890'),
    ('samsmith', 'Sam Smith', 'sam.smith@gmail.com', 'sam_password', '1234567890'),
    ('anthonyjones', 'Anthony Jones', 'anthony.jones@gmail.com', 'anthony_password', '1234567890'),
    ('snowwhite', 'Snow White', 'snow.white@gmail.com', 'snow_password', '1234567890'),
    ('michaeljames', 'Michael James', 'michael.james@gmail.com', 'michael_password', '1234567890'),
    ('taylorshees', 'Taylor Shees', 'taylor.shees@gmail.com', 'taylor_password', '1234567890'),
    ('jamesgordon', 'James Gordon', 'james.gordon@gmail.com', 'james_password', '1234567890');

-- Insert into Admins table for Admin Management (3 admins)
INSERT INTO Admins (AdminEmail, AdminPassword)
VALUES 
    ('Robbie@StarTruck.com', 'Robbie_password'),
    ('Julienne@StarTruck.com', 'Julienne_password'),
    ('Winston@StarTruck.com', 'Winston_password');

-- Insert into Events table for Event Creation
INSERT INTO Events (EventName, ArtistName, EventDate, EventLocation, SeatCapacity, TicketPrice, SeatPlan)
VALUES 
    ('Robbie World Tour', 'Robbie', '2024-06-27 19:00:00', 'Philippine Arena', 2000, 5000.00, NULL),
    ('RIVERMAYA THE REUNION', 'Rivermaya', '2024-02-17 19:00:00', 'SMDC Festival Grounds', 1000, 2250-14750.00, NULL),
    ('COLDPLAY MUSIC OF SPHERES WORLD TOUR', 'Coldplay', '2024-01-19 20:00:00', 'Philippine Arena', NULL, 2, NULL),
    ('ED SHEERAN TOUR', 'Ed Sheeran', '2024-03-09 19:00:00', 'SMDC Festival Grounds', NULL, 3, NULL),
    ('SEVENTEEN TOUR FOLLOW TO BULACAN', 'Seventeen', '2024-01-13 19:30:00', 'Philippine Sports Stadium', NULL, 4, NULL),
    ('THE SHOW NIALL HORAN LIVE ON TOUR 2024', 'Niall Horan', '2024-05-13 18:00:00', 'SM Mall Of Asia Arena', NULL, 5, NULL);

-- Insert into Tickets table for Ticket Management
INSERT INTO Tickets (UserID, EventID, TypeName, Price, Quantity, PaymentStatus)
VALUES 
    (1, 1, 'VIP STANDING', 15000.00, 2, 'Pending'),
    (2, 3, 'UPPERBOX', 7000.00, 1, 'Pending'),
    (3, 5, 'SILVER', 6550.00, 3, 'Pending'),
    (4, 5, 'BRONZE', 2250.00, 1, 'Pending'),
    (5, 4, 'GOLD', 11750.00, 2, 'Pending'),
    (6, 2, 'LOWERBOX', 10000.00, 1, 'Pending'),
    (7, 1, 'GENERAL ADMISSION', 3000.00, 2, 'Pending');  
	
-- Insert into Payments table for Payment Processing
INSERT INTO Payments (TicketID, Amount, PaymentDate, PaymentMethod, Status)
VALUES 
    (1, 600.00, '2023-10-16 12:45:00', 'Gcash', 'Paid'),
    (2, 500.00, '2023-10-17 09:30:00', 'Visa', 'Paid'),
    (3, 750.00, NULL, 'Pending', 'Pending'),
    (4, 1200.00, '2023-10-21 14:15:00', 'Gcash', 'Paid'),
    (5, 400.00, '2023-10-23 20:30:00', 'Visa', 'Paid'),
    (6, 1000.00, DEFAULT, 'Pending', 'Pending'),
    (7, 1600.00, '2023-10-29 16:00:00', 'Gcash', 'Paid'); 
	
-- Insert into EventRegistrations table for Admin Event Registrations
INSERT INTO EventRegistrations (AdminID, EventID)
VALUES 
    (1, 1),
    (2, 2),
    (3, 3),
    (2, 4),
    (1, 5),
    (2, 6);

-- Insert into UserRegistrations table for User Event Registrations
INSERT INTO UserRegistrations (UserName, FullName, UserEmail, PhoneNumber, EventID)
VALUES 
    ('john_lee', 'John Lee', 'john.lee@gmail.com', 1234567890, 1),
    ('sam_smith', 'Sam Smith', 'sam.smith@gmail.com', 9876543210, 3);

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
    EventName, ArtistName, 
    EventDate, EventLocation, 
    SeatCapacity, 
    TicketPrice, 
    SeatPlan)
VALUES 
    ('New Event Name', 'New Artist Name', '2023-12-31 18:00:00', 'New Location', 1000, 50.00, NULL);

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
    AND TypeName = '<ticket_type>';
	
-- Update the location for the 'RIVERMAYA THE REUNION' event
UPDATE Events
SET EventLocation = 'Batangas State University'
WHERE
    EventName = 'RIVERMAYA THE REUNION';

CREATE TABLE Company (
	CompanyId INT NOT NULL IDENTITY PRIMARY KEY,
	Name VARCHAR(40) NOT NULL UNIQUE
	)

CREATE TABLE PassengerIdType (
	PassengerIdTypeId INT NOT NULL IDENTITY PRIMARY KEY,
	Name VARCHAR(30) NOT NULL UNIQUE
	)

CREATE TABLE StaffShift (
	StaffShiftId INT NOT NULL IDENTITY PRIMARY KEY,
	StartTime TIME NOT NULL,
	EndTime TIME NOT NULL,
	WorksMonday BIT NOT NULL,
	WorksTuesday BIT NOT NULL,
	WorksWednesday BIT NOT NULL,
	WorksThursday BIT NOT NULL,
	WorksFriday BIT NOT NULL,
	WorksSaturday BIT NOT NULL,
	WorksSunday BIT NOT NULL
	)

CREATE TABLE Person (
	PersonId INT NOT NULL IDENTITY PRIMARY KEY,
	LastName VARCHAR(30) NOT NULL,
	FirstName VARCHAR(30) NOT NULL,
	DateOfBirth DATE NOT NULL
	)

CREATE TABLE Email (
	EmailId INT NOT NULL IDENTITY PRIMARY KEY,
	PersonId INT NOT NULL FOREIGN KEY REFERENCES Person(PersonId),
	Email VARCHAR(80) NOT NULL
	)

CREATE TABLE PhoneNumber (
	PhoneNumberId INT NOT NULL IDENTITY PRIMARY KEY,
	PersonId INT NOT NULL FOREIGN KEY REFERENCES Person(PersonId),
	PhoneNumber VARCHAR(15) NOT NULL
	)

CREATE TABLE Job (
	JobId INT NOT NULL IDENTITY PRIMARY KEY,
	JobTitle VARCHAR(40) NOT NULL
	)

CREATE TABLE BaggageStatus (
	BaggageStatusId INT NOT NULL IDENTITY PRIMARY KEY,
	Name VARCHAR(30) NOT NULL
	)

CREATE TABLE CarType (
	CarTypeId INT NOT NULL IDENTITY PRIMARY KEY,
	Name VARCHAR(50) NOT NULL
	)

CREATE TABLE SupplyType (
	SupplyTypeId INT NOT NULL IDENTITY PRIMARY KEY,
	Name VARCHAR(50) NOT NULL,
	Cost MONEY NOT NULL
	)

CREATE TABLE Hotel (
	HotelId INT NOT NULL IDENTITY PRIMARY KEY,
	HotelName VARCHAR(40) NOT NULL,
	HotelAddress VARCHAR(60) NOT NULL,
	NumberOfRooms INT NOT NULL,
	Price MONEY NOT NULL
	)

CREATE TABLE MaintenanceCode (
	MaintenanceCodeId INT NOT NULL IDENTITY PRIMARY KEY,
	Name VARCHAR(80) NOT NULL,
	Cost MONEY NOT NULL
	)

CREATE TABLE Runway (
	RunwayId INT NOT NULL IDENTITY PRIMARY KEY,
	IsOpen BIT NOT NULL,
	Length FLOAT NOT NULL,
	RunwayCode VARCHAR(30) NOT NULL
	)

CREATE TABLE Terminal (
	TerminalId INT NOT NULL IDENTITY PRIMARY KEY,
	IsOpen BIT NOT NULL,
	Name VARCHAR(50) NOT NULL
	)

CREATE TABLE Weather (
	WeatherId INT NOT NULL IDENTITY PRIMARY KEY,
	IsFlyable BIT NOT NULL,
	WeatherDescription VARCHAR(100) NOT NULL
	)

CREATE TABLE Country (
	CountryId INT NOT NULL IDENTITY PRIMARY KEY,
	CountryName VARCHAR(40) NOT NULL
	)

CREATE TABLE City (
	CityId INT NOT NULL IDENTITY PRIMARY KEY,
	CityName VARCHAR(50) NOT NULL,
	CountryId INT NOT NULL FOREIGN KEY REFERENCES Country(CountryId),
	Latitude DECIMAL(9,6) NOT NULL,
	Longitude DECIMAL(9,6) NOT NULL
	)

CREATE TABLE Airport (
	AirportId INT NOT NULL IDENTITY PRIMARY KEY,
	AirportCode VARCHAR(10) NOT NULL,
	AirportName VARCHAR(50) NOT NULL,
	CityId INT NOT NULL FOREIGN KEY REFERENCES City(CityId)
	)

CREATE TABLE Store (
	StoreId INT NOT NULL IDENTITY PRIMARY KEY,
	CompanyId INT NOT NULL FOREIGN KEY REFERENCES Company(CompanyId),
	LeaseAmountPerMonth MONEY NOT NULL,
	LeaseTermInMonths INT NOT NULL,
	LeaseDate DATE NOT NULL,
	StoreName VARCHAR(80) NOT NULL,
	TerminalId INT NOT NULL FOREIGN KEY REFERENCES Terminal(TerminalId),
	PhoneNumber VARCHAR(15) NOT NULL,
	EmergencyPhoneNumber VARCHAR(15) NOT NULL
	)

CREATE TABLE Staff (
	PersonId INT NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES Person(PersonId),
	Salary MONEY NOT NULL,
	CompanyId INT NOT NULL FOREIGN KEY REFERENCES Company(CompanyId),
	StaffShiftId INT NOT NULL FOREIGN KEY REFERENCES StaffShift(StaffShiftId),
	JobId INT NOT NULL FOREIGN KEY REFERENCES Job(JobId)
	)

CREATE TABLE Airline (
	AirlineID INT NOT NULL IDENTITY PRIMARY KEY,
	Name VARCHAR(50) NOT NULL,
	ContactId INT NOT NULL FOREIGN KEY REFERENCES Person(PersonId),
	Abbreviation VARCHAR(10) NOT NULL,
	CountryId INT NOT NULL FOREIGN KEY REFERENCES Country(CountryId),
	MonthlyRent MONEY NOT NULL
	)

CREATE TABLE Gate (
	GateId INT NOT NULL IDENTITY PRIMARY KEY,
	Name VARCHAR(10) NOT NULL,
	AirlineId INT NOT NULL FOREIGN KEY REFERENCES Airline(AirlineId),
	IsOccupied BIT NOT NULL,
	TerminalId INT NOT NULL FOREIGN KEY REFERENCES Terminal(TerminalId)
	)

CREATE TABLE HotelAffiliate (
	HotelAffiliateId INT NOT NULL IDENTITY PRIMARY KEY,
	AirlineId INT NOT NULL FOREIGN KEY REFERENCES Airline(AirlineId),
	HotelId INT NOT NULL FOREIGN KEY REFERENCES Hotel(HotelId)
	)

CREATE TABLE Passenger (
	PersonId INT NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES Person(PersonId),
	PassengerIdTypeId INT FOREIGN KEY REFERENCES PassengerIdType(PassengerIdTypeId),
	PassengerIdNumber INT
	)

CREATE TABLE HotelReservation (
	HotelReservationId INT NOT NULL IDENTITY PRIMARY KEY,
	HotelId INT NOT NULL FOREIGN KEY REFERENCES Hotel(HotelId),
	PassengerId INT NOT NULL FOREIGN KEY REFERENCES Passenger(PersonId),
	StartDate DATE NOT NULL,
	EndDate DATE NOT NULL,
	IsBilledToAirline BIT NOT NULL
	)

CREATE TABLE Manufacturer (
	ManufacturerId INT NOT NULL IDENTITY PRIMARY KEY,
	ManufacturerName VARCHAR(30) NOT NULL
	)

CREATE TABLE PlaneModel (
	PlaneModelId INT NOT NULL IDENTITY PRIMARY KEY,
	RequiredRunwayDistance FLOAT NOT NULL,
	Name VARCHAR(30) NOT NULL,
	ManufacturerId INT NOT NULL FOREIGN KEY REFERENCES Manufacturer(ManufacturerId),
	MaximumBaggageWeight INT NOT NULL
	)

CREATE TABLE Plane (
	PlaneId INT NOT NULL IDENTITY PRIMARY KEY,
	PlaneModelId INT NOT NULL FOREIGN KEY REFERENCES PlaneModel(PlaneModelId),
	AirlineId INT NOT NULL FOREIGN KEY REFERENCES Airline(AirlineId),
	TailNumber INT NOT NULL,
	DateProduced DATETIME NOT NULL
	)

CREATE TABLE Flight (
	FlightId INT NOT NULL IDENTITY PRIMARY KEY,
	DestinationAirportId INT NOT NULL FOREIGN KEY REFERENCES Airport(AirportId),
	SourceAirportId INT NOT NULL FOREIGN KEY REFERENCES Airport(AirportId),
	PlaneId INT NOT NULL FOREIGN KEY REFERENCES Plane(PlaneId),
	PilotId INT NOT NULL FOREIGN KEY REFERENCES Person(PersonId),
	CoPilotId INT NOT NULL FOREIGN KEY REFERENCES Person(PersonId),
	NavigatorId INT NOT NULL FOREIGN KEY REFERENCES Person(PersonId),
	GateId INT NOT NULL FOREIGN KEY REFERENCES Gate(GateId),
	DepartureTime DATETIME,
	ArrivalTime DATETIME
	)

CREATE TABLE RunwayReservation (
	RunwayReservationId INT NOT NULL IDENTITY PRIMARY KEY,
	StartDateTime DATETIME NOT NULL,
	EndDateTime DATETIME NOT NULL,
	RunwayId INT NOT NULL FOREIGN KEY REFERENCES Runway(RunwayId),
	FlightId INT NOT NULL FOREIGN KEY REFERENCES Flight(FlightId)
	)

CREATE TABLE PlaneModelSeating (
	PlaneModelSeatingId INT NOT NULL IDENTITY PRIMARY KEY,
	PlaneModelId INT NOT NULL FOREIGN KEY REFERENCES PlaneModel(PlaneModelId),
	SeatName VARCHAR(20) NOT NULL
	)

CREATE TABLE PlaneMaintenance (
	PlaneMaintenanceId INT NOT NULL IDENTITY PRIMARY KEY,
	PlaneId INT NOT NULL FOREIGN KEY REFERENCES Plane(PlaneId),
	MaintenanceCodeId INT NOT NULL FOREIGN KEY REFERENCES MaintenanceCode(MaintenanceCodeId),
	DatePerformed DATE,
	ActualCost MONEY,
	SupervisorId INT NOT NULL FOREIGN KEY REFERENCES Staff(PersonId)
	)

CREATE TABLE PlaneBoardingStatus (
	PlaneBoardingStatusId INT NOT NULL IDENTITY PRIMARY KEY,
	FlightId INT NOT NULL FOREIGN KEY REFERENCES Flight(FlightId),
	IsBaggageLoaded BIT NOT NULL,
	IsBoardingCompleted BIT NOT NULL,
	IsMaintenanceCompleted BIT NOT NULL,
	IsAmmenitySupplied BIT NOT NULL
	)

CREATE TABLE PlaneFlightStatus (
	PlaneFlightStatusId INT NOT NULL IDENTITY PRIMARY KEY,
	FlightId INT NOT NULL FOREIGN KEY REFERENCES Flight(FlightId),
	Altitude INT,
	Direction VARCHAR(12),
	FuelStatus INT,
	PilotId INT NOT NULL FOREIGN KEY REFERENCES Person(PersonId),
	CurrentWeatherId INT NOT NULL FOREIGN KEY REFERENCES Weather(WeatherId),
	DateAndTime DATETIME NOT NULL
	)

CREATE TABLE PlaneSupplyOnHand (
	PlaneSupplyOnHandId INT NOT NULL IDENTITY PRIMARY KEY,
	SupplyTypeId INT NOT NULL FOREIGN KEY REFERENCES SupplyType(SupplyTypeId),
	Quantity INT NOT NULL
	)

CREATE TABLE PlaneSupplyAssignment (
	PlaneSupplyAssignmentId INT NOT NULL IDENTITY PRIMARY KEY,
	FlightId INT NOT NULL FOREIGN KEY REFERENCES Flight(FlightId),
	SupplyTypeId INT NOT NULL FOREIGN KEY REFERENCES SupplyType(SupplyTypeId),
	Quantity INT NOT NULL
	)

CREATE TABLE Baggage (
	BaggageId INT NOT NULL IDENTITY PRIMARY KEY,
	PassengerId INT NOT NULL FOREIGN KEY REFERENCES Passenger(PersonId),
	FlightId INT NOT NULL FOREIGN KEY REFERENCES Flight(FlightId),
	BaggageTicketNumber VARCHAR(10) NOT NULL,
	Weight INT NOT NULL,
	BaggageStatusId INT NOT NULL FOREIGN KEY REFERENCES BaggageStatus(BaggageStatusId),
	IsIrregular BIT NOT NULL
	)

CREATE TABLE Seating (
	SeatingId INT NOT NULL IDENTITY PRIMARY KEY,
	PassengerId INT NOT NULL FOREIGN KEY REFERENCES Passenger(PersonId),
	FlightId INT NOT NULL FOREIGN KEY REFERENCES Flight(FlightId),
	PlaneModelSeatingId INT NOT NULL FOREIGN KEY REFERENCES PlaneModelSeating(PlaneModelSeatingId),
	IsCheckedIn BIT NOT NULL,
	Price MONEY NOT NULL,
	TicketNumber INT NOT NULL
	)

CREATE TABLE RentalCar (
	RentalCarId INT NOT NULL IDENTITY PRIMARY KEY,
	LicensePlate VARCHAR(10) NOT NULL,
	CarTypeId INT NOT NULL FOREIGN KEY REFERENCES CarType(CarTypeId),
	Owner INT NOT NULL FOREIGN KEY REFERENCES Company(CompanyId),
	DailyRate MONEY NOT NULL
	)

CREATE TABLE CarRental (
	CarRentalId INT NOT NULL IDENTITY PRIMARY KEY,
	PassengerId INT NOT NULL FOREIGN KEY REFERENCES Passenger(PersonId),
	RentalCarId INT NOT NULL FOREIGN KEY REFERENCES RentalCar(RentalCarId),
	StartDate DATE NOT NULL,
	EndDate DATE NOT NULL,
	InitialFuelLevel DECIMAL(6,5) NOT NULL
	)
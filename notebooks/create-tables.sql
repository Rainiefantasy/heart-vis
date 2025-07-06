CREATE TABLE Subjects (
    SubjectID SERIAL PRIMARY KEY,
    SubjectName VARCHAR(50) NOT NULL,
    DOB DATE NOT NULL
);

CREATE TABLE Measurements (
    MeasurementID SERIAL PRIMARY KEY,
    MeasurementName VARCHAR(30) NOT NULL,
    Description VARCHAR(50)
);

CREATE TABLE MeasurementUnit (
    MeasurementUnitID SERIAL PRIMARY KEY,
    MeasurementID INT NOT NULL,
    UnitName VARCHAR(10) NOT NULL,
    FOREIGN KEY (MeasurementID) REFERENCES Measurements(MeasurementID)
);

CREATE TABLE Visits (
    VisitID SERIAL PRIMARY KEY,
    SubjectID INT NOT NULL,
    VisitDate DATE NOT NULL,
    VisitWeek INT NOT NULL,
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);

CREATE TABLE Demographics (
    DemographicID SERIAL PRIMARY KEY,
    SubjectID INT NOT NULL,
    MeasurementID INT NOT NULL,
    MeasurementUnitID INT NOT NULL,
    Value FLOAT NOT NULL,
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID),
    FOREIGN KEY (MeasurementID) REFERENCES Measurements(MeasurementID),
    FOREIGN KEY (MeasurementUnitID) REFERENCES MeasurementUnit(MeasurementUnitID)
);

CREATE TABLE Questionnaires (
    QuestionnaireID SERIAL PRIMARY KEY,
    QuestionnaireName VARCHAR(50) NOT NULL,
    Description VARCHAR(100)
);

CREATE TABLE E_10 (
    E_10ID SERIAL PRIMARY KEY,
    SubjectID INT NOT NULL,
    VisitID INT NOT NULL,
    QuestionnaireID INT NOT NULL,
    Question_Number INT NOT NULL,
    Answer VARCHAR(255) NOT NULL,
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID),
    FOREIGN KEY (VisitID) REFERENCES Visits(VisitID),
    FOREIGN KEY (QuestionnaireID) REFERENCES Questionnaires(QuestionnaireID)
);

-- Sample inserts (remove SERIAL values or use DEFAULT for auto-increment)
INSERT INTO Subjects (SubjectName, DOB) VALUES
('John Doe', '1980-01-01'),
('Jane Smith', '1990-02-02');

INSERT INTO Measurements (MeasurementName, Description) VALUES
('Height', 'Patient height in centimeters'),
('Weight', 'Patient weight in kilograms');

INSERT INTO MeasurementUnit (MeasurementID, UnitName) VALUES
(1, 'cm'),
(2, 'kg');

INSERT INTO Visits (SubjectID, VisitDate, VisitWeek) VALUES
(1, '2023-01-01', 1),
(2, '2023-01-08', 1);

INSERT INTO Demographics (SubjectID, MeasurementID, MeasurementUnitID, Value) VALUES
(1, 1, 1, 180.5),
(1, 2, 2, 75.0),
(2, 1, 1, 165.0),
(2, 2, 2, 60.0);

INSERT INTO Questionnaires (QuestionnaireName, Description) VALUES
('E10', 'E10 Health questionnaire'),
('PHQ2/9', 'Depression symptoms questionnaire'),
('GAD2/7', 'Anxiety symptoms questionnaire');

INSERT INTO E_10 (SubjectID, VisitID, QuestionnaireID, Question_Number, Answer) VALUES
(1, 1, 1, 1, 'No'),
(1, 1, 1, 2, 'Yes'),
(2, 2, 1, 1, 'Yes'),
(2, 2, 1, 2, 'No');


SELECT * FROM Subjects;
SELECT * FROM Measurements;
SELECT * FROM MeasurementUnit;
SELECT * FROM Visits;
SELECT d.* ,m.MeasurementName FROM Demographics d
INNER JOIN Measurements m ON d.MeasurementID = m.MeasurementID;
SELECT * FROM Questionnaires;
SELECT * FROM E_10;

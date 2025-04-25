-- Creating dimension tables
dROP SCHEMA airbnb_dw;

Create Schema if not exists airbnb_dw;

Use airbnb_dw;

CREATE TABLE Dim_Host (
	Host_sur INT AUTO_INCREMENT PRIMARY KEY,
    Host_ID Int,
    Host_Name VARCHAR(255)
);

CREATE TABLE Dim_Neighbourhood_Group (
    Neighbourhood_Group_ID INT AUTO_INCREMENT PRIMARY KEY,
    Neighbourhood_Group VARCHAR(255)
);

CREATE TABLE Dim_Neighbourhood (
    Neighbourhood_ID INT AUTO_INCREMENT PRIMARY KEY,
    Neighbourhood VARCHAR(255)
);

CREATE TABLE Dim_Room_Type (
    Room_Type_ID INT AUTO_INCREMENT PRIMARY KEY,
    Room_Type VARCHAR(255)
);

CREATE TABLE Dim_Location (
    Listing_ID INT AUTO_INCREMENT PRIMARY KEY,
    Latitude DOUBLE,
    Longitude DOUBLE,
    Detailed_Location TEXT
);

-- Creating the Fact table
CREATE TABLE Fact_Listings (
    Host_sur INT,
    Neighbourhood_Group_ID INT,
    Neighbourhood_ID INT,
    Room_Type_ID INT,
    listing_id INT,
    Price INT,
    Minimum_Nights INT,
    Number_of_Reviews INT,
    Last_Review_Date DATE,
    Reviews_Per_Month FLOAT,
    Calculated_Host_Listings_Count INT,
    Number_of_Reviews_LTM INT,
    FOREIGN KEY (Host_sur) REFERENCES Dim_Host(Host_sur),
    FOREIGN KEY (Neighbourhood_Group_ID) REFERENCES Dim_Neighbourhood_Group(Neighbourhood_Group_ID),
    FOREIGN KEY (Neighbourhood_ID) REFERENCES Dim_Neighbourhood(Neighbourhood_ID),
    FOREIGN KEY (Room_Type_ID) REFERENCES Dim_Room_Type(Room_Type_ID),
    FOREIGN KEY (Listing_ID) REFERENCES Dim_Location(Listing_ID),
    Primary key(Host_sur,Neighbourhood_Group_ID, Neighbourhood_ID,Room_Type_ID )
);

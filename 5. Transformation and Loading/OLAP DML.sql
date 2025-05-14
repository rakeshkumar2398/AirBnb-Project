-- Check for duplicates in the OLTP source
SELECT distinct neighbourhood_group, neighbourhood, room_type, COUNT(*) as cnt
FROM airbnb_db.listings
GROUP BY host_id, neighbourhood_group, neighbourhood, room_type
HAVING cnt > 1;

-- Check for duplicates in dimension tables
SELECT distinct Host_ID, COUNT(*) as cnt FROM airbnb_dw.Dim_Host GROUP BY Host_ID HAVING cnt > 1;
-- Repeat for other dimensions

-- Assuming you want to refresh the table with unique entries
TRUNCATE TABLE airbnb_dw.Dim_Host;

INSERT INTO airbnb_dw.Dim_Host (Host_ID, Host_Name)
SELECT DISTINCT host_id, host_name
FROM airbnb_db.listings;




INSERT INTO airbnb_dw.Dim_Neighbourhood_Group (Neighbourhood_Group)
SELECT DISTINCT neighbourhood_group
FROM airbnb_db.listings;

INSERT INTO airbnb_dw.Dim_Neighbourhood (Neighbourhood)
SELECT DISTINCT neighbourhood
FROM airbnb_db.listings;

INSERT INTO airbnb_dw.Dim_Room_Type (Room_Type)
SELECT DISTINCT room_type
FROM airbnb_db.listings;

INSERT INTO airbnb_dw.Dim_Location (Latitude, Longitude, Detailed_Location)
SELECT DISTINCT latitude, longitude, detailed_location
FROM airbnb_db.listings;

INSERT INTO airbnb_dw.Fact_Listings (
    Host_sur,
    Neighbourhood_Group_ID,
    Neighbourhood_ID,
    Room_Type_ID,
    Listing_ID,
    Price,
    Minimum_Nights,
    Number_of_Reviews,
    Last_Review_Date,
    Reviews_Per_Month,
    Calculated_Host_Listings_Count,
    Number_of_Reviews_LTM
)
SELECT
    h.Host_sur,
    ng.Neighbourhood_Group_ID,
    n.Neighbourhood_ID,
    rt.Room_Type_ID,
    l.Listing_ID,
    ab.price,
    ab.minimum_nights,
    ab.number_of_reviews,
    ab.last_review,
    ab.reviews_per_month,
    ab.calculated_host_listings_count,
    ab.number_of_reviews_ltm
FROM airbnb_db.listings ab
JOIN airbnb_dw.Dim_Host h ON ab.host_id = h.Host_ID
JOIN airbnb_dw.Dim_Neighbourhood_Group ng ON ab.neighbourhood_group = ng.Neighbourhood_Group
JOIN airbnb_dw.Dim_Neighbourhood n ON ab.neighbourhood = n.Neighbourhood
JOIN airbnb_dw.Dim_Room_Type rt ON ab.room_type = rt.Room_Type
JOIN airbnb_dw.Dim_Location l ON ab.latitude = l.Latitude AND ab.longitude = l.Longitude AND ab.detailed_location = l.Detailed_Location
ON DUPLICATE KEY UPDATE
    Price = VALUES(Price),
    Minimum_Nights = VALUES(Minimum_Nights),
    Number_of_Reviews = VALUES(Number_of_Reviews),
    Last_Review_Date = VALUES(Last_Review_Date),
    Reviews_Per_Month = VALUES(Reviews_Per_Month),
    Calculated_Host_Listings_Count = VALUES(Calculated_Host_Listings_Count),
    Number_of_Reviews_LTM = VALUES(Number_of_Reviews_LTM);

$ ./hive
hive> CREATE TABLE [prefix]_flights
    > (
    > Year INT,
    > Month INT,
    > DayOfMonth INT,
    > DayOfWeek INT,
    > DepTime INT,
    > CRSDepTime INT,
    > ArrTime INT,
    > CRSArrTime INT,
    > UniqueCarrier STRING,
    > FlightNum INT,
    > TailNum STRING,
    > ActualElapsedTime INT,
    > CRSElapsedTime INT,
    > AirTime INT,
    > ArrDelay INT,
    > DepDelay INT,
    > Origin STRING,
    > Dest STRING,
    > Distance INT,
    > TaxiIn INT,
    > TaxiOut INT,
    > Cancelled INT,
    > CancellationCode STRING,
    > Diverted INT,
    > CarrierDelay INT,
    > WeatherDelay INT,
    > NASDelay INT,
    > SecurityDelay INT,
    > LateAircraftDelay INT
    > );


	hive> LOAD DATA LOCAL INPATH '[path/to/csv/file]' INTO TABLE [prefix]_flights;


	hive> SELECT * FROM [prefix]_flights LIMIT 10;


	hive> SELECT Origin, SUM(COALESCE(ArrDelay,0))/60.0 AS DelayHours 
	FROM [prefix]_flights WHERE ArrDelay > 0 
	GROUP BY Origin
	ORDER BY DelayHours DESC LIMIT 3;


	hive> SELECT UniqueCarrier, SUM(COALESCE(ArrDelay,0))/60.0 AS DelayHours 
	FROM [prefix]_flights WHERE ArrDelay > 0
	GROUP BY UniqueCarrier
	ORDER BY DelayHours DESC LIMIT 3;



	hive> SELECT UniqueCarrier, SUM(COALESCE(ArrDelay,0)) AS TotalArrDelay, 
	SUM(COALESCE(DepDelay,0)) AS TotalDepDelay
	FROM [prefix]_flights WHERE ArrDelay > 0 OR DepDelay > 0
	GROUP BY UniqueCarrier;

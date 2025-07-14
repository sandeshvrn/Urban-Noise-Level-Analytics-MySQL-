-- 📊 Advanced SQL: CTEs & Window Functions – Urban Noise Analytics

-- Query 1: CTE – Avg Noise Per Sensor Per Area
WITH sensor_noise AS (
    SELECT 
        s.sensor_id,
        s.area_name,
        ROUND(AVG(nr.decibel_level), 2) AS avg_noise
    FROM noise_readings nr
    JOIN sensors s ON nr.sensor_id = s.sensor_id
    GROUP BY s.sensor_id, s.area_name
)
SELECT * FROM sensor_noise
ORDER BY avg_noise DESC;



-- Query 2: RANK – Loudest Days Per Area
SELECT 
    s.area_name,
    DATE(nr.recorded_at) AS reading_date,
    ROUND(AVG(nr.decibel_level), 2) AS avg_noise,
    RANK() OVER (PARTITION BY s.area_name ORDER BY AVG(nr.decibel_level) DESC) AS noise_rank
FROM noise_readings nr
JOIN sensors s ON nr.sensor_id = s.sensor_id
GROUP BY s.area_name, DATE(nr.recorded_at);



-- Query 3: LAG – Compare Today vs Yesterday’s Avg Noise
WITH daily_avg AS (
    SELECT 
        DATE(recorded_at) AS reading_date,
        ROUND(AVG(decibel_level), 2) AS avg_noise
    FROM noise_readings
    GROUP BY DATE(recorded_at)
)
SELECT 
    reading_date,
    avg_noise,
    LAG(avg_noise) OVER (ORDER BY reading_date) AS previous_day_noise,
    (avg_noise - LAG(avg_noise) OVER (ORDER BY reading_date)) AS noise_difference
FROM daily_avg;



-- Query 4: ROW_NUMBER – First Reading Per Sensor
SELECT 
    sensor_id,
    recorded_at,
    decibel_level,
    ROW_NUMBER() OVER (PARTITION BY sensor_id ORDER BY recorded_at) AS row_num
FROM noise_readings;


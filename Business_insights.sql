-- 📊 Business Insight Queries – Urban Noise Analytics

-- Query 1: Top 5 Noisiest Areas
SELECT 
    s.area_name,
    ROUND(AVG(nr.decibel_level), 2) AS avg_decibel
FROM noise_readings nr
JOIN sensors s ON nr.sensor_id = s.sensor_id
GROUP BY s.area_name
ORDER BY avg_decibel DESC
LIMIT 5;

-- Query 2: Daily Noise Trends
SELECT 
    DATE(recorded_at) AS date,
    ROUND(AVG(decibel_level), 2) AS avg_daily_noise
FROM noise_readings
GROUP BY DATE(recorded_at)
ORDER BY date;

-- Query 3: Event Day Noise Impact
SELECT 
    e.area_name,
    e.event_name,
    e.event_date,
    ROUND(AVG(nr.decibel_level), 2) AS avg_decibel_on_event_day
FROM events e
JOIN sensors s ON e.area_name = s.area_name
JOIN noise_readings nr 
  ON nr.sensor_id = s.sensor_id 
 AND DATE(nr.recorded_at) = e.event_date
GROUP BY e.area_name, e.event_name, e.event_date
ORDER BY avg_decibel_on_event_day DESC;

-- Query 4: Top 5 Busiest Sensors
SELECT 
    sensor_id,
    COUNT(*) AS total_readings,
    ROUND(AVG(decibel_level), 2) AS avg_decibel
FROM noise_readings
GROUP BY sensor_id
ORDER BY total_readings DESC
LIMIT 5;

-- Query 5: Noise Category Distribution
SELECT 
    CASE
        WHEN decibel_level < 60 THEN 'Low'
        WHEN decibel_level BETWEEN 60 AND 80 THEN 'Moderate'
        ELSE 'High'
    END AS noise_category,
    COUNT(*) AS total_records
FROM noise_readings
GROUP BY noise_category;

-- Query 6: Hourly Noise Pattern
SELECT 
    HOUR(recorded_at) AS hour_of_day,
    ROUND(AVG(decibel_level), 2) AS avg_noise
FROM noise_readings
GROUP BY hour_of_day
ORDER BY avg_noise DESC;

-- Query 7: Event Day vs Normal Day Noise
SELECT 
    CASE 
        WHEN DATE(nr.recorded_at) IN (SELECT event_date FROM events) 
        THEN 'Event Day' 
        ELSE 'Normal Day' 
    END AS day_type,
    ROUND(AVG(nr.decibel_level), 2) AS avg_decibel
FROM noise_readings nr
GROUP BY day_type;

-- Query 8: Avg Noise by Event Type
SELECT 
    e.event_type,
    COUNT(DISTINCT e.event_id) AS total_events,
    ROUND(AVG(nr.decibel_level), 2) AS avg_noise_during_event
FROM events e
JOIN sensors s ON e.area_name = s.area_name
JOIN noise_readings nr ON nr.sensor_id = s.sensor_id 
    AND DATE(nr.recorded_at) = e.event_date
GROUP BY e.event_type
ORDER BY avg_noise_during_event DESC;

-- Query 9: Areas with Unsafe Noise Levels (>85 dB)
SELECT 
    s.area_name,
    COUNT(*) AS unsafe_readings,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM noise_readings), 2) AS percent_of_total
FROM noise_readings nr
JOIN sensors s ON nr.sensor_id = s.sensor_id
WHERE nr.decibel_level > 85
GROUP BY s.area_name
ORDER BY unsafe_readings DESC;

-- Query 10: Daytime vs Nighttime Noise by Area
SELECT 
    s.area_name,
    CASE 
        WHEN HOUR(nr.recorded_at) BETWEEN 6 AND 21 THEN 'Daytime'
        ELSE 'Nighttime'
    END AS time_period,
    ROUND(AVG(nr.decibel_level), 2) AS avg_noise
FROM noise_readings nr
JOIN sensors s ON nr.sensor_id = s.sensor_id
GROUP BY s.area_name, time_period
ORDER BY s.area_name, time_period;

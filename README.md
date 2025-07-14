# Urban-Noise-Level-Analytics-MySQL

This project analyzes urban noise data using structured SQL to derive actionable insights for city planners and environmental agencies. It uses data from sensors installed across multiple areas, events organized in those regions, and noise readings collected over time.

## 📁 Project Structure
Urban-Noise-Analytics/
├── SQL/
│ ├── schema.sql
│ ├── data_exploration.sql
│ ├── data_cleaning.sql
│ ├── business_insights.sql
│ ├── advanced_sql_cte_window.sql
├── outputs/
│ ├── Data Exploration Cleaning
│ ├── Business_insights
│ ├── Advanced_sql_CTEs_Windows
│ └── ...
└── README.md

---

## 🧠 Tools & Concepts Used

- ✅ **MySQL**
- ✅ Joins (INNER, LEFT)
- ✅ Aggregations (AVG, COUNT)
- ✅ Conditional logic (`CASE`)
- ✅ Window functions (`RANK`, `LAG`, `ROW_NUMBER`)
- ✅ Common Table Expressions (CTEs)
- ✅ Date and time functions

---

## 📌 Problem Statement

Urban areas are experiencing increasing noise pollution due to events, traffic, and high population density. This project explores:
- Which areas are noisiest?
- How do events impact noise levels?
- When are cities loudest during the day?

---

## 📊 Data Exploration & Cleaning 
Conducted structured data exploration, null audits, outlier detection, and referential integrity checks to ensure analytical readiness.


## 📊 Key Business Insight Queries

| Question                                                                 | SQL Concept             |
|--------------------------------------------------------------------------|------------------------ |
| 1. What are the top 5 noisiest areas?                                    | AVG, GROUP BY           |
| 2. What is the trend of average noise over time?                         | DATE(), GROUP BY, ROUND |
| 3. Did events increase noise in their areas?                             | JOIN, DATE, ROUND       |
| 4. Top 5 busiest sensors (by reading count)?                             | COUNT, GROUP BY         |
| 5. Noise category distribution (Low/Moderate/High)?                      | CASE, GROUP BY          |
| 6. Hourly noise patterns (which hours are loudest)?                      | HOUR(), GROUP BY        |
| 7. Event day vs normal day noise comparison                              | Subquery, CASE          |
| 8. Which event types have the highest average noise?                     | JOIN, AVG, GROUP BY     |
| 9. Which areas have the most unsafe readings (>85 dB)?                   | WHERE, GROUP BY         |
|10. Avg noise during daytime vs nighttime per area                        | CASE, GROUP BY          |

---

## 🔍 Advanced SQL – CTEs & Window Functions 

| Analysis                                                                    | Technique                |
|-----------------------------------------------------------------------------|--------------------------|
| Avg noise per sensor per area (CTE)                                         | CTE, JOIN                |
| Rank loudest days per area                                                  | RANK() OVER              |
| Compare today's noise with yesterday's                                      | LAG()                    |
| Detect first reading for each sensor                                        | ROW_NUMBER() OVER        |

---

## 📤 Sample Query Outputs

All major queries are attached as `.txt` files (Notepad) and Word documents files which has screenshots of the MYSQL workbench output in the `outputs/` folder. These are ideal for Showcasing results.
File name:
1) Data Exploration Cleaning
2) Business_insights
3) Advanced_sql_CTEs_Windows
---

## 🧠 Key Takeaways

- Events are associated with significant noise spikes.
- Certain areas consistently breach safe noise thresholds (>85 dB).
- Noise is highest in late evenings, suggesting urban activity congestion.
- Busiest sensors may require maintenance based on reading volume.

---

## 🙋‍♂️ Author

**Sandesh Varun**  
Aspiring Data Analyst | SQL & Power BI Enthusiast  
📧 sandeshvrn@gmail.com

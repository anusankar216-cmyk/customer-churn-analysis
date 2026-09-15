-- Overall churn rate
SELECT 
    Churn, 
    COUNT(*) AS total,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customers), 2) AS percentage
FROM customers
GROUP BY Churn;

-- Churn rate by contract type
SELECT 
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned,
    ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY Contract;

-- Average monthly charges: churned vs retained
SELECT 
    Churn,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges
FROM customers
GROUP BY Churn;

-- Churn rate by tenure group
SELECT 
    CASE 
        WHEN tenure <= 12 THEN '0-1 year'
        WHEN tenure <= 24 THEN '1-2 years'
        WHEN tenure <= 48 THEN '2-4 years'
        ELSE '4+ years'
    END AS tenure_group,
    COUNT(*) AS total,
    SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned,
    ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY tenure_group; 

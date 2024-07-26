use churn_analysis;
select * from dbo.stg_churn_data;




--- Demographic Analysis
--- What is the demographic profile (age, gender, marital status, state) of customers who are more likely to churn?
--- Does age have any impact on customer churn rates?

-- Gender
select gender, count(gender) as total_count,
count(gender) * 100.1 / (select count(*) from dbo.stg_churn_data) as total_percentage
from dbo.stg_churn_data
group by Gender;


-- Age
select 
case
	WHEN Age < 18 THEN 'Under 18'
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 60 THEN '46-60'
        ELSE 'Above 60'
    END AS Age_Group,
	count(*) as customer_Count

from dbo.stg_churn_data
GROUP BY 
    case
	WHEN Age < 18 THEN 'Under 18'
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 60 THEN '46-60'
        ELSE 'Above 60'
    END
	order by 
		Age_Group;

select * from stg_churn_data;

-- Marital Status
select Married, count(Married) as total_count,
count(Married) * 100.0 / (select count(*) from stg_churn_data)
from stg_churn_data
group by Married;


-- top state customers from
select top 10 
state, count(state) as total_count from stg_churn_data
group by state
order by total_count desc;


--corelation between age and churn rate
select Customer_Status,
case
	WHEN Age < 18 THEN 'Under 18'
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 60 THEN '46-60'
        ELSE 'Above 60'
    END AS Age_Group,
	count(*) as customer_Count,
	count(Customer_Status) *100.0 / (select count(*) from stg_churn_data) as total_percentage

from dbo.stg_churn_data
GROUP BY Customer_Status,
    case
	WHEN Age < 18 THEN 'Under 18'
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 60 THEN '46-60'
        ELSE 'Above 60'
    END
	order by 
		Age_Group;



-- Contracts of customers
select 
	dbo.stg_churn_data.Contract, 
	count(Contract) as total_count,
	count(Contract) * 100.0 / (Select count(*) from stg_churn_data) as total_Percentage
from dbo.stg_churn_data
group by Contract;


--Customer Status
SELECT 
    Customer_Status, 
    SUM(Total_Revenue) AS Total_Revenue,
    SUM(Total_Revenue) * 100.0 / SUM(SUM(Total_Revenue)) OVER () AS Percentage_of_Total_Revenue
FROM dbo.stg_churn_data
GROUP BY Customer_Status;


-- checking the number of null values 
SELECT 

    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Customer_ID_Null_Count,

    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_Null_Count,

    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Age_Null_Count,

    SUM(CASE WHEN Married IS NULL THEN 1 ELSE 0 END) AS Married_Null_Count,

    SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS State_Null_Count,

    SUM(CASE WHEN Number_of_Referrals IS NULL THEN 1 ELSE 0 END) AS Number_of_Referrals_Null_Count,

    SUM(CASE WHEN Tenure_in_Months IS NULL THEN 1 ELSE 0 END) AS Tenure_in_Months_Null_Count,

    SUM(CASE WHEN Value_Deal IS NULL THEN 1 ELSE 0 END) AS Value_Deal_Null_Count,

    SUM(CASE WHEN Phone_Service IS NULL THEN 1 ELSE 0 END) AS Phone_Service_Null_Count,

    SUM(CASE WHEN Multiple_Lines IS NULL THEN 1 ELSE 0 END) AS Multiple_Lines_Null_Count,

    SUM(CASE WHEN Internet_Service IS NULL THEN 1 ELSE 0 END) AS Internet_Service_Null_Count,

    SUM(CASE WHEN Internet_Type IS NULL THEN 1 ELSE 0 END) AS Internet_Type_Null_Count,

    SUM(CASE WHEN Online_Security IS NULL THEN 1 ELSE 0 END) AS Online_Security_Null_Count,

    SUM(CASE WHEN Online_Backup IS NULL THEN 1 ELSE 0 END) AS Online_Backup_Null_Count,

    SUM(CASE WHEN Device_Protection_Plan IS NULL THEN 1 ELSE 0 END) AS Device_Protection_Plan_Null_Count,

    SUM(CASE WHEN Premium_Support IS NULL THEN 1 ELSE 0 END) AS Premium_Support_Null_Count,

    SUM(CASE WHEN Streaming_TV IS NULL THEN 1 ELSE 0 END) AS Streaming_TV_Null_Count,

    SUM(CASE WHEN Streaming_Movies IS NULL THEN 1 ELSE 0 END) AS Streaming_Movies_Null_Count,

    SUM(CASE WHEN Streaming_Music IS NULL THEN 1 ELSE 0 END) AS Streaming_Music_Null_Count,

    SUM(CASE WHEN Unlimited_Data IS NULL THEN 1 ELSE 0 END) AS Unlimited_Data_Null_Count,

    SUM(CASE WHEN Contract IS NULL THEN 1 ELSE 0 END) AS Contract_Null_Count,

    SUM(CASE WHEN Paperless_Billing IS NULL THEN 1 ELSE 0 END) AS Paperless_Billing_Null_Count,

    SUM(CASE WHEN Payment_Method IS NULL THEN 1 ELSE 0 END) AS Payment_Method_Null_Count,

    SUM(CASE WHEN Monthly_Charge IS NULL THEN 1 ELSE 0 END) AS Monthly_Charge_Null_Count,

    SUM(CASE WHEN Total_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Charges_Null_Count,

    SUM(CASE WHEN Total_Refunds IS NULL THEN 1 ELSE 0 END) AS Total_Refunds_Null_Count,

    SUM(CASE WHEN Total_Extra_Data_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Extra_Data_Charges_Null_Count,

    SUM(CASE WHEN Total_Long_Distance_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Long_Distance_Charges_Null_Count,

    SUM(CASE WHEN Total_Revenue IS NULL THEN 1 ELSE 0 END) AS Total_Revenue_Null_Count,

    SUM(CASE WHEN Customer_Status IS NULL THEN 1 ELSE 0 END) AS Customer_Status_Null_Count,

    SUM(CASE WHEN Churn_Category IS NULL THEN 1 ELSE 0 END) AS Churn_Category_Null_Count,

    SUM(CASE WHEN Churn_Reason IS NULL THEN 1 ELSE 0 END) AS Churn_Reason_Null_Count

FROM dbo.stg_churn_data;


--creating new table without a null value
SELECT 

    Customer_ID,

    Gender,

    Age,

    Married,

    State,

    Number_of_Referrals,

    Tenure_in_Months,

    ISNULL(Value_Deal, 'None') AS Value_Deal,

    Phone_Service,

    ISNULL(Multiple_Lines, 'No') As Multiple_Lines,

    Internet_Service,

    ISNULL(Internet_Type, 'None') AS Internet_Type,

    ISNULL(Online_Security, 'No') AS Online_Security,

    ISNULL(Online_Backup, 'No') AS Online_Backup,

    ISNULL(Device_Protection_Plan, 'No') AS Device_Protection_Plan,

    ISNULL(Premium_Support, 'No') AS Premium_Support,

    ISNULL(Streaming_TV, 'No') AS Streaming_TV,

    ISNULL(Streaming_Movies, 'No') AS Streaming_Movies,

    ISNULL(Streaming_Music, 'No') AS Streaming_Music,

    ISNULL(Unlimited_Data, 'No') AS Unlimited_Data,

    Contract,

    Paperless_Billing,

    Payment_Method,

    Monthly_Charge,

    Total_Charges,

    Total_Refunds,

    Total_Extra_Data_Charges,

    Total_Long_Distance_Charges,

    Total_Revenue,

    Customer_Status,

    ISNULL(Churn_Category, 'Others') AS Churn_Category,

    ISNULL(Churn_Reason , 'Others') AS Churn_Reason

 

INTO [churn_analysis].[dbo].[prod_Churn_analysis]

FROM [churn_analysis].[dbo].[stg_churn_data];


--- viewing production table
select * from dbo.prod_Churn_analysis;


--- Creating view
create view vw_churnData as 
	select * from dbo.prod_Churn_analysis
		where Customer_Status in ('Churned', 'Stayed');


create view vw_joinData as 
	select * from dbo.prod_Churn_analysis
		where Customer_Status = 'Joined';
use class; 

-- Question 1 Generate a query to get the sum of the clicks of the marketing data ​
Select SUM(clicks) AS Sum_Of_Clicks
FROM marketing_data;

-- Question 2 Generate a query to gather the sum of revenue by store_location from the store_revenue table ​
Select SUM(revenue) AS Sum_Of_Revenue, store_location
FROM store_revenue
GROUP BY store_location;

-- Question 3 Merge these two datasets so we can see impressions, clicks, and revenue together by date and geo. Please ensure all records from each table are accounted for. ​
-- use the UNION function to connect values from both select statements. Use Right() function to get the 2 right most characters in store_location for the state
Select store_revenue.date, geo, impressions, clicks, revenue
FROM store_revenue LEFT JOIN marketing_data
ON store_revenue.date = marketing_data.date AND right(store_revenue.store_location, 2) = marketing_data.geo
UNION Select store_revenue.date, geo, impressions, clicks, revenue
FROM store_revenue RIGHT JOIN marketing_data
ON store_revenue.date = marketing_data.date AND right(store_revenue.store_location, 2) = marketing_data.geo;


-- QUestion 4 In your opinion, what is the most efficient store and why? ​
-- Answer: Brand 2 in California had the highest revenue per click and revenue per impression which is why it is the most efficient store.
-- use simple arithmetic to find revenues per click and revenue per impression.
Select store_revenue.date, brand_id,store_revenue.store_location AS geo, (revenue/impressions) AS Revenue_Per_Impression, (revenue/clicks) AS Revenue_Per_Click
FROM store_revenue LEFT JOIN marketing_data
ON store_revenue.date = marketing_data.date AND right(store_revenue.store_location, 2) = marketing_data.geo
UNION Select store_revenue.date, brand_id, store_revenue.store_location AS geo, (revenue/impressions) AS Revenue_Per_Impression, (revenue/clicks) AS Revenue_Per_Click
FROM store_revenue RIGHT JOIN marketing_data
ON store_revenue.date = marketing_data.date AND right(store_revenue.store_location, 2) = marketing_data.geo;

-- Question 5 (Challenge) Generate a query to rank in order the top 10 revenue producing states ​
-- group the sum of revenue together by state
Select right(store_revenue.store_location, 2) AS State, SUM(revenue) AS Total_Revenue
FROM store_revenue
GROUP BY right(store_revenue.store_location, 2) 
ORDER BY SUM(revenue) desc
LIMIT 10;
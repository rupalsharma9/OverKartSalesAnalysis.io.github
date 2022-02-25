#Task 1
#Find the list of email IDs of all the customers
select Email_ID as "Email addresses of Customers" from public.customers;

#Task 2
#Get all attributes of the vendors data
select * from public.vendors;

#Task 3
#Check the first 5 first names of customers
select First_Name as "First Name of Customers" from public.customers limit 5;

#Task 4
#Check the list of unique ages of vendors for each gender
select distinct Gender,Age from public.vendors;

#Task 5
#Check for count of unique customers in the Customers dataset
select * from public.sales;
select count(distinct(ID)) from public.customers;

#Task 6
#Check for count of unique customers who made a purchase at the store
select count(distinct (Customer_ID)) from public.sales
where Sale_Amount>0;

#Task 6
#Find the unique list of first name and last name of customers
select distinct first_name,last_name from public.customers;

#Task 7
#Find the count of distinct dates that sales were made on in the month of February
select count(distinct Sale_Date ) from public.sales
where Sale_Date between '2020-02-01' and '2020-02-28';


#Task 8
#Find the age and email id of the customer by the name Jasmine.
select Age,Email_ID from public.customers
where first_name='Jasmine';

#Task 9
#Find the number of transactions that took place all dates except for 18th 
#January 2020 and 1st March 2020
select count(Sale_ID) from public.sales
where Sale_date not in ('2020-01-18','2020-03-01');

#Task 10
#Check first name of all the Male customers
select first_name from public.customers
where upper(gender)='M';

#Task 11
#Find the unique list of first name of customers who either have ID more
#than 15000 or are female and at least 34 years old.
select distinct first_name from public.customers
where ID>15000 or (upper(gender)='F' and age>=34);


#Task 12
#Find out how many returns (negative sale amount) happened between 1st Jan and 1st March
select count(Sale_Amount) from public.sales
where Sale_Amount<0 and Sale_Date between '2020-01-01' and '2020=03-01';


#TASK 13
#Find first name of the customers who have a 2 in their email ID.
select first_name from public.customers
where email_ID like '%2';

#TASK 14
#Find list of email id of the customers whose last name contains the letter ‘N’.
select email_ID from public.customers
where upper(last_name) like '%N%';


#TASK 15
#Find first name and last name of vendors with either first name or
#last name as one of the following : Peake,Matt,Simon,Dyer
select * from public.vendors;
select First_Name , Last_Name from public.vendors 
where first_name in ('Peake','Matt','Simon','Dyer') or last_name in ('Peake','Matt','Simon','Dyer');


#TASK 16
#Find first name of all customers whose first name has the character ‘a’ as the second letter
select first_name from public.customers
where first_name like ('_a%');


#TASK 17
#Find first name of all vendors whose first name has the character ‘a’
select First_Name from public.vendors
where upper(First_Name) like ('%A%');


#TASK 18
#Considering only sales (that is, not considering returns), find the lowest and highest sale amount that happened
#between 14th January and 8th April 2020.
select min(Sale_Amount) as "Lowest_Sale_Amount",max(Sale_Amount) as "Maximum_Sale_Amount" 
from public.sales
where Sale_Amount>0 and Sale_Date between '2020-01-14' and '2020-04-08';


#TASK 19
#Find the first and last date on which a sale happened.
select min(Sale_Date) as "First_Date" , max(Sale_Date) as "Last_Date"
from public.sales
where Sale_Amount>0;


#TASK 20
#Find the first date that a transaction took place in the month of April
Select min(Sale_date) as "First_Day_Of_Transaction"
from public.sales
where Sale_Date>='2020-04-01' and Sale_Date<='2020-04-30';


#TASK 21
#For each customer, calculate the number of dates he made a trip to the store.
select * from public.customers;
select * from public.sales;
select Customer_ID,count(Sale_date) as "trips" from public.sales
where (Sale_Amount>0 or Sale_Amount<0)
group by Customer_ID;


#TASK 22
#Find the sum of sale amount, the average of sale amount, the max sale amount and the min
#sale amount for all transactions that took place in the month of March
select sum(Sale_Amount) as "Sum",avg(Sale_Amount) as "Average" , max(Sale_Amount) as "Maximum",
min(Sale_Amount) as "Minimum" from public.sales
where Sale_date between '2020-03-01' and '2020-03-31';


#TASK 23
#Find unique list of first name and last names of customers.
select distinct first_name,last_name from public.customers;

select first_name, last_name from public.customers
group by first_name,last_name;


#TASK 24
#How many vendors are there who have a last name?
select * from public.vendors;


#TASK 25
select count(last_name) as "count of last name" from public.vendors;


#TASK 26
#Find the unique dates on which a transaction/sale occurred in 
#January, but you can’t use DISTINCT keyword
select Sale_Date from public.sales
where Sale_Date between '2020-01-01' and '2020-01-31'
group by Sale_Date;


#TASK 27
#Find the total sale amount on each day a transaction was made but
#consider only those dates where more than one customer made a purchase.
Select Sale_Date , sum(Sale_Amount) from public.sales
where (Sale_Amount>0 or Sale_Amount<0) 
group by Sale_Date
having count(Customer_ID)>1;


#TASK 28
#Find a list of pair of customer ID and vendor ID where a customer
#has been billed by same vendor more than once.
select * from public.sales;
select customer_ID , vendor_id from public.sales
group by customer_ID,vendor_ID
having count(vendor_ID)>1;


#TASK 29
#Get the total sale amount that each vendor has been independently responsible for, 
#but only considering those vendors whose first transaction was after 1st Feb 2020.
select vendor_ID , sum(Sale_Amount) from public.sales
group by vendor_ID
having min(Sale_Date)>'2020-02-01';


#TASK 30
#Find the transaction id (sale_id) and the sale amount of each transaction that
#Frank (customer) made at the store.
select sale_ID , Sale_Amount from public.sales
where Customer_ID=(select ID from public.customers where First_Name='Frank');


#Task 31
#Get all the attributes and limit the records to 5 after performing an 
#inner join between vendor table and the sale table.
select * from public.sales inner join public.vendors
on sales.Vendor_ID=vendors.ID
limit 5;

#Task 32
#Find the first name of the vendor for each transaction (sale_id) that
#happened in the month of February.
select * from public.sales;
select sales.Sale_ID,vendors.First_Name from public.sales inner join public.vendors
on sales.Vendor_ID=vendors.ID
where Sale_Date between '2020-02-01' and '2020-02-28';

#Task 33
#For all transactions having sale amount more than 600 and having been
#billed by a female vendor, find the first name and last name of the vendor
#along with the sale_id. Ignore any transaction which doesn’t have vendor
#data as per vendors table.
select First_Name,Last_Name,Sale_ID from public.vendors left join public.sales
on Id=Vendor_ID
where Sale_Amount>600 and upper(Gender)='F';


#Task 34
#For all transactions having been billed by a vendor from department B, find the date of transaction, the
#amount of transaction and the email id of the customer involved in the transaction. Ignore any transaction
#which doesn’t have customers data in the customers table.
select Sale_Amount,Sale_Date , email_ID from public.sales left join public.customers
on Customer_ID=ID
where Vendor_ID like '%B%';


#Task 35
#For each customer in customers table, find the first name of the customer and the
#transaction (sale_id) he has been involved in provided that the transaction happened in the
#month of March. Ignore any customer who didn’t make a transaction for the given filter.
select first_name , sale_id from public.customers left join public.sales
on ID=Customer_ID
where Sale_Date between '2020-03-01' and '2020-03-31';


#Task 36
#For each customer in customers table, find the first name of the customer and the transaction (sale_id) he has been involved in
#provided that the transaction happened in the month of March.
#DO NOT remove any customer who doesn’t have a transaction for the given set of filter.
select first_name,Sale_ID from public.customers left join public.sales
on Customer_ID=ID
AND Sale_Date between '2020-03-01' and '2020-03-31';

#Task 37
#Find all records and attributes from the sale table for transactions made by a male customer.
select * from public.sales 
where Customer_ID in(select ID from public.customers where upper(Gender)='M');

#Task 38
#Find the first name of the vendors and the number of transactions that they were involved in.
#In case a vendor didn’t make a transition, you should still retain the name in the output table.
select first_name , count(Sale_ID) from public.vendors left join public.sales
on Vendor_ID=ID
group by first_name;

#Task 39
#Find all records and attributes from the sale table for transactions made by a male customer.
select * from public.sales 
where Customer_ID in 
(select ID from public.customers where upper(Gender)='M');

#Task 40
#Find the unique list of first name of all customers who made a transaction billed by a male vendor.
select distinct First_name from public.customers
where Id in 
(select Customer_ID from public.sales where Vendor_ID in 
(select ID from public.vendors where upper(Gender)='M') )
order by first_name;

#Task 41
#Find a combined list of ages of the customers and the vendors dataset. Add an extra column to specify the type of person for
#which the age is mentioned. Remove the duplicate values from the final table.
select * from public.vendors;
select Age, "Customers"  as "type" from public.customers
union
select Age , "Vendors" as "type" from public.vendors;


#Task 42
#Find a combined list of ages of the customers and the vendors dataset. Add an extra column to specify the type of person for
#which the age is mentioned. Do not remove the duplicate values from the final table.
select Age, "Customers" as "Type" from public.customers
union all
select Age, "Vendors" as "Type" from public.vendors;


#Task 43
#Find the count of distinct customers who have taken part in a transaction and also, separately, take the count of distinct
#vendors who have been part of a transaction and combine the two results. So, finally, you should have two attributes, one
#which explains the category of people – vendor or customer (has to be made additionally), and the count of people in that
#category. There will be two records, one for the customer category and count, and other for vendor category and count.
select count(distinct(ID)) , "Customers" as "Type" from public.customers left join public.sales
on Customer_ID=ID
where Sale_Amount>0
union all 
select count(distinct(ID)) , "Vendors" as "Type" from public.vendors left join public.sales
on Vendor_ID=ID
where Sale_Amount>0 or Sale_Amount<0;   #less than 0 signifies returns 


#Task 44
#For each transaction that occurred in January to March, assign the month name corresponding to the transaction that took place
#in that particular month.
select sale_id,month(Sale_Date) as "month-number","January" as "month" from public.sales where Sale_Date between '2020-01-01' and '2020-01-31'
union all
select sale_id,month(Sale_Date) as "month-number","Feburary" as "month" from public.sales where Sale_Date between '2020-02-01' and '2020-02-28'
union all
select sale_id,month(Sale_Date) as "month-number","March" as "month" from public.sales where Sale_Date between '2020-03-01' and '2020-03-31';


#Task 45
#Rank the transactions based on sales amount with highest at the top, and find the top 10 transactions. 
select *, dense_rank() over(order by Sale_Amount desc) from public.sales
limit 10;


#Task 46
#Find the transaction details of the third highest transaction in terms of sale amount.
select * from 
(select * ,dense_rank() over(order by Sale_Amount desc) as r from public.sales) as a
where r=3;

#Task 47
#Find unique list of customer_id from sales table.
select distinct customer_ID from public.sales;


#Task 48
#Find percentage contribution of sale amount for each customer separately, i.e., for each customer, the denominator for the percentage
#will be the total sale amount he was involved in across the complete time period and the numerator will be the sale Amount of that
#transaction. Remove any transactions with negative sales. Consider only the month of
#January for data. Order the result by customer id in ascending order and then by order of transaction.

select *,Sale_Amount*100/sum(Sale_Amount) over() 'percentage contribution'  from public.sales
where Sale_Amount>0 and Sale_Date between '2020-01-01' and '2020-01-31'
order by Customer_id , Sale_Date;


#Task 49
#Find those customer names (first and last) which are present in customer tables but
#haven’t made any transactions in the month of January.
select distinct first_name , last_name from public.customers
where ID in 
(select Customer_ID from public.sales
where Sale_Amount>0 and Sale_Date between '2020-02-01' and '2020-12-31');

#TASK 50
#For each customer, find the sale amount of the 2nd highest transaction.
select Customer_Id,Sale_Amount from 
(select Customer_ID,Sale_Amount,dense_rank() over(partition by Customer_ID order by Sale_Amount desc)r 
from public.sales) as a
where r=2;

#Task 51
#Find those customers (customer_id) who made a transaction in January but didn’t
#make a transaction in February.

select distinct Customer_ID
from public.sales
where (Sale_Date between '2020-01-01' and '2020-01-31')
and 
(Sale_date not between '2020-02-01' and '2020-02-28');


#Task 52
#Divide the sales table into 10 groups ordering by the sale amount with first group having the transactions with the highest sale amounts and
#last group having the transactions with the lowest sales amount
select * , ntile(10) over(order by Sale_Amount desc) n from public.sales;

#Task 53
#For each group in previous task, find the maximum, minimum, total and average sale amount.
select max(Sale_Amount),min(Sale_Amount),sum(Sale_Amount),avg(Sale_Amount), ntile(10) over(order by Sale_Amount desc) n from public.sales;


#Task 54
#Find the list of vendors (id and first name) who are in Department B (based on the character value in the ID) as per vendors table.
select ID,first_name from public.vendors
where ID like '%B%';


#Task 55
#Create another attribute for each vendor which gives information about its department.
select *,substring(id,-1,1) as "department"  from public.vendors;


#Task 56
#For the transactions for each customer, find the vendor id of the previous
#transaction by the same customer along with all the other attributes of that transaction.
select * , lag(Vendor_ID,1) over(partition by Customer_ID order by sale_id) from public.sales;


#Task 57
#As per the result of the previous query, find those customers who made 
#consecutive transactions from same vendor.
select Customer_ID from (
select Customer_ID,Vendor_ID, lag(Vendor_ID,1) 
over(partition by Customer_ID order by sale_id) p from public.sales) as a
where Vendor_ID=p;


#Task 58
#Find the month with the highest sales.
select Sale_Amount,month(Sale_Date) from public.sales
order by Sale_Amount desc
limit 1;

#Task 59
#Create a new ID for each customer as per customers table. The new ID is
#supposed to be the first 3 letters of their first name, the last letter of their last
#name and the first two digits of their original ID.
select concat(substring(first_name,1,3),substring(last_name,-1,1),substring(ID,1,2)) 
from public.customers;

#Task 60
#Find out customers who made purchase of an even amount, i.e., amount ending with an even digit. If
#the sale amount has decimal value, consider the last digit of the decimal for the question.
select count((Customer_ID)) from public.sales
where (Sale_Amount*100)%2=0;




































































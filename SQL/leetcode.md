# Leetcode db problems solved with postgresql and pandas

## 1757. Recyclable and Low Fat Products
sql:
``` sql
select p.product_id
from products p
where p.low_fats = 'Y' and p.recyclable = 'Y'
```
pandas:
``` python
import pandas as pd

def find_products(products: pd.DataFrame) -> pd.DataFrame:
    df = products[(products['low_fats'] == 'Y') & (products['recyclable'] == 'Y')]

    df = df[['product_id']]
    
    return df
```
---
## 584. Find Customer Referee
slq:
``` sql
SELECT name FROM customer WHERE referee_id <> 2 OR referee_id IS NULL
```
pandas:
``` python
import pandas as pd

def find_customer_referee(customer: pd.DataFrame) -> pd.DataFrame:
    result = customer[(customer['referee_id'] != 2) | (customer['referee_id'].isnull())][['name']]
    return result

```
---
## 595. Big Countries
slq:
``` sql
select w.name, w.population, w.area
from world w
where w.area >= 3000000 or w.population >= 25000000
```
pandas:
``` python
import pandas as pd

def big_countries(world: pd.DataFrame) -> pd.DataFrame:
    df = world[(world['area'] >= 3000000) | (world['population'] >= 25000000)]
    df = df[['name', 'population', 'area']]
    return df
```
---
## 1148. Article Views I
slq:
``` sql
select distinct v.author_id as id 
from views v
where v.author_id = v.viewer_id
order by id
```
pandas:
``` python
import pandas as pd

def article_views(views: pd.DataFrame) -> pd.DataFrame:
    def article_views(views: pd.DataFrame) -> pd.DataFrame:
    authors_viewed_own_articles = views[views['author_id'] == views['viewer_id']]
    
    unique_authors = authors_viewed_own_articles['author_id'].unique()
    
    unique_authors = sorted(unique_authors)
    
    result_df = pd.DataFrame({'id': unique_authors})
    
    return result_df
```
---
## 1683. Invalid Tweets
slq:
``` sql
select tweet_id
from tweets
where char_length(content) > 15
```
pandas:
``` python
import pandas as pd

def invalid_tweets(tweets: pd.DataFrame) -> pd.DataFrame:
    df = tweets[(tweets['content'].str.len() > 15)]
    df = df[['tweet_id']]
    return df

```
---
## [1378. Replace Employee ID With The Unique Identifier](https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/)
slq:
``` sql
select eu.unique_id, e.name

from employees e left join employeeuni eu on e.id = eu.id
```
pandas:
``` python
import pandas as pd

  

def replace_employee_id(employees: pd.DataFrame, employee_uni: pd.DataFrame) -> pd.DataFrame:

    merged = employees.merge(employee_uni, on='id', how='left')

    result = merged[['unique_id', 'name']]

    return result
```
---
## [1068. Product Sales Analysis I](https://leetcode.com/problems/product-sales-analysis-i/)
slq:
``` sql
select p.product_name, s.year, s.price

from sales s join product p on s.product_id = p.product_id
```
pandas:
``` python
import pandas as pd

  

def sales_analysis(sales: pd.DataFrame, product: pd.DataFrame) -> pd.DataFrame:

    merged = sales.merge(product, on='product_id')

    result = merged[['product_name', 'year', 'price']]

    return result
```
---
## [1581. Customer Who Visited but Did Not Make Any Transactions](https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/)
slq:
``` sql
select distinct v.customer_id, count(v.visit_id) as count_no_trans

from visits v left join transactions t on v.visit_id = t.visit_id

where t.transaction_id is null

group by customer_id
```
pandas:
``` python
import pandas as pd

  

def find_customers(visits: pd.DataFrame, transactions: pd.DataFrame) -> pd.DataFrame:

    merge = visits.merge(transactions, how='left')

    df = merge[merge['transaction_id'].isna()].groupby(['customer_id'], as_index=False).agg(count_no_trans=('visit_id', 'nunique'))

    return df
```
---
## 197. Rising Temperature
slq:
``` sql
select w1.id as Id
from weather w1, weather w2
where w1.recorddate - 1 = w2.recorddate and w1.temperature > w2.temperature
```
pandas:
``` python
import pandas as pd

def rising_temperature(weather: pd.DataFrame) -> pd.DataFrame:
    weather['recorddate'] = pd.to_datetime(weather['recorddate'])
    weather_shifted = weather.copy()
    weather_shifted['recorddate'] = weather_shifted['recorddate'] + pd.to_timedelta(1, unit='D')
    merge = pd.merge(weather, weather_shifted, on='recorddate', suffixes=('_today', '_yesterday'))
    result = merge[merge['temperature_today'] > merge['temperature_yesterday']][['id_today']].rename(columns={'id_today': 'Id'})
    return result
```
---
## 1661. Average Time of Process per Machine
postgreslq:  
We join same table so that start of activity and end of activity will be inline of each other.  
That way it is possible to subtract start from end.
``` sql
SELECT a.machine_id, ROUND((avg(b.timestamp - a.timestamp)::numeric), 3) as processing_time
-- round in postgresql will work only if we cast result of avg func to numeric
FROM Activity a, 
     Activity b
WHERE 
    a.machine_id = b.machine_id
AND 
    a.process_id = b.process_id
AND 
    a.activity_type = 'start'
AND 
    b.activity_type = 'end'
group by a.machine_id
```
pandas:
``` python
import pandas as pd
​
def get_average_time(activity: pd.DataFrame) -> pd.DataFrame:

    activity['timestamp'] = activity.apply(lambda x: x.timestamp * -1 if x.activity_type == 'start' else x.timestamp, axis=1)

    sum_machine_process = activity.groupby(['machine_id', 'process_id'], as_index=False)['timestamp'].sum()

    mean_machine = sum_machine_process.groupby(['machine_id'], as_index=False)['timestamp'].mean().round(3).rename(columns = {'timestamp': 'processing_time'})
    
    return mean_machine
```
---
## 577. Employee Bonus
slq:
``` sql
select e.name, b.bonus
from employee e left join bonus b on e.empId = b.empId
where b.bonus < 1000 or b.bonus is null
```
pandas:
``` python
import pandas as pd

def employee_bonus(employee: pd.DataFrame, bonus: pd.DataFrame) -> pd.DataFrame:
    df = employee.merge(bonus, how='left')
    df = df[(df['bonus'] < 1000) | df['bonus'].isnull()]
    df = df[['name', 'bonus']]
    return df
```
## 1280. Students and Examinations
postgreslq:
``` sql
select s.student_id, s.student_name, su.subject_name, count(e.subject_name) as attended_exams
from students s cross join subjects su 
left join examinations e on s.student_id = e.student_id and su.subject_name = e.subject_name
group by s.student_id, s.student_name, su.subject_name
order by student_id, subject_name
```
pandas:
``` python
def students_and_examinations(students: pd.DataFrame, subjects: pd.DataFrame, examinations: pd.DataFrame) -> pd.DataFrame:
    return pd.merge(
        left=pd.merge(
            students, subjects, how='cross',
        ).sort_values(
            by=['student_id', 'subject_name']
        ),
        right=examinations.groupby(
            ['student_id', 'subject_name'],
        ).agg(
            attended_exams=('subject_name', 'count')
        ).reset_index(),
        how='left',
        on=['student_id', 'subject_name'],
    ).fillna(0)[
        ['student_id', 'student_name', 'subject_name', 'attended_exams']
    ]
```
## 620. Not Boring Movies
postgreslq:
``` sql
select id, movie, description, rating
from cinema c
where description != 'boring' and mod(id,2) <> 0
order by rating desc
```
## 570. Managers with at Least 5 Direct Reports
postgreslq:
``` sql
select name from Employee 
where id in (
    select managerID 
    from employee 
    group by managerId 
    having count(*)>=5)
```
pandas:
``` python
import pandas as pd

def find_managers(employee: pd.DataFrame) -> pd.DataFrame:
    managers = employee.groupby(
        'managerId', as_index=False).agg(reporting=('id', 'count'),
    ).query('5 <= reporting')['managerId']

    return employee[employee['id'].isin(managers)][['name']]
```
## 1934. Confirmation Rate
postgreslq:
``` sql
SELECT s.user_id, round(avg(CASE WHEN action = 'confirmed' then 1 ELSE 0 END), 2) as confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c
ON s.user_id = c.user_id
GROUP BY s.user_id
```
## 1251. Average Selling Price
postgreslq:
``` sql
select p.product_id, coalesce(round(sum(p.price * u.units * 1.00) / sum(u.units * 1.00), 2), 0) as average_price
from prices p left join unitssold u on p.product_id = u.product_id
and u.purchase_date between p.start_date and  p.end_date
group by 1
```
## 
postgreslq:
``` sql

```
pandas:
``` python

```
## 
postgreslq:
``` sql

```
pandas:
``` python

```
## 
postgreslq:
``` sql

```
pandas:
``` python

```
## 
postgreslq:
``` sql

```
pandas:
``` python

```
## 
postgreslq:
``` sql

```
pandas:
``` python

```
## 
postgreslq:
``` sql

```
pandas:
``` python

```
## 
postgreslq:
``` sql

```
pandas:
``` python

```
## 
postgreslq:
``` sql

```
pandas:
``` python

```
## 
postgreslq:
``` sql

```
pandas:
``` python

```
## 
postgreslq:
``` sql

```
pandas:
``` python

```
## 
postgreslq:
``` sql

```
pandas:
``` python

```
## 
postgreslq:
``` sql

```
pandas:
``` python

```
## 
postgreslq:
``` sql

```
pandas:
``` python

```

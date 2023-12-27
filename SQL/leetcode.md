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
## 
slq:
``` sql

```
pandas:
``` python

```
---
## 
slq:
``` sql

```
pandas:
``` python

```
---
## 
slq:
``` sql

```
pandas:
``` python

```
---
## 
slq:
``` sql

```
pandas:
``` python

```
---
## 
slq:
``` sql

```
pandas:
``` python

```


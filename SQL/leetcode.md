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
## 322
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


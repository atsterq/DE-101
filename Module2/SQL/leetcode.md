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

# SQL задачи с https://learndb.ru/courses
Решения задач без описания и теории.  

## Вводные данные

Диаграмма базы данных:  
![schemaDiagram](https://github.com/atsterq/DE-101/blob/main/Module2/SQL/schemaDiagram.svg)  
[Подробное описание БД.](https://github.com/atsterq/DE-101/blob/main/Module2/SQL/schema_description.md)  

## Введение

Описание интерфейса (1/9)
``` sql
SELECT 'Hello, world!'
```
---
Синтаксис SQL запроса (2/9)
``` sql
SELECT 'One', 'Two', 'Three'
```
---
Выбор всех полей из таблицы (3/9)

``` sql
SELECT *
  FROM city
```
---
Выбор списка полей (4/9)

``` sql
SELECT first_name, middle_name, last_name
  FROM employee
```
---
Псевдонимы столбцов (5/9)

``` sql
select 1 as one, 2 as TWO, 3 as "Three"

```
---
Вызов функции (6/9)

``` sql
SELECT now() as server_date,
       name,
       upper(name) as name_upper
  FROM city
```
---
Конкатенация строк (7/9)

``` sql
SELECT first_name || ' ' || last_name as full_name
  FROM employee

```
---
Арифметические операции (8/9)

``` sql
SELECT product_id,
       price,
       price/2 AS price_sale
  FROM product_price
```
---
Исключение дубликатов (9/9)

``` sql
SELECT DISTINCT product_id
  FROM purchase_item
```
## Отсечение строк и сортировка

Hello, where (1/14)

``` sql
SELECT *
  FROM category
 WHERE parent_category_id = 2
```
---
Логические операторы (2/14)

``` sql
SELECT *
  FROM store_address
 WHERE city_id = 6
   AND address = 'ул. Чкалова, 42'
```
---
Обработка NULL значений (3/14)

``` sql
SELECT *
  FROM store_address
 WHERE opening_hours IS NOT NULL
   AND phone IS NOT NULL
```
---
Логические операторы: OR (4/14)

``` sql
SELECT *
  FROM employee
 WHERE first_name = 'Виктор'
    OR middle_name = 'Иванович'
```
---
Логические операторы: NOT (5/14)

``` sql
SELECT *
  FROM employee
 WHERE NOT (first_name = 'Виктор'
       OR middle_name = 'Иванович')
```
---
Порядок условий (6/14)

``` sql
SELECT *
  FROM employee
 WHERE (rank_id = 'CEO' 
    OR rank_id = 'CHIEF'
    OR rank_id = 'GENERAL_MANAGER')
   AND first_name = 'Виктор'
```
---
Операции сравнения (7/14)

``` sql
SELECT *
  FROM store_address
 WHERE store_id = 100
   AND city_id != 1

```
---
BETWEEN (8/14)

``` sql
SELECT *
  FROM product_price
 WHERE price BETWEEN 5000 AND 15000
    OR price BETWEEN 30000 AND 40000
```
---
IN (9/14)

``` sql
SELECT *
  FROM employee
 WHERE rank_id NOT IN ('SELLER', 'MANAGER')
```
---
Поиск по шаблону (10/14)

``` sql
SELECT first_name, last_name
  FROM employee
 WHERE last_name LIKE 'М%в'

```
---
Сортировка по одному полю (11/14)

``` sql
SELECT *
  FROM city
 ORDER BY name
```
---
Сортировка по нескольким полям (12/14)

``` sql
SELECT employee_id,
       store_id,
       rank_id,
       last_name
  FROM employee
 ORDER BY store_id, rank_id, last_name DESC
```
---
Ограничение количества строк (13/14)

``` sql
SELECT *
  FROM product_price
 ORDER BY price DESC
 LIMIT 5
```
---
Пропуск первых строк результата (14/14)

``` sql
SELECT *
  FROM product_price
 ORDER BY price DESC
 LIMIT 5
OFFSET 2

```

## Соединения

Соединение двух таблиц (1/10)

``` sql
SELECT *
  FROM product
  JOIN category
    ON category.category_id = product.category_id
```
---
Псевдонимы таблиц (2/10)

``` sql
SELECT p.purchase_id,
       p.purchase_date,
       p.store_id,
       pi.product_id,
       pi.count * pi.price as total_price
  FROM purchase p
  JOIN purchase_item pi
    ON pi.purchase_id = p.purchase_id
 ORDER BY p.store_id, p.purchase_date DESC
```
---
Добавляем WHERE (3/10)

``` sql
SELECT p.purchase_id,
       p.purchase_date,
       pi.product_id,
       pi.count,
       pi.price
  FROM purchase p
  JOIN purchase_item pi
    ON pi.purchase_id = p.purchase_id
 WHERE pi.count >= 5
 ORDER BY pi.count DESC, p.purchase_date DESC
```
---
Несколько условий соединения (4/10)

``` sql
SELECT e.last_name,
       e.first_name,
       e.store_id as store_id_employee,
       r.store_id as store_id_rank,
       r.rank_id,
       r.name as rank_name
  FROM employee e
  JOIN rank r
    ON r.store_id = e.store_id
    OR (r.rank_id = e.rank_id AND r.store_id != e.store_id)
 ORDER BY e.last_name, e.first_name, r.store_id, r.rank_id
```
---
Использование таблицы несколько раз (5/10)

``` sql
SELECT r.store_id,
       r.rank_id,
       ro.rank_id AS rank_id_other
  FROM rank r
  JOIN rank ro
    ON ro.store_id = r.store_id
   AND ro.rank_id != r.rank_id
 ORDER BY r.store_id, r.rank_id, ro.rank_id
```
---
Типы соединения (6/10)

``` sql
SELECT c.name AS category_name,
       p.name AS product_name
  FROM category c
  LEFT JOIN
       product p
    ON p.category_id = c.category_id
 ORDER BY c.name, p.name

```
---
RIGHT JOIN (7/10)

``` sql
SELECT t.time_offset, c.name AS city_name
  FROM city c
 RIGHT JOIN 
       timezone t
    ON t.timezone_id = c.timezone_id
 ORDER BY t.time_offset, c.name
```
---
FULL JOIN (8/10)

``` sql
SELECT DISTINCT 
       pp.product_id AS product_id_price,
       pi.product_id AS product_id_purchase
  FROM product_price pp
  FULL JOIN
       purchase_item pi
    ON pp.product_id = pi.product_id
 WHERE pp.product_id IS NULL
    OR pi.product_id IS NULL
```
---
Декартово произведение (9/10)

``` sql
SELECT c.name AS city_name,
       c.timezone_id AS timezone_id_city,
       t.timezone_id AS timezone_id_timezone,
       t.time_offset
  FROM city c,
       timezone t
 ORDER BY c.name, t.timezone_id
```
---
Синтаксис через WHERE (10/10)

``` sql
SELECT c.name AS category_name,
       p.name as product_name,
       p.description
  FROM category c,
       product p
 WHERE p.category_id = c.category_id
   AND c.category_id = 6
 ORDER BY p.name
```
## Агрегатные функции

Агрегатные функции (1/13)

``` sql
SELECT min(price) AS price_min,
       avg(price) AS price_avg,
       max(price) AS price_max
  FROM product_price
```
---
NULL значения в агрегатных функциях (2/13)

``` sql
SELECT count (*) AS count_total,
       count (employee_id) AS count_employee
  FROM purchase

```
---
Количество уникальных значений (3/13)

``` sql
SELECT count(*) AS count_total,
       count(employee_id) AS count_employee,
       count(DISTINCT employee_id) AS count_distinct_employee
  FROM purchase

```
---
Отсутствие строк (4/13)

``` sql
SELECT min(price) AS min_price,
       max(price) AS max_price,
       count(*) AS count_rows
  FROM product_price
 WHERE price < 0
```
---
GROUP BY (5/13)

``` sql
SELECT product_id,
       min(price) AS price_min,
       max(price) AS price_max
  FROM product_price
 GROUP BY product_id
 ORDER BY product_id
```
---
GROUP BY с соединением таблиц (6/13)

``` sql
SELECT p.name,
       min(pp.price) AS price_min,
       max(pp.price) AS price_max
  FROM product p
  JOIN product_price pp
    ON pp.product_id = p.product_id
 GROUP BY p.product_id, p.name
 ORDER BY p.name
```
---
GROUP BY и WHERE (7/13)

``` sql
SELECT p.category_id,
       p.name,
       min(pp.price) AS price_min,
       max(pp.price) AS price_max
  FROM product p
  JOIN product_price pp
    ON pp.product_id = p.product_id
 WHERE p.category_id IN (6, 7)
 GROUP BY p.product_id, 
          p.category_id,
          p.name
 ORDER BY p.category_id, p.name
```
---
GROUP BY по нескольким выражениям (8/13)

``` sql
SELECT pp.store_id,
       p.category_id,
       min(pp.price) AS price_min,
       max(pp.price) AS price_max
  FROM product p
  JOIN product_price pp
    ON pp.product_id = p.product_id
 GROUP BY pp.store_id, 
          p.category_id
 ORDER BY pp.store_id, p.category_id
```
---
NULL значения в GROUP BY (9/13)

``` sql
SELECT s.name AS store_name,
       m.first_name || ' ' || m.last_name AS manager_full_name,
       count(*) AS amount_employees
  FROM employee e
  LEFT JOIN
       employee m
    ON m.employee_id = e.manager_id
  LEFT JOIN
       store s
    ON s.store_id = e.store_id
 GROUP BY e.store_id,
          s.name,
          e.manager_id,
          m.first_name,
          m.last_name
 ORDER BY s.name, manager_full_name
```
---
HAVING (10/13)

``` sql
SELECT product_id,
       min(price) AS price_min,
       max(price) AS price_max
  FROM product_price
 GROUP BY product_id
 HAVING min(price) != max(price)
 ORDER BY product_id

```
---
ROLLUP (11/13)

``` sql
SELECT e.store_id, 
       e.rank_id, 
       count (*) AS count_employees
  FROM employee e
 GROUP BY ROLLUP (e.store_id, e.rank_id)
 ORDER BY e.store_id NULLS LAST,
          e.rank_id NULLS LAST
```
---
CUBE (12/13)

``` sql
SELECT e.store_id, 
       e.rank_id, 
       count (*) AS count_employees
  FROM employee e
 GROUP BY CUBE (e.store_id, e.rank_id)
 ORDER BY e.store_id NULLS LAST,
          e.rank_id NULLS LAST
```
---
GROUPING SETS (13/13)

``` sql
SELECT e.store_id, 
       e.rank_id, 
       count (*) AS count_employees
  FROM employee e
 GROUP BY GROUPING SETS ((e.store_id, e.rank_id), ())
 ORDER BY e.store_id NULLS LAST,
          e.rank_id NULLS LAST
```
## Операции над множествами

Объединение результатов (1/8)

``` sql
SELECT c.name
  FROM category c
 WHERE c.name ilike '%но%'
 UNION 
SELECT p.name
  FROM product p
 WHERE p.name ilike '%но%'

```
---
Из какого запроса строка? (2/8)

``` sql
SELECT c.name,
       'Категория' as type
  FROM category c
 WHERE c.name ilike '%но%'
 UNION 
SELECT p.name,
       'Товар' as type
  FROM product p
 WHERE p.name ilike '%но%'
```
---
Пересечение строк (3/8)

``` sql
SELECT pi.product_id,
       p.store_id,
       pi.price
  FROM purchase_item pi
  JOIN purchase p
    ON p.purchase_id = pi.purchase_id

INTERSECT

SELECT pp.product_id,
       pp.store_id,
       pp.price
  FROM product_price pp
```
---
Исключение строк (4/8)

``` sql
SELECT pi.product_id,
       p.store_id,
       pi.price
  FROM purchase_item pi
  JOIN purchase p
    ON p.purchase_id = pi.purchase_id

EXCEPT

SELECT pp.product_id,
       pp.store_id,
       pp.price
  FROM product_price pp

```
---
Дубликаты строк (5/8)

``` sql
SELECT c.name,
       'Категория' as type
  FROM category c
 WHERE c.name ilike '%но%'
 UNION ALL
SELECT p.name,
       'Товар' as type
  FROM product p
 WHERE p.name ilike '%но%'
```
---
Совпадение типов данных столбцов (6/8)

``` sql
SELECT pp.product_id,
       pp.price, 
       'отсутствует' as count
  FROM product_price pp
 UNION ALL
SELECT pi.product_id,
       pi.price,
       pi.count::text
  FROM purchase_item pi
```
---
Сортировка (7/8)

``` sql
SELECT c.name,
       'Категория' as type
  FROM category c
 WHERE c.name ilike '%но%'
 UNION 
SELECT p.name,
       'Товар' as type
  FROM product p
 WHERE p.name ilike '%но%'
 ORDER BY name, type
```
---
Несколько операций (8/8)

``` sql
(
  SELECT product_id
    FROM product_price
  EXCEPT
  SELECT product_id
    FROM purchase_item
)
UNION ALL
(
  SELECT product_id
    FROM purchase_item
  EXCEPT
  SELECT product_id
    FROM product_price
)
ORDER BY product_id
```
## Подзапросы

Подзапрос одиночной строки (1/9)

``` sql
SELECT p.name AS product_name,
       pi.count,
       pi.price
  FROM purchase_item pi
  JOIN product p
    ON p.product_id = pi.product_id
 WHERE pi.price = (SELECT max(pim.price)
                     FROM purchase_item pim)
```
---
Коррелированный подзапрос (2/9)

``` sql
SELECT c.name AS category_name,
       p.name as product_name,
       pp.price
  FROM product_price pp
  JOIN product p
    ON p.product_id = pp.product_id
  JOIN category c
    ON c.category_id = p.category_id
 WHERE pp.price = (SELECT max (ppm.price)
                     FROM product pm
                     JOIN product_price ppm
                       ON ppm.product_id = pm.product_id
                    WHERE pm.category_id = p.category_id)
 ORDER BY c.name, p.name
```
---
Подзапрос вернул более одной строки (3/9)

``` sql
SELECT c.name,
       (SELECT p.name
          FROM product p
         WHERE p.category_id = c.category_id
         ORDER BY p.name
         LIMIT 1
       ) AS product_example
  FROM category c
 ORDER BY c.name

```
---
Подзапрос не вернул строк (4/9)

``` sql
SELECT c.category_id,
       c.name       
  FROM category c
 WHERE (SELECT 1
          FROM product p
         WHERE p.category_id = c.category_id
         LIMIT 1) IS NULL
 ORDER BY c.name

```
---
Попадание в список значений (5/9)

``` sql
SELECT e.employee_id,
       e.last_name,
       e.first_name,
       e.rank_id
  FROM employee e
 WHERE e.employee_id IN (SELECT m.manager_id
                           FROM employee m)
 ORDER BY e.last_name, e.employee_id

```
---
Отсутствие в списке значений (6/9)

``` sql
SELECT p.product_id,
       p.name
  FROM product p
 WHERE p.product_id NOT IN (SELECT pi.product_id
                              FROM purchase_item pi)
 ORDER BY p.name

```
---
NULL значения в NOT IN (7/9)

``` sql
SELECT e.employee_id,
       e.last_name,
       e.first_name,
       e.rank_id
  FROM employee e
 WHERE e.employee_id NOT IN (SELECT m.manager_id
                               FROM employee m
                              WHERE m.manager_id IS NOT NULL)
 ORDER BY e.last_name, e.employee_id
```
---
Проверка существования строки (8/9)

``` sql
SELECT e.employee_id,
       e.last_name,
       e.first_name,
       e.rank_id
  FROM employee e
 WHERE EXISTS (SELECT 1
                 FROM employee m
                WHERE m.manager_id = e.employee_id)
 ORDER BY e.last_name, e.employee_id
```
---
Проверка отсутствия строки (9/9)

``` sql
SELECT e.employee_id,
       e.last_name,
       e.first_name,
       e.rank_id
  FROM employee e
 WHERE NOT EXISTS (SELECT 1
                     FROM employee m
                    WHERE m.manager_id = e.employee_id)
 ORDER BY e.last_name, e.employee_id
```
## Строковые функции

CONCAT - конкатенация строк (1/9)

``` sql
SELECT concat(
         e.last_name, ' ', 
         e.first_name, ' ', 
         e.middle_name, ';'
       ) AS full_name
  FROM employee e
 ORDER BY full_name

```
---
Преобразование регистра букв (2/9)

``` sql
SELECT lower(e.last_name || ' ' || e.first_name) AS lower,
       upper(e.last_name || ' ' || e.first_name) AS upper,
       initcap(e.last_name || ' ' || e.first_name) AS initcap
  FROM employee e
 ORDER BY e.last_name, e.first_name
```
---
LENGTH - определение длины строки (3/9)

``` sql
SELECT e.last_name,
       length(e.last_name) AS length
  FROM employee e
 ORDER BY length desc, last_name
```
---
Извлечение подстроки (4/9)

``` sql
SELECT e.employee_id,
       e.last_name || ' ' || left(e.first_name, 1) || '.' as full_name
  FROM employee e
 ORDER BY e.last_name,
          e.first_name
```
---
POSITION - поиск подстроки (5/9)

``` sql
SELECT e.last_name,
       left(e.last_name, position('а' in lower(e.last_name))) AS substring
  FROM employee e
 ORDER BY e.last_name

```
---
Дополнение до определенной длины (6/9)

``` sql
SELECT last_name || ' ' || rpad(left(first_name, 1), length(first_name), '*') AS mask
  FROM employee
 ORDER BY mask

```
---
TRIM - удаление символов с начала и конца строки (7/9)

``` sql
SELECT rtrim (
         concat(
           e.last_name, ' ', 
           e.first_name, ' ', 
           e.middle_name
         )
       ) AS full_name
  FROM employee e
 ORDER BY full_name
```
---
REPLACE - замена подстроки (8/9)

``` sql
SELECT replace(replace(address, 'ул.', 'улица'), 'пр.', 'проспект') AS address_full
  FROM store_address
 ORDER BY address_full
```
---
TRANSLATE - замена набора символов (9/9)

``` sql
SELECT DISTINCT
       first_name,
       translate (
         first_name,
         'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЫЭЮЯабвгдеёжзийклмнопрстуфхцчшщыэюяЬЪьъ',
         'ABVGDEEJZIJKLMNOPRSTUFHCHSSYEYAabvgdeejzijklmnoprstufhchssyeya'
       ) AS first_name_translated
  FROM employee
 ORDER BY first_name

```
## Математические функции
Простейшие арифметические операции (+ - * /) (1/13)


``` sql
SELECT pi.purchase_id,
       pi.product_id,
       pi.price,
       pi.count,
       pi.price * pi.count AS total_price
  FROM purchase_item pi
 ORDER BY pi.purchase_id,
          pi.product_id

```
---
Порядок выполнения операций (2/13)

``` sql
SELECT pp.product_id,
       pp.store_id,
       pp.price,
       (pp.price - (
         SELECT min (ppa.price)
           FROM product_price ppa
          WHERE ppa.product_id = pp.product_id
       )) * 0.5 AS discount
  FROM product_price pp
 ORDER BY pp.product_id, pp.price, pp.store_id
```
---
Деление целых чисел (3/13)

``` sql
SELECT purchase_item_id,
       count,
       count / 2 AS whole,
       count / 2.0 AS fractional
  FROM purchase_item
 ORDER BY count desc
```
---
Простейшие арифметические операции (% ^ !) (4/13)

``` sql
SELECT purchase_item_id,
       count,
       count % 2 AS is_odd
  FROM purchase_item
 ORDER BY count desc
```
---
Получение числа из строки (5/13)

``` sql
SELECT t.timezone_id
  FROM timezone t
 WHERE right(t.time_offset, -4)::integer = 4
```
---
ROUND - округление числа (6/13)

``` sql
SELECT pp.store_id,
       avg(pp.price) as average_price,
       round(avg(pp.price), 2) AS average_price_rounded
  FROM product_price pp
 GROUP BY pp.store_id
 ORDER BY average_price
```
---
TRUNC - усечение числа (7/13)

``` sql
SELECT pp.store_id,
       avg(pp.price) as average_price,
       round(avg(pp.price), 2) AS average_price_round,
       trunc(avg(pp.price), 2) AS average_price_trunc
  FROM product_price pp
 GROUP BY pp.store_id
 ORDER BY average_price
```
---
CEIL - следующее целое число (8/13)

``` sql
SELECT pp.product_id,
       avg (pp.price) as price_avg,
       round(avg (pp.price)) as price_avg_round,
       ceil(avg(pp.price)) as price_avg_ceil
  FROM product_price pp
 GROUP BY pp.product_id
 ORDER BY price_avg DESC
```
---
FLOOR - предыдущее целое число (9/13)

``` sql
SELECT pp.product_id,
       avg (pp.price) as price_avg,
       round(avg (pp.price)) as price_avg_round,
       ceil(avg(pp.price)) as price_avg_ceil,
       floor(avg(pp.price)) as price_avg_floor,
       trunc(avg(pp.price)) as price_avg_trunc
  FROM product_price pp
 GROUP BY pp.product_id
 ORDER BY price_avg DESC
```
---
GREATEST - определение большего числа (10/13)

``` sql
SELECT pp.product_id,
       pp.store_id,
       pp.price,
       round(greatest(pp.price * 0.05, 1000)) AS prepayment
  FROM product_price pp
 ORDER BY pp.price,
          pp.product_id,
          pp.store_id
```
---
LEAST - определение меньшего числа (11/13)

``` sql
SELECT pp.product_id,
       pp.store_id,
       pp.price,
       round(least(pp.price * 0.05, 1000)) AS prepayment_least,
       round(greatest(pp.price * 0.05, 1000)) AS prepayment_greatest
  FROM product_price pp
 ORDER BY pp.price,
          pp.product_id,
          pp.store_id
```
---
ABS - модуль числа (12/13)

``` sql
SELECT pp.product_id,
       pp.store_id,
       pp.price,
       (SELECT round (avg (ppa.price), 2)
          FROM product_price ppa
         WHERE ppa.product_id = pp.product_id
       ) as price_avg,
       abs (
         round (
           pp.price - (SELECT avg (ppa.price)
                         FROM product_price ppa
                        WHERE ppa.product_id = pp.product_id)
           , 2)
       ) AS price_difference
  FROM product_price pp
 ORDER BY pp.product_id, 
          pp.price, 
          pp.store_id
```
---
TO_CHAR - форматирование числа (13/13)

``` sql
SELECT pp.product_id,
       pp.store_id,
       pp.price,
       to_char (pp.price, 'FM999G999G999G990D00') as price_formatted
  FROM product_price pp
 ORDER BY pp.price desc
```
## Основы работы с датами
 Текущая дата на сервере (1/12)

``` sql
SELECT CURRENT_DATE AS date,
       LOCALTIME AS time,
       CURRENT_TIME AS time_with_timezone,
       LOCALTIMESTAMP AS datetime,
       CURRENT_TIMESTAMP AS datetime_with_timezone

```
---
Точность (2/12)

``` sql
SELECT CURRENT_DATE AS date,
       LOCALTIME(0) AS time,
       CURRENT_TIME(0) AS time_with_timezone,
       LOCALTIMESTAMP(0) AS datetime,
       CURRENT_TIMESTAMP(0) AS datetime_with_timezone
```
---
Форматирование даты и времени (3/12)

``` sql
SELECT p.purchase_id,
       p.store_id,
       p.purchase_date,
       to_char(p.purchase_date, 'DD.MM.YYYY в HH24:MI') AS date_formatted
  FROM purchase p
 ORDER BY p.purchase_date
```
---
Ввод даты и времени (4/12)

``` sql
SELECT p.purchase_id,
       p.store_id,
       p.purchase_date
  FROM purchase p
 WHERE p.purchase_date < timestamp '2022-10-06 18:00'
 ORDER BY p.purchase_date
```
---
Ввод даты: to_date (5/12)

``` sql
SELECT to_date('19.02.1861', 'DD.MM.YYYY') AS freedom_day
```
---
Ввод даты со временем: to_timestamp (6/12)

``` sql
SELECT to_timestamp('1 January 2023', 'DD Month YYYY') AS ts_from_string,
       to_timestamp(1534896000) AS ts_from_unix_epoch
```
---
Ввод времени (7/12)

``` sql
SELECT time '04:05:06.789' AS "04:05:06.789",
       time '04:05:06' AS "04:05:06",
       time '04:05' AS "04:05",
       time '040506' AS "040506",
       time '04:05 AM' AS "04:05 AM",
       time '04:05 PM' AS "04:05 PM"
```
---
Ввод времени с часовым поясом (8/12)

``` sql
SELECT y AS year, 
       (y || '-01-01 12:00:00 Europe/Moscow')::time with time zone AS time_01,
       (y || '-06-01 12:00:00 Europe/Moscow')::time with time zone AS time_06
  FROM generate_series(2008, 2022) y
 ORDER BY y
```
---
Разность дат (9/12)

``` sql
SELECT p.purchase_date,
       current_timestamp,
       current_timestamp - p.purchase_date AS diff_current_timestamp,
       localtimestamp,
       localtimestamp - p.purchase_date AS diff_localtimestamp,
       current_date,
       current_date - p.purchase_date AS diff_current_date
  FROM purchase p
 ORDER BY p.purchase_date
```
---
Временные интервалы (10/12)

``` sql
SELECT *
  FROM purchase p
 WHERE p.purchase_date <= (SELECT min (purchase_date) + interval '1 month'
                             FROM purchase)
 ORDER BY p.purchase_date
```
---
Динамическое построение интервала (11/12)

``` sql
SELECT p.purchase_id,
       pr.name AS product_name,
       p.purchase_date::date AS purchase_date,
       pr.warranty_in_months,
       (p.purchase_date + make_interval(months => pr.warranty_in_months))::date AS warranty_end
  FROM purchase p
  JOIN purchase_item pi
    ON pi.purchase_id = p.purchase_id
  JOIN product pr
    ON pr.product_id = pi.product_id
 ORDER BY p.purchase_id,
          warranty_end
```
---
Начало и конец месяца (12/12)

``` sql
SELECT date_trunc('month', p.purchase_date)::date AS period_start,
       (date_trunc('month', p.purchase_date) + interval '1 month - 1 day')::date AS period_end,
       count(*) AS count_purchases
  FROM purchase p
 GROUP BY date_trunc('month', p.purchase_date)
 ORDER BY period_start
```
# Рекурсивные подзапросы
 Подзапрос во фразе FROM (1/12)
Эталонное решение:
``` sql
SELECT e.employee_id,
       e.last_name,
       e.first_name,
       p.purchase_id,
       pp.price_purchase,
       round (100 * price_purchase / ep.price_total) AS price_total_percent,
       ep.price_total,
       ep.count_total
  FROM purchase p,
       (SELECT p.employee_id,
               sum (pi.price * pi.count) AS price_total,
               count (distinct p.purchase_id) AS count_total
          FROM purchase p,
               purchase_item pi
         WHERE pi.purchase_id = p.purchase_id
         GROUP BY p.employee_id
       ) ep,
       (SELECT p.purchase_id,
               sum (pi.price * pi.count) as price_purchase
          FROM purchase p,
               purchase_item pi
         WHERE pi.purchase_id = p.purchase_id
         GROUP BY p.purchase_id
       ) pp,
       employee e
 WHERE e.employee_id = p.employee_id
   AND ep.employee_id = p.employee_id
   AND pp.purchase_id = p.purchase_id
 ORDER BY ep.count_total DESC,
          e.employee_id,
          pp.price_purchase,
          p.purchase_id

```
Моё решение:
``` sql
SELECT 
    p.employee_id, 
    pt.last_name, 
    pt.first_name, 
    p.purchase_id, 
    pt.price_purchase, 
    ROUND(100 * pt.price_purchase / SUM(pt.price_purchase) OVER (PARTITION BY p.employee_id), 0) AS price_total_percent, 
    SUM(pt.price_purchase) OVER (PARTITION BY p.employee_id) AS price_total, 
    COUNT(p.purchase_id) OVER (PARTITION BY p.employee_id) AS count_total
FROM (
    SELECT 
        p.employee_id, 
        e.last_name, 
        e.first_name, 
        p.purchase_id, 
        SUM(pi.price * pi.count) AS price_purchase
    FROM purchase p
    JOIN purchase_item pi ON p.purchase_id = pi.purchase_id
    JOIN employee e ON p.employee_id = e.employee_id
    GROUP BY p.purchase_id, e.last_name, e.first_name, p.employee_id
) pt
JOIN purchase p ON pt.purchase_id = p.purchase_id
order by count_total desc, employee_id, price_purchase desc, purchase_id
```
---
Введение в WITH (2/12)

``` sql
WITH employee_result AS (
  SELECT p.employee_id,
         sum (pi.price * pi.count) AS sum_purchases
    FROM purchase p,
         purchase_item pi
   WHERE pi.purchase_id = p.purchase_id
     AND p.employee_id IS NOT NULL
   GROUP BY p.employee_id
)
SELECT er.employee_id,
       e.last_name,
       e.first_name,
       er.sum_purchases
  FROM employee_result er,
       employee e
 WHERE e.employee_id = er.employee_id
   AND er.sum_purchases < (SELECT avg (ern.sum_purchases)
                             FROM employee_result ern)
 ORDER BY er.sum_purchases,
          er.employee_id
```
---
Несколько подзапросов в WITH (3/12)

``` sql
WITH employee_result AS (
  SELECT p.employee_id,
         sum (pi.price * pi.count) AS sum_purchases
    FROM purchase p,
         purchase_item pi
   WHERE pi.purchase_id = p.purchase_id
     AND p.employee_id IS NOT NULL
   GROUP BY p.employee_id
),
employee_action AS (
  (SELECT er.employee_id,
          er.sum_purchases,
          'Уволить' AS action
     FROM employee_result er
    ORDER BY er.sum_purchases
    LIMIT 2)

   UNION ALL

  (SELECT er.employee_id,
          er.sum_purchases,
          'Повысить' AS action
     FROM employee_result er
    ORDER BY er.sum_purchases desc
    LIMIT 2)
)
SELECT ea.employee_id,
       e.last_name,
       e.first_name,
       ea.sum_purchases,
       ea.action
  FROM employee_action ea,
       employee e
 WHERE e.employee_id = ea.employee_id
 ORDER BY ea.sum_purchases,
          ea.employee_id
```
---
Простейший рекурсивный запрос (4/12)

``` sql
WITH RECURSIVE lv_recursive (num) as (
  SELECT -10 AS num
    
    UNION ALL
  
  SELECT p.num + 1
    FROM lv_recursive p
   WHERE p.num < 10
)
SELECT num
  FROM lv_recursive
 ORDER BY num
```
---
Рекурсивный запрос посложнее (5/12)

``` sql
WITH RECURSIVE lv_initial AS (
    SELECT 101 AS start_number,
           10 AS count_iterations
     UNION ALL
    SELECT 201 AS start_number,
           15 AS count_iterations
     UNION ALL
    SELECT 301 AS start_number,
           20 AS count_iterations
), 
lv_numbers (count_iterations, current_iteration, result_number) AS (
    SELECT count_iterations,
           1 AS current_iteration,
           start_number AS result_number
      FROM lv_initial
     UNION ALL
    SELECT p.count_iterations,
           p.current_iteration + 1,
           p.result_number + 1
      FROM lv_numbers p
     WHERE p.current_iteration < p.count_iterations
)
SELECT n.result_number
  FROM lv_numbers n
 ORDER BY n.result_number
```
---
Строим иерархию объектов (6/12)

``` sql
WITH RECURSIVE lv_hierarchy AS (
  SELECT e.employee_id,
         e.first_name,
         e.last_name,
         0 AS count_managers
    FROM employee e
  WHERE e.manager_id IS NULL

   UNION ALL
  
  SELECT e.employee_id,
         e.first_name,
         e.last_name,
         p.count_managers + 1 AS count_managers
    FROM lv_hierarchy p,
         employee e
   where e.manager_id = p.employee_id
)
SELECT *
  FROM lv_hierarchy
```
---
Путь до элемента (7/12)

``` sql
WITH RECURSIVE lv_hierarchy AS (
  SELECT e.employee_id,
         e.first_name,
         e.last_name,
         0 AS count_managers,
         '' AS managers
    FROM employee e
  WHERE e.manager_id IS NULL

   UNION ALL
  
  SELECT e.employee_id,
         e.first_name,
         e.last_name,
         p.count_managers + 1 AS count_managers,
         p.managers || '; ' || p.first_name || ' ' || p.last_name
    FROM lv_hierarchy p,
         employee e
   where e.manager_id = p.employee_id
)
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       e.count_managers,
       trim('; ' from e.managers) AS managers
  FROM lv_hierarchy e
```
---
Сортировка (плохая) (8/12)

``` sql
WITH RECURSIVE lv_hierarchy AS (
  SELECT e.employee_id,
         e.first_name,
         e.last_name,
         0 AS count_managers,
         '' AS managers
    FROM employee e
  WHERE e.manager_id IS NULL

   UNION ALL
  
  SELECT e.employee_id,
         e.first_name,
         e.last_name,
         p.count_managers + 1 AS count_managers,
         p.managers || '; ' || p.first_name || ' ' || p.last_name
    FROM lv_hierarchy p,
         employee e
   where e.manager_id = p.employee_id
)
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       e.count_managers,
       trim('; ' from e.managers) AS managers
  FROM lv_hierarchy e
 ORDER BY e.managers || '; ' || e.first_name || ' ' || e.last_name
```
---
Сортировка (надежная) (9/12)

``` sql
WITH RECURSIVE lv_hierarchy AS (
  SELECT le.employee_id,
         le.first_name,
         le.last_name,
         0 AS count_managers,
         '' AS managers,
         array[row_number () over (order by le.first_name || ' ' || le.last_name, le.employee_id)] AS path_sort
    FROM lv_employee le
  WHERE le.manager_id IS NULL
   UNION ALL
  SELECT le.employee_id,
         le.first_name,
         le.last_name,
         p.count_managers + 1 AS count_managers,
         p.managers || '; ' || p.first_name || ' ' || p.last_name,
         p.path_sort || row_number () over (partition by le.manager_id order by le.first_name || ' ' || le.last_name, le.employee_id) AS path_sort
    FROM lv_hierarchy p,
         lv_employee le
   where le.manager_id = p.employee_id),
lv_employee AS (
  SELECT e.employee_id, 
         e.first_name, 
         e.last_name, 
         e.manager_id
    FROM employee e
   UNION ALL
  SELECT e.employee_id * 1000, 
         e.first_name, 
         e.last_name, 
         e.manager_id * 1000
    FROM employee e)
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       e.count_managers,
       trim('; ' from e.managers) AS managers
  FROM lv_hierarchy e
 ORDER BY e.path_sort
```
---
Форматирование иерархии (10/12)

``` sql
WITH RECURSIVE lv_hierarchy AS (
  SELECT e.employee_id,
         e.first_name,
         e.last_name,
         0 AS count_managers,
         array[row_number() over (ORDER BY e.first_name, e.last_name, e.employee_id)] AS sort
    FROM employee e
  WHERE e.manager_id IS NULL

   UNION ALL
  
  SELECT e.employee_id,
         e.first_name,
         e.last_name,
         p.count_managers + 1 AS count_managers,
         p.sort || row_number() over (PARTITION BY e.manager_id ORDER BY e.first_name, e.last_name, e.employee_id) AS sort
    FROM lv_hierarchy p,
         employee e
   where e.manager_id = p.employee_id
)
SELECT e.employee_id,
       lpad('', 8 * e.count_managers, ' ') || e.first_name || ' ' || e.last_name AS full_name
  FROM lv_hierarchy e
 ORDER BY e.sort
```
---
Нумерация вложенных списков (11/12)

``` sql
WITH RECURSIVE lv_hierarchy AS (
 SELECT c.category_id,
        c.parent_category_id,
        c.name,
        1 AS level,
        '/' || c.name AS path,
        array[row_number () over (order by c.name)] AS path_sort
   FROM category c
  WHERE c.parent_category_id IS NULL

  UNION ALL

 SELECT c.category_id,
        c.parent_category_id,
        c.name,
        p.level + 1 AS level,
        p.path || '/' || c.name AS path,
        p.path_sort || row_number () over (partition by c.parent_category_id order by c.name) AS path_sort
   FROM lv_hierarchy p,
        category c
  WHERE c.parent_category_id = p.category_id
)
SELECT lpad('', (c.level - 1) * 4, '.') || array_to_string(c.path_sort, '.') || '. ' || c.name AS full_name,
       c.type
  FROM (SELECT c.name,
               c.level,   
               c.path_sort,
               'категория' AS type
          from lv_hierarchy c
         UNION ALL
        SELECT p.name,
               c.level + 1,
               c.path_sort || row_number () over (partition by p.category_id order by p.name, p.product_id),
               'товар' AS type
          FROM lv_hierarchy c,
               product p
         WHERE p.category_id = c.category_id 
       ) c
 ORDER BY c.path_sort
```
---
Листовые строки CONNECT_BY_ISLEAF (12/12)

``` sql
WITH RECURSIVE lv_hierarchy AS (
  SELECT e.employee_id,
         e.first_name,
         e.last_name,
         0 AS count_managers,
         array[row_number() over (ORDER BY e.first_name, e.last_name, e.employee_id)] AS sort
    FROM employee e
  WHERE e.manager_id IS NULL

   UNION ALL
  
  SELECT e.employee_id,
         e.first_name,
         e.last_name,
         p.count_managers + 1 AS count_managers,
         p.sort || row_number() over (PARTITION BY e.manager_id ORDER BY e.first_name, e.last_name, e.employee_id) AS sort
    FROM lv_hierarchy p,
         employee e
   where e.manager_id = p.employee_id
)
SELECT e.employee_id,
       lpad('', 8 * e.count_managers, ' ') || e.first_name || ' ' || e.last_name AS full_name,
       exists (
          SELECT 1
            FROM employee ch
           WHERE ch.manager_id = e.employee_id
       ) AS is_manager
  FROM lv_hierarchy e
 ORDER BY e.sort
```
---
Получение номера строки (1/5)

``` sql
SELECT row_number() OVER (ORDER BY e.last_name, e.first_name) AS row_num,
-- Оконные агрегатные функции(func_name() over) не изменяют количество строк в результате запроса.
       e.last_name,
       e.first_name
  FROM employee e
 ORDER BY row_num

```
---
Номер строки в рамках группы (2/5)

``` sql
SELECT row_number() 
          OVER (PARTITION BY s.store_id, e.rank_id
                ORDER BY e.first_name, e.last_name)
          AS position, 
       s.name AS store_name,
       e.rank_id,
       e.first_name,
       e.last_name
  FROM employee e,
       store s
 WHERE s.store_id = e.store_id
 ORDER BY s.name, e.rank_id, position
```
---
Составляем рейтинг - RANK (3/5)

``` sql
SELECT e.store_id,
       s.name,
       count(*) AS count_employees,
       rank() OVER (ORDER BY count (*) DESC) AS position
  FROM employee e,
       store s
 WHERE s.store_id = e.store_id
 GROUP BY e.store_id,
          s.name
 ORDER BY position, s.name

```
---
Несколько человек на место - DENSE_RANK (4/5)

``` sql
SELECT *
  FROM (SELECT e.store_id,
               s.name,
               count(*) AS count_employees,
               dense_rank() OVER (ORDER BY count (*)) AS position
          FROM employee e,
               store s
         WHERE s.store_id = e.store_id
         GROUP BY e.store_id,
                  s.name
       ) s
 WHERE s.position <= 3
 ORDER BY s.position, s.name

```
---
Разделение на группы - NTILE (5/5)

``` sql
SELECT round (100.0 * sum (p.sum_product) / max (p.sum_total), 2) AS percent
  FROM (SELECT pi.product_id,
               sum (pi.count) AS sum_product,
               sum(sum (pi.count)) over () AS sum_total,
               ntile(5) over (ORDER BY sum(pi.count) desc) AS group_number
          FROM purchase_item pi
         GROUP BY pi.product_id
       ) p
 WHERE p.group_number = 1
```
---
### Общая информация (1/7)

``` sql
SELECT pp.store_id, pp.product_id, p.category_id, pp.price,
-- Главная прелесть оконных функций, что на одни и те же данные можно смотреть в разных разрезах в рамках одного запроса.
       max(pp.price) over (PARTITION BY pp.product_id) as max_price_product,
       max(pp.price) over (PARTITION BY pp.store_id) as max_price_in_store,
       max(pp.price) over (PARTITION BY p.category_id) as max_price_in_category,
       max(pp.price) over (PARTITION BY p.category_id, pp.store_id) as max_price_in_category_and_store,  
       max(pp.price) over () as max_price_total
  FROM product_price pp, product p
  where pp.product_id = p.product_id
 ORDER BY p.category_id, pp.price, pp.product_id, pp.store_id
```
---
### Многообразие агрегатных функций (2/7)
В большинстве задач можно обойтись небольшим набором агрегатных ф-й, либо оконной агр. ф-ии, добавив OVER (...):
- avg(выражение) - арифметическое среднее;
- min(выражение) - минимальное значение выражения;
- max(выражение) - маскимальное значение выражения;
- sum(выражение) - сумма значений выражения;
- count(*) - количество строк в результате запроса;
- count(выражение) - количество значений выражения, не равных NULL.

``` sql
SELECT pi.purchase_id,
       pi.product_id,
       pi.total_price,
       min(pi.total_price) over (PARTITION BY pi.purchase_id) AS total_price_min,
       max(pi.total_price) over (PARTITION BY pi.purchase_id) AS total_price_max,
       avg(pi.total_price) over (PARTITION BY pi.purchase_id) AS total_price_avg,
       count(*) over (PARTITION BY pi.purchase_id) AS count_products,
       sum(pi.total_price) over (PARTITION BY pi.purchase_id) AS purchase_price
  FROM (SELECT pi.purchase_id,
               pi.product_id,
               pi.price * pi.count AS total_price
          FROM purchase_item pi
       ) pi
ORDER BY pi.purchase_id,
         pi.product_id
```
---
### Обработка NULL значений (3/7)

Мое:
``` sql
select distinct p.purchase_id, 
-- без distinct в ответе будет на каждую позицию заказа отдельная строка
e.last_name || ' ' || e.first_name as employee,
sum(pi.price * pi.count) over (partition by p.purchase_id) as price_purchase,
sum(pi.price * pi.count) over (partition by e.employee_id) as total_by_employee 
from purchase p
left join employee e on p.employee_id = e.employee_id
-- left join для добавление nulls в ответе
join purchase_item pi on p.purchase_id = pi.purchase_id
order by employee nulls last, p.purchase_id
```
Эталонное:
``` sql
SELECT p.purchase_id,
       e.last_name || ' ' || e.first_name AS employee,
       p.price_purchase,
       sum(p.price_purchase) over (PARTITION BY p.employee_id) AS total_by_employee
  FROM (SELECT p.purchase_id,
               p.employee_id,
               sum (pi.count * pi.price) AS price_purchase
          FROM purchase p,
               purchase_item pi
         WHERE pi.purchase_id = p.purchase_id
         GROUP BY p.purchase_id,
                  p.employee_id
       ) p
  LEFT JOIN
       employee e
    ON e.employee_id = p.employee_id
 ORDER BY employee NULLS LAST,
          p.purchase_id

```
---
### Нарастающий итог SUM + ORDER BY (4/7)
Добавив order by в оконную ф-ю можно получить нарастающий итог.  
Чтобы вычислить агрегатную функцию по окну с указанием ORDER BY внутри over, делай так:
1. Разбивай все строки результата на группы в соответствии с PARTITION BY, указанным в over. В нашем случае PARTITION BY опущен, поэтому группа у нас одна - все строки.
2. Сортируй строки в группах в порядке, указанном в ORDER BY внутри over.
3. Вычисляй функцию последовательно для строк, начиная с первой. Для каждой очередной строки для вычисления значения бери строки от начала и до текущей.  

Мое:
``` sql
select distinct p.purchase_id, p.purchase_date,
sum(pi.price * pi.count) over (partition by p.purchase_id) as price_purchase,
sum(pi.price * pi.count) over (order by p.purchase_date) as price_total
from purchase p, purchase_item pi
where p.purchase_id = pi.purchase_id
order by p.purchase_date
```
Эталонное:
``` sql
SELECT p.purchase_id,
       p.purchase_date,
       p.price_purchase,
       sum (p.price_purchase) over (ORDER BY p.purchase_date) AS price_total
  FROM (SELECT p.purchase_id,
               p.purchase_date,
               sum (pi.count * pi.price) AS price_purchase
          FROM purchase p,
               purchase_item pi
         WHERE pi.purchase_id = p.purchase_id
         GROUP BY p.purchase_id,
                  p.purchase_date
       ) p
 ORDER BY p.purchase_date

```
---
### Неуникальные значения в нарастающем итоге SUM + ORDER BY (5/7)
Мое:
``` sql
select distinct p.store_id, p.purchase_date,
sum(pi.price * pi.count) over (partition by p.purchase_id) as price_purchase,
sum(pi.price * pi.count) over (partition by p.store_id order by p.store_id, p.purchase_date) as price_total
from purchase p, purchase_item pi
where p.purchase_id = pi.purchase_id
order by p.store_id, p.purchase_date
```
Эталонное:
``` sql
SELECT p.store_id,
       p.purchase_date,
       p.price_purchase,
       sum (p.price_purchase) over (PARTITION BY p.store_id ORDER BY p.purchase_date) AS price_total
  FROM (SELECT p.store_id,
               p.purchase_date,
               sum (pi.count * pi.price) AS price_purchase
          FROM purchase p,
               purchase_item pi
         WHERE pi.purchase_id = p.purchase_id
         GROUP BY p.store_id,
                  p.purchase_id,
                  p.purchase_date
       ) p
 ORDER BY p.store_id, 
          p.purchase_date

```
---
### Собираем строки через разделитель - STRING_AGG (6/7)

``` sql
select distinct e.store_id,
string_agg(e.last_name || ' ' || e.first_name, '; ' order by e.last_name) as list_employees
from employee e
group by e.store_id
order by e.store_id
```
---
### WITHIN GROUP (7/7)

``` sql
SELECT p.product_id,
       p.name,
       p.description
  FROM product p
  --  чтобы в ответ попала лишь одна нужная запись пропиши условие что её id равен определенному продукту (самому популярному)
 WHERE p.product_id = (SELECT mode() WITHIN GROUP (ORDER BY pi.product_id)
                         FROM purchase_item pi)
```
---
### COALESCE - первый не NULL аргумент (1/5)

``` sql
SELECT e.employee_id,
       e.last_name,
       e.first_name,
       coalesce(e.middle_name, '-') as middle_name
  FROM employee e
 ORDER BY e.employee_id

```
---
### 
``` sql

```
---
### 
``` sql

```
---
### 
``` sql

```
---
### 
``` sql

```
---
### 
``` sql

```
---
### 
``` sql

```
---
### 
``` sql

```
---
### 
``` sql

```
---
### 
``` sql

```
---
### 
``` sql

```
---
### 
``` sql

```
---
### 
``` sql

```
---
### 
``` sql

```

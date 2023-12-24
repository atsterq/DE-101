-- create dw schema, logic model tables, populate with data from stg tables


CREATE SCHEMA IF NOT EXISTS dw;


-- CUSTOMER table
DROP TABLE IF EXISTS  dw.customer_dim CASCADE;

CREATE TABLE dw.customer_dim
(
 customer_id   varchar(8) NOT NULL,
 customer_name varchar(50) NOT NULL,
 segment       varchar(30) NOT NULL,
 CONSTRAINT PK_customer PRIMARY KEY ( customer_id )
);

insert into dw.customer_dim
select distinct o.customer_id, o.customer_name, o.segment
from stg.orders o;


-- GEOGRAPHY table
DROP TABLE IF EXISTS  dw.geography_dim CASCADE;

CREATE TABLE dw.geography_dim
(
 geography_id int GENERATED ALWAYS AS IDENTITY,
 country     varchar(40) NOT NULL,
 region      varchar(15) NOT NULL,
 manager     varchar(40) NOT NULL,
 "state"       varchar(22) NOT NULL,
 city        varchar(25) NOT NULL,
 postal_code varchar(10) NOT NULL,
 CONSTRAINT PK_geography PRIMARY KEY ( geography_id )
);

-- fix postal_code in source table
UPDATE stg.orders
SET postal_code = '12345'
WHERE country = 'United States' AND
	city = 'Burlington' AND state = 'Vermont';

truncate table dw.geography_dim cascade;

insert into dw.geography_dim (country, region, manager, state, city, postal_code)
select o.country, o.region, p.person as manager, o.state, o.city, o.postal_code
from stg.orders o
join stg.people p on o.region = p.region;


-- PRODUCT table
DROP TABLE IF EXISTS  dw.product_dim CASCADE;

CREATE TABLE dw.product_dim
(
 product_id   varchar(15) NOT NULL,
 category     varchar(15) NOT NULL,
 subcategory  varchar(11) NOT NULL,
 product_name varchar(127) NOT NULL,
 CONSTRAINT PK_product PRIMARY KEY ( product_id )
);

-- fix product_id in source table
UPDATE stg.orders
SET product_id = 'TEC-AC-10002047'
WHERE product_name = 'Logitech G19 Programmable Gaming Keyboard';

UPDATE stg.orders
SET product_id = 'TEC-AC-10002551'
WHERE product_name = 'Memorex 25GB 6X Branded Blu-Ray Recordable Disc, 30/Pack';

UPDATE stg.orders
SET product_id = 'TEC-AC-10008832'
WHERE product_name = 'Logitech P710e Mobile Speakerphone';

UPDATE stg.orders
SET product_id = 'TEC-MA-10005148'
WHERE product_name = 'Okidata MB491 Multifunction Printer';

UPDATE stg.orders
SET product_id = 'TEC-PH-10001539'
WHERE product_name = 'Plantronics Voyager Pro Legend';

UPDATE stg.orders
SET product_id = 'TEC-PH-10001792'
WHERE product_name = 'ClearOne CHATAttach 160 - speaker phone';

UPDATE stg.orders
SET product_id = 'TEC-PH-10002222'
WHERE product_name = 'Aastra 6757i CT Wireless VoIP phone';

UPDATE stg.orders
SET product_id = 'TEC-PH-10002318'
WHERE product_name = 'Panasonic KX T7731-B Digital phone';

UPDATE stg.orders
SET product_id = 'TEC-PH-10004551'
WHERE product_name = 'AT&T CL2909';

UPDATE stg.orders
SET product_id = 'OFF-AP-10005576'
WHERE product_name = 'Belkin 7 Outlet SurgeMaster II';

UPDATE stg.orders
SET product_id = 'OFF-AR-10001249'
WHERE product_name = 'Avery Hi-Liter Comfort Grip Fluorescent Highlighter, Yellow Ink';

UPDATE stg.orders
SET product_id = 'OFF-BI-10002226'
WHERE product_name = 'Avery Arch Ring Binders';

UPDATE stg.orders
SET product_id = 'OFF-BI-10004642'
WHERE product_name = 'Ibico Hi-Tech Manual Binding System';

UPDATE stg.orders
SET product_id = 'OFF-BI-10004655'
WHERE product_name = 'Avery Binding System Hidden Tab Executive Style Index Sets';

UPDATE stg.orders
SET product_id = 'OFF-PA-10003357'
WHERE product_name = 'Xerox 1888';

UPDATE stg.orders
SET product_id = 'OFF-PA-10002477'
WHERE product_name = 'Xerox 1952';

UPDATE stg.orders
SET product_id = 'OFF-PA-10001659'
WHERE product_name = 'TOPS Carbonless Receipt Book, Four 2-3/4 x 7-1/4 Money Receipts per Page';

UPDATE stg.orders
SET product_id = 'OFF-PA-10001266'
WHERE product_name = 'Xerox 2';

UPDATE stg.orders
SET product_id = 'OFF-PA-10001971'
WHERE product_name = 'Xerox 1908';

UPDATE stg.orders
SET product_id = 'OFF-PA-10002795'
WHERE product_name = 'Xerox 1966';

UPDATE stg.orders
SET product_id = 'OFF-PA-10002370'
WHERE product_name = 'Xerox 1916';

UPDATE stg.orders
SET product_id = 'OFF-PA-10003822'
WHERE product_name = 'Xerox 1992';

UPDATE stg.orders
SET product_id = 'OFF-ST-10001227'
WHERE product_name = 'Fellowes Personal Hanging Folder Files, Navy';

UPDATE stg.orders
SET product_id = 'OFF-ST-10004953'
WHERE product_name = 'Acco Perma 3000 Stacking Storage Drawers';

UPDATE stg.orders
SET product_id = 'FUR-BO-10002218'
WHERE product_name = 'DMI Eclipse Executive Suite Bookcases';

UPDATE stg.orders
SET product_id = 'FUR-CH-10001147'
WHERE product_name = 'Global Task Chair, Black';

UPDATE stg.orders
SET product_id = 'FUR-FU-10001476'
WHERE product_name = 'DAX Wood Document Frame';

UPDATE stg.orders
SET product_id = 'FUR-FU-10004317'
WHERE product_name = 'Executive Impressions 13" Chairman Wall Clock';

UPDATE stg.orders
SET product_id = 'FUR-FU-10004291'
WHERE product_name = 'Howard Miller 13" Diameter Goldtone Round Wall Clock';

UPDATE stg.orders
SET product_id = 'FUR-FU-10004280'
WHERE product_name = 'Executive Impressions 13" Clairmont Wall Clock';

UPDATE stg.orders
SET product_id = 'FUR-FU-10004858'
WHERE product_name = 'Howard Miller 13-3/4" Diameter Brushed Chrome Round Wall Clock';

UPDATE stg.orders
SET product_id = 'FUR-FU-10004866'
WHERE product_name = 'Howard Miller 14-1/2" Diameter Chrome Round Wall Clock';

UPDATE stg.orders
SET product_id = 'FUR-FU-10054866'
WHERE product_name = 'Logitech P710e Mobile Speakerphone';

UPDATE stg.orders
SET product_id = 'FUR-FU-10033866'
WHERE product_name = 'ClearOne CHATAttach 160 - speaker phone';

insert into dw.product_dim (product_id, category, subcategory, product_name)
select distinct o.product_id, o.category, o.subcategory, o.product_name
from stg.orders o;


-- RETURN table
DROP TABLE IF EXISTS  dw.return_dim CASCADE;

CREATE TABLE dw.return_dim
(
 return_id int GENERATED ALWAYS AS IDENTITY,
 returned  boolean NOT NULL,
 CONSTRAINT PK_return PRIMARY KEY ( return_id )
);


insert into dw.return_dim (returned)
values (true), (false);

-- SHIPPING table
DROP TABLE IF EXISTS  dw.shipping_dim CASCADE;

CREATE TABLE dw.shipping_dim
(
 ship_id   int GENERATED ALWAYS AS IDENTITY,
 ship_mode varchar(14) NOT NULL,
 CONSTRAINT PK_ship PRIMARY KEY ( ship_id )
);

insert into dw.shipping_dim (ship_mode)
select distinct ship_mode
from stg.orders;

-- SALE table
DROP TABLE IF EXISTS  dw.sale_fact CASCADE;

CREATE TABLE dw.sale_fact
(
 row_id      SERIAL  NOT NULL,
 order_id    varchar(17) NOT NULL,
 sales       integer NOT NULL,
 quantity    integer NOT NULL,
 discount    integer NOT NULL,
 profit      integer NOT NULL,
 ship_id     int NOT NULL,
 ship_date     date NOT NULL,
 order_date     date NOT NULL,
 product_id  varchar(15) NOT NULL,
 geography_id      integer NOT NULL,
 customer_id varchar(8) NOT NULL,
 return_id   int NOT null,
 CONSTRAINT PK_sale_fact PRIMARY KEY ( row_id )
);

CREATE INDEX FK_geography ON dw.sale_fact
(
 geography_id
);

CREATE INDEX FK_ship ON dw.sale_fact
(
 ship_id
);

CREATE INDEX FK_product ON dw.sale_fact
(
 product_id
);

CREATE INDEX FK_customer ON dw.sale_fact
(
 customer_id
);

-- todo: fix joins. current query makes many duplicates
insert into dw.sale_fact (row_id, order_id, sales, quantity, discount, profit, ship_id, ship_date, 
order_date, product_id, geography_id, customer_id, return_id)
select o.row_id, o.order_id, cast(o.sales as integer), o.quantity, cast(o.discount as integer), 
cast(o.profit as integer), s.ship_id, o.ship_date,
o.order_date, p.product_id, g.geography_id, c.customer_id,
case when r.returned = 'Yes' then 1 else 2 end as return_id
from stg.orders o
left join (select distinct order_id, returned from stg.returns) as r on o.order_id = r.order_id
join dw.shipping_dim as s on o.ship_mode = s.ship_mode
join dw.geography_dim as g on o.postal_code = g.postal_code::int
join dw.product_dim as p on o.product_id = p.product_id
join dw.customer_dim as c on o.customer_id = c.customer_id;

SELECT	COUNT(*) as all,
	COUNT(DISTINCT order_id)	as order_id,
	COUNT(DISTINCT order_date)	as order_date,
	COUNT(DISTINCT ship_date)	as ship_date,
	COUNT(DISTINCT customer_id)	as customer_id,
	COUNT(DISTINCT customer_name)	as customer_name,
	COUNT(DISTINCT segment)	as segment,
	COUNT(DISTINCT country)	as country,
	COUNT(DISTINCT city)	as city,
	COUNT(DISTINCT state)	as state,
	COUNT(DISTINCT postal_code)	as postal_code,
	COUNT(DISTINCT ship_mode)	as ship_mode,	
	COUNT(DISTINCT region)	as region,
	COUNT(DISTINCT product_id)	as product_id,
	COUNT(DISTINCT category)	as category,
	COUNT(DISTINCT subcategory)	as subcategory,
	COUNT(DISTINCT product_name)	as product_name,
	COUNT(DISTINCT sales)	as sales,
	COUNT(DISTINCT quantity)	as quantity,
	COUNT(DISTINCT discount)	as discount,
	COUNT(DISTINCT profit)	as profit
FROM stg.orders
;

SELECT	COUNT(*) as all,
	 COUNT(DISTINCT order_id)	as order_id,
	 COUNT(DISTINCT ship_date)	as ship_date,
	 COUNT(DISTINCT customer_id)	as customer_id,
	 COUNT(DISTINCT sales)	as sales,
	 COUNT(DISTINCT quantity)	as quantity,
	 COUNT(DISTINCT discount)	as discount,
	 COUNT(DISTINCT profit)	as profit
FROM dw.sale_fact 
;


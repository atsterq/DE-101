Таблицы базы данных
timezone
city
store
store_address
category
product
product_price
rank
employee
purchase
purchase_item
timezone - временные зоны

В таблице timezone хранится информация о временный зонах. time_offset задает часовой пояс, например UTC+6.

Столбец	Тип	Модификаторы	Описание
timezone_id	SERIAL	NOT NULL	Код временной зоны
time_offset	TEXT	NOT NULL	Время относительно UTC
CREATE TABLE timezone (
    timezone_id SERIAL NOT NULL,
    time_offset TEXT NOT NULL,
    CONSTRAINT timezone__pk PRIMARY KEY (timezone_id),
    CONSTRAINT timezone__offset__uk UNIQUE (time_offset)
);
city - города
В системе допустимо несколько городов с одинаковым названием. Для идентификации города используется суррогатный ключ city_id. Для каждого города хранится информация о часовом поясе (внешний ключ на таблицу timezone).

Столбец	Тип	Модификаторы	Описание
city_id	SERIAL	NOT NULL	Идентификатор города
name	TEXT	NOT NULL	Название
timezone_id	INTEGER	NOT NULL	Код временной зоны
CREATE TABLE city (
    city_id SERIAL NOT NULL,
    name TEXT NOT NULL,
    timezone_id INTEGER NOT NULL,
    CONSTRAINT city__pk PRIMARY KEY (city_id),
    CONSTRAINT city__to__timezone FOREIGN KEY (timezone_id) REFERENCES timezone (timezone_id)
);
store - магазины
В таблице store хранится информация о магазинах. Каждый магазин может иметь несколько адресов в одном или нескольких городах (см. таблицу store_address). Для магазина можно заполнить URL сайта.

Столбец	Тип	Модификаторы	Описание
store_id	SERIAL	NOT NULL	Идентификатор магазина
name	TEXT	NOT NULL	Название
site_url	TEXT		URL сайта магазина
CREATE TABLE store (
    store_id SERIAL NOT NULL,
    name TEXT NOT NULL,
    site_url TEXT,
    CONSTRAINT store__pk PRIMARY KEY (store_id),
    CONSTRAINT store__name__uk UNIQUE (name)
);
store_address - адреса магазинов
Каждый магазин может иметь несколько адресов в одном или нескольких городах. Для некоторых магазинов может не быть записи в store_address, например для интернет-магазинов. Таблица имеет справочный характер, все внешние ключи в остальных таблицах ссылаются на store.

Столбец	Тип	Модификаторы	Описание
store_address_id	SERIAL	NOT NULL	Идентификатор адреса магазина
store_id	INTEGER	NOT NULL	Идентификатор магазина
city_id	INTEGER	NOT NULL	Идентификатор города
address	TEXT	NOT NULL	Адрес магазина
opening_hours	TEXT		Часы работы
phone	TEXT		Телефон
CREATE TABLE store_address (
    store_address_id SERIAL NOT NULL,
    store_id INTEGER NOT NULL,
    city_id INTEGER NOT NULL,
    address TEXT NOT NULL,
    opening_hours TEXT,
    phone TEXT,
    CONSTRAINT store_address__pk PRIMARY KEY (store_address_id),
    CONSTRAINT store_address__address__UK UNIQUE (store_id, city_id, address),
    CONSTRAINT store_address__to__store FOREIGN KEY (store_id) REFERENCES store (store_id),
    CONSTRAINT store_address__to__city FOREIGN KEY (city_id) REFERENCES city (city_id)
);
CREATE INDEX store_address__city_id ON store_address (city_id);
category - категории товаров
Category - иерархический справочник категорий товаров. Справочник общий для всех магазинов. Каждая категория может иметь или не иметь подкатегории. Ссылка на родительскую категорию задается в столбце parent_category_id. Если parent_category_id принимает NULL значение, значит родительской категории не существует.

Столбец	Тип	Модификаторы	Описание
category_id	SERIAL	NOT NULL	Идентификатор категории товаров
parent_category_id	INTEGER		Идентификатор родительской категории товаров
name	TEXT	NOT NULL	Название
CREATE TABLE category (
    category_id SERIAL NOT NULL,
    parent_category_id INTEGER,
    name TEXT NOT NULL,
    CONSTRAINT category__pk PRIMARY KEY (category_id),
    CONSTRAINT category__parent__fk FOREIGN KEY (parent_category_id) REFERENCES category (category_id),
    CONSTRAINT category__name__uk UNIQUE (parent_category_id, name)
);
CREATE INDEX category__parent_category_id ON category (parent_category_id);
product - товары
Таблица product хранит информацию о товарах в категории товаров. Для каждого товара обязательно заполняется название и не обязательно описание. Справочник товаров общий для всех магазинов. При наличии товара в магазине в таблице product_price заполняется стоимость.

Столбец	Тип	Модификаторы	Описание
product_id	SERIAL	NOT NULL	Идентификатор товара
category_id	INTEGER	NOT NULL	Идентификатор категории товаров
name	TEXT	NOT NULL	Название
description	TEXT		Описание
warranty_in_months	INTEGER	NOT NULL	Гарантийний период, месяцев
CREATE TABLE product (
    product_id SERIAL NOT NULL,
    category_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    warranty_in_months INTEGER NOT NULL,
    CONSTRAINT product__pk PRIMARY KEY (product_id),
    CONSTRAINT product__to__category FOREIGN KEY (category_id) REFERENCES category (category_id),
    CONSTRAINT product__name__uk UNIQUE (category_id, name)
);
CREATE INDEX product__name ON product (name);
product_price - цены на товар в магазинах
При наличии продукта в магазине в таблице product_price заполняется стоимость. Если записи в product_price для заданного товара и магазина нет, то это значит, что либо магазин не предоставляет этот продукт, либо данный продукт закончился в магазине.

Столбец	Тип	Модификаторы	Описание
product_id	INTEGER	NOT NULL	Идентификатор продукта
store_id	INTEGER	NOT NULL	Идентификатор магазина
price	NUMERIC (15, 2)	NOT NULL	Цена
CREATE TABLE product_price (
    product_id INTEGER NOT NULL,
    store_id INTEGER NOT NULL,
    price NUMERIC (15, 2) NOT NULL,
    CONSTRAINT product_price__pk PRIMARY KEY (product_id, store_id),
    CONSTRAINT product_price__price__ck CHECK (price > 0)
);
CREATE INDEX product_price__store_id ON product_price (store_id);
rank - должности
В каждом магазине своя иерархия сотрудников. Для каждой должности хранится ее название. Все должности сотрудников хранятся в таблице rank. Запись в rank идентифицируется составным суррогатным ключем (store_id, rank_id). Справочник единый для всех адресов сети магазинов, поэтому ссылка на store_address не хранится. Для определения подчиненности сотрудников необходимо воспользоваться полем manager_id таблицы employee.

Столбец	Тип	Модификаторы	Описание
store_id	INTEGER	NOT NULL	Идентификатор магазина
rank_id	TEXT	NOT NULL	Идентификатор должности в магазине
name	TEXT	NOT NULL	Название должности
CREATE TABLE rank (
    store_id INTEGER NOT NULL,
    rank_id TEXT NOT NULL,
    name TEXT NOT NULL,
    CONSTRAINT rank__pk PRIMARY KEY (store_id, rank_id),
    CONSTRAINT rank__to__store FOREIGN KEY (store_id) REFERENCES store (store_id)
);
employee - сотрудники магазина
Таблица employee - справочник сотрудников магазина. Для каждого сотрудника хранится ФИО и должность. Так же у сотрудника может быть один руководитель. Ссылка на непосредственного руководителя хранится в поле manager_id.

Ссылка на магазин store_id добавлена в таблицу из соображений оптимизации, чтобы можно было получить всех сотрудников магазина минуя таблицу должностей rank.

Столбец	Тип	Модификаторы	Описание
employee_id	SERIAL	NOT NULL	Идентификатор сотрудника
store_id	INTEGER	NOT NULL	Идентификатор магазина
rank_id	TEXT	NOT NULL	Идентификатор должности в магазине
first_name	TEXT	NOT NULL	Имя
last_name	TEXT	NOT NULL	Фамилия
middle_name	TEXT		Отчество
manager_id	INTEGER		Идентификатор сотрудника-руководителя
CREATE TABLE employee (
    employee_id SERIAL NOT NULL,
    store_id INTEGER NOT NULL,
    rank_id TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    middle_name TEXT,
    manager_id INTEGER,
    CONSTRAINT employee__pk PRIMARY KEY (employee_id),
    CONSTRAINT employee__to__rank FOREIGN KEY (store_id, rank_id) REFERENCES rank (store_id, rank_id),
    CONSTRAINT employee__manager__fk FOREIGN KEY (manager_id) REFERENCES employee (employee_id)
);
CREATE INDEX employee__manager_id ON employee (manager_id);
purchase - заказ
При оформлении заказа в магазине добавляется запись в таблицу заказов. Таблица purchase хранит информацию о магазине, дате и времени заказа и об оформившем заказ сотруднике. Если покупатель оформил заказ без помощи сотрудников магазина, то employee_id будет равно NULL. Информация о продуктах заказа хранится в таблице purchase_item.

Столбец	Тип	Модификаторы	Описание
purchase_id	SERIAL	NOT NULL	Идентификатор заказа
purchase_date	TIMESTAMP WITH TIME ZONE	NOT NULL DEFAULT CURRENT_TIMESTAMP	Дата заказа
store_id	INTEGER	NOT NULL	Идентификатор магазина
employee_id	INTEGER		Идентификатор сотрудника магазина, оформившего заказ
CREATE TABLE purchase (
    purchase_id SERIAL NOT NULL,
    purchase_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    store_id INTEGER NOT NULL,
    employee_id INTEGER,
    CONSTRAINT purchase__pk PRIMARY KEY (purchase_id),
    CONSTRAINT purchase__to__employee FOREIGN KEY (employee_id) REFERENCES employee (employee_id),
    CONSTRAINT purchase__to__store FOREIGN KEY (store_id) REFERENCES store (store_id)
);
CREATE INDEX purchase__employee_id ON purchase (employee_id);
purchase_item - товары заказа
Информация о продуктах заказа хранится в таблице purchase_item. Для каждого продукта заказа указывается фактическая стоимость за штуку и количество приобретенного товара. Фактическая стоимость продукта в заказе может отличаться от стоимости продукта в магазине в таблице product_price, т.к. покупатель мог воспользоваться акцией, промокодом, или цена могла измениться со временем.

Столбец	Тип	Модификаторы	Описание
purchase_item_id	SERIAL	NOT NULL	Идентификатор товара заказа
purchase_id	INTEGER	NOT NULL	Идентификатор заказа
product_id	INTEGER	NOT NULL	Идентификатор товара
price	NUMERIC (15, 2)	NOT NULL	Цена за единицу товара
count	INTEGER	NOT NULL	Количество единиц товара
CREATE TABLE purchase_item (
    purchase_item_id SERIAL NOT NULL,
    purchase_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    price NUMERIC (15, 2) NOT NULL,
    count INTEGER NOT NULL,
    CONSTRAINT purchase_item__pk PRIMARY KEY (purchase_item_id),
    CONSTRAINT purchase_item__product__uk UNIQUE (purchase_id, product_id),
    CONSTRAINT purchase_item__to__purchase FOREIGN KEY (purchase_id) REFERENCES purchase (purchase_id),
    CONSTRAINT purchase_item__to__product FOREIGN KEY (product_id) REFERENCES product (product_id),
    CONSTRAINT purchase_item__price__ck CHECK (price > 0),
    CONSTRAINT purchase_item__count__ck CHECK (count > 0)
);
CREATE INDEX purchase_item__product_id ON purchase_item (product_id);
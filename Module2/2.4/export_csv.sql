COPY stg.orders TO 'C:\Dev\DE-101\Module2\2.4\orders.csv'  
WITH DELIMITER ';' CSV HEADER;

COPY stg.people TO 'C:\Dev\DE-101\Module2\2.4\people.csv'  
WITH DELIMITER ';' CSV HEADER;

COPY stg.returns TO 'C:\Dev\DE-101\Module2\2.4\returns.csv'  
WITH DELIMITER ';' CSV HEADER;

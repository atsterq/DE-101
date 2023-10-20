# Analytic solution architecrure
Simple example of data flow architecture created in [draw.io](https://app.diagrams.net/)  
![Analytic solution architecture](https://github.com/atsterq/DE-101/blob/main/Module1/Analytic%20solution%20architercture.drawio.svg)
# Excel analytic
[Excel table](https://github.com/atsterq/DE-101/blob/main/Module1/Sample%20-%20Superstore.xls)  of Superstore orders for analytical purposes.  
1. Summarize tables.
- Using [IF](https://support.microsoft.com/ru-ru/office/%d0%b5%d1%81%d0%bb%d0%b8-%d1%84%d1%83%d0%bd%d0%ba%d1%86%d0%b8%d1%8f-%d0%b5%d1%81%d0%bb%d0%b8-69aed7c9-4e8a-4755-a9bc-aa8bbff73be2?ui=ru-RU&rs=ru-RU&ad=RU) statement I added *people* table to main table *orders*.
- Function [XLOOKUP](https://support.microsoft.com/ru-ru/office/%D1%84%D1%83%D0%BD%D0%BA%D1%86%D0%B8%D1%8F-%D0%BF%D1%80%D0%BE%D1%81%D0%BC%D0%BE%D1%82%D1%80x-b7fd680e-6d10-43e6-84f9-88eae8bf5929) allow us to search objects in table or range by row. Thats how we implemented *returns* to *orders*.
2. Define the reports.  
It is very important to decide what we are going to output and in what form. The results of the subsequent analysis will directly depend on this. In order to understand which indicators are really important and what level of detail is needed for them, we need knowledge of the subject area.  

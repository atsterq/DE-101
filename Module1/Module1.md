# Analytic solution architecrure
Example of data flow architecture created in [draw.io](https://app.diagrams.net/).  

![Analytic solution architecture](https://github.com/atsterq/DE-101/blob/main/Module1/Analytic%20solution%20architercture.drawio.svg)  

- **Source Layer**: This layer is responsible for ingesting and collecting data from various sources, such as databases, files, streaming devices, and external APIs. The data can be structured, semi-structured, or unstructured, and it is the starting point of the data journey in the architecture.

- **Storage Layer**: The storage layer is where the ingested data resides and undergoes transformations to make it more accessible and valuable for analysis. This layer is generally divided into different zones for ease of management and workflow efficiency. The data can be stored in various formats, such as object storage, relational databases, or NoSQL databases, depending on the specific requirements of the data platform.

- **Business Layer**: The business layer is responsible for implementing the business logic and rules on top of the data. It involves data transformation, aggregation, and enrichment to create meaningful insights and value for the organization. This layer can also include the creation of views, tables, and materialized SQL code to support the analytics and reporting needs of the business.

# Excel analytic
[Excel table](https://github.com/atsterq/DE-101/blob/main/Module1/Sample%20-%20Superstore.xls)  of Superstore orders for analytical purposes.  
1. Summarize tables.
- Using [IF](https://support.microsoft.com/ru-ru/office/%d0%b5%d1%81%d0%bb%d0%b8-%d1%84%d1%83%d0%bd%d0%ba%d1%86%d0%b8%d1%8f-%d0%b5%d1%81%d0%bb%d0%b8-69aed7c9-4e8a-4755-a9bc-aa8bbff73be2?ui=ru-RU&rs=ru-RU&ad=RU) statement we added *people* table to main table *orders*.
- Function [XLOOKUP](https://support.microsoft.com/ru-ru/office/%D1%84%D1%83%D0%BD%D0%BA%D1%86%D0%B8%D1%8F-%D0%BF%D1%80%D0%BE%D1%81%D0%BC%D0%BE%D1%82%D1%80x-b7fd680e-6d10-43e6-84f9-88eae8bf5929) allow us to search objects in table or range by row. Thats how we implemented *returns* to *orders*.
2. Define the reports.  

It is very important to decide what we are going to output and in what form. The results of the subsequent analysis will directly depend on this. In order to understand which indicators are really important and what level of detail is needed for them, we need knowledge of the subject area.  

Reports for this project:  
| **Parameters and indicators** | **Visualization** |
| --- | --- |
| Revenue and Profit Dynamics | Chart Chart Chart |
| Product categories (comparison) | Line graph |
| Regional Managers(comparison) | Bar graph |
| Segments(comparison) | Histogram |
| Dynamics by Segment | Graph Chart |
| Key Indicators | Sparklines |
| By state | Cartogram |
| By region (comparison) | Pie chart | Pie chart |
| By Returns in % | Circular |  

3. Create pivot tables and charts.

[Dashboard](https://github.com/atsterq/DE-101/blob/main/Module1/Sample%20-%20Superstore.xlsx) for Superstore with all the key indicators created in excel on pivot tables and charts.  

![Superstore Dashboard](https://github.com/atsterq/DE-101/blob/main/Module1/Dashboard.png)

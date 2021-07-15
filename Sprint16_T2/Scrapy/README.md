# Web Scraping with Scrapy

In this project we extract the information of Top 100 eBooks of science-fiction from amazon using scrapy.  
In order to execute the code go to the file `~/Scrapy` and execute:

**$ scrapy crawl kindle -t csv**

The resulting file *kindle_items.csv* is filled with the atributes:

- **asin**: Amazon Standard Identification Number
- **titulo**: Title of the book
- **autor**: Author of the book

# Web Scraping Project with BeautifulSoup and Selenium

This notebook imports the packages:

  - requests
  - BeautifulSoup
  - selenium
  
 To extract data about the market price of IBEX 35 companies during the last 24 hours from the web https://www.bolsamadrid.es.
 /n Along with the notebook the driver to execute the Chrome webdriver for selenium is given. 
 
 The resulting table.csv is made from the following attributes:
 
 - Nombre: Name of the company
 - Últ.: Company share price last recorded
 - %Dif.: Difference between the last record and the value of the last close
 - Máx.: Máximum value during the daily trading
 - Mín.: Mínimum value during the daily trading
 - Volumen: Traded shares during the daily trading
 - Efectivo (miles €): Value of the share in thousands of euros 
 - Fecha: Date of the record
 - Hora: Hour of the record

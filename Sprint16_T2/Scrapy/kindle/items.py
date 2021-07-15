# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy


class KindleItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()

    # Atributos generales
    asin = scrapy.Field()  # ID
    titulo = scrapy.Field()
    autor = scrapy.Field()

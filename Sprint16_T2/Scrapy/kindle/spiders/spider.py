import scrapy
from scrapy.spiders import CrawlSpider, Rule
from scrapy.linkextractors import LinkExtractor
from scrapy.exceptions import CloseSpider
from kindle.items import KindleItem

class kindleSpider(CrawlSpider):
    name = "kindle"
    #item_count = 0
    allowed_domain = ["www.amazon.es"]
    start_urls = ["https://www.amazon.es/gp/bestsellers/digital-text/1349599031/ref=zg_bs_nav_kinc_4_1349601031"]

    rules = {

        Rule(LinkExtractor(allow=(), restrict_xpaths=('//span[@class="aok-inline-block zg-item"]')),
             callback="parse_item", follow=False),
        Rule(LinkExtractor( allow=(), restrict_xpaths = ('//li[@class="a-last"]/a')))
    }

    def parse_item(self, response):
        k_item = KindleItem()

        # info general
        k_item["asin"] = response.xpath('//*[@id="detailBullets_feature_div"]/ul/li[1]/span/span[2]/text()').extract()
        k_item["titulo"] = response.xpath('//*[@id="productTitle"]/text()').extract()
        k_item["autor"] = response.xpath('//*[@id="bylineInfo"]/span[1]/span[1]/a[1]/text()').extract()

        #self.item_count += 1
        #if self.item_count > 20:
        #    raise CloseSpider("item_exceeded")
        yield k_item

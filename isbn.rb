# -*- coding: utf-8 -*-
require "rakuten_web_service"

RakutenWebService.configuration do |c|
  c.application_id = ""
  c.affiliate_id = ""
end

## BookをISBNから検索(楽天)
books = RakutenWebService::Books::Book.search(isbn: "9784774161204")

## 検索されている値からtitleとかauthorとかpublisherとかをだす
books.each do |book|
  puts book["title"],book["author"],book["publisherName"],book["isbn"]
end

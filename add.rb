require "rakuten_web_service"
require "groonga"

Groonga::Database.open("db/ryo.db")

def add(hash, users_name, users_class, users_librarian, users_book_limit)
  if users_book_limit <= 2
    add = Groonga["Users"]
    add.add(hash, users_name: users_name, users_class: users_class, users_librarian: users_librarian, users_book_limit: users_book_limit)
  end
end

def book(isbn)
  RakutenWebService.configuration do |c|
    c.application_id = ""
    c.affiliate_id = ""
  end

  books = RakutenWebService::Books::Book.search(isbn: isbn)
  books.each do |book|
    books_title = book["title"]
    books_author = book["author"]
    books_publisher = book["publisherName"]
    books_isbn = book["isbn"]
  end
end
add("6","Kristen Nygaard","3-1",false,0)
add("5","Rasmus Lerdorf","3-2",false,0)
add("4","Stephen Russell","3-3",false,0)
add("1","Ryo Sugimoto","3-4",true,0)
add("2","Yukihiro Matsumoto","3-5",false,0)
add("3","Guido van Rossum","3-6",true,0)

book("9784774159904")
book("9784774156071")
book("9784774155074")
book("9784774157832")
book("9784774155937")
book("9784774162874")
book("9784774158747")
book("9784774157191")
book("9784774163867")
book("9784774161204")

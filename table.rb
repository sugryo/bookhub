# -*- coding: utf-8 -*-
require "groonga"

Groonga::Context.default_options = {encoding: :utf8}

begin
  Groonga::Database.create(path: "ryo.db")
rescue
  Groonga::Database.open("ryo.db")
end

## Keyは、利用者の番号とする
Groonga::Schema.create_table("Users", type: :hash) do |table|
  table.text("users_name")                 #利用者氏名
  table.text("users_class")                #利用者クラス
  table.boolean("users_librarian")         #図書委員かどうか
  table.integer16("users_book_limit")      #利用者の貸出冊数
end

## Keyは、本の番号とする
Groonga::Schema.create_table("Books", type: :hash) do |table|
  table.text("books_title")                #本のタイトル
  table.text("books_author")               #本の作者
  table.text("books_publisher")            #本の出版社
  table.text("books_isbn")                 #ISBNコード
end

## Keyは、利用者の番号とする
Groonga::Schema.create_table("LendBooks", type: :hash) do |table|
  table.reference("user_number", "Users")  #利用者の番号
  table.reference("book_number", "Books")  #本の番号
  table.text("book_lendday")               #本の貸し出し日
  table.text("book_returnday")             #本の返す日
end

## 検索のインデックス
Groonga::Schema.create_table("Indexes", type: :patricia_trie) do |table|
  table.index("Books.books_title")
  table.index("Books.books_author")
  table.index("Books.books_publisher")
  table.index("Books.books_isbn")
end

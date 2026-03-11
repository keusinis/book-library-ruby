# frozen_string_literal: true

class Librarian
  def print_books
    all_books_table = CSV.parse(File.read('./data/books.csv'),
                                headers: true)
    all_books_table.by_col[2].each do |title|
      puts title
    end
  end
end

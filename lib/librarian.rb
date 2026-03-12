# frozen_string_literal: true

class Librarian
  def initialize(books_file_path, borrowed_file_path)
    @books_file_path = books_file_path
    @borrowed_file_path = borrowed_file_path
    @books = load_books
    @borrowed_books = load_borrowed_books
  end

  def load_books
    CSV.read(@books_file_path, headers: true)
  end

  def load_borrowed_books
    return [] unless File.exist?(@borrowed_file_path)

    File.readlines(@borrowed_file_path).map(&:chomp)
  end

  def list_available_books
    puts @borrowed_books.count
    puts 'Book ID | Book Name | Author | Release Year'
    @books.each do |book|
      next if @borrowed_books.include?(book['Book ID'])

      puts book.fields.join(' | ')
    end
  end
end

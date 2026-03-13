# frozen_string_literal: true

class Librarian
  def initialize(books_file_path, borrowed_file_path)
    @books_file_path = books_file_path
    @borrowed_file_path = borrowed_file_path
    @books = load_books
    @borrowed_books = load_borrowed_books
  end

  def list_available_books
    puts 'Book ID | Book Name | Author | Release Year'
    @books.each do |book|
      next if @borrowed_books.include?(book['Book ID'])

      puts book.fields.join(' | ')
    end
  end

  def borrow_book(book_id)
    return false unless book_available(book_id)

    @borrowed_books << book_id
    save_borrowed_book(book_id)
  end

  def return_book(book_id)
    return false unless @borrowed_books.include?(book_id)

    @borrowed_books.delete(book_id)
    update_borrowed_books
    true
  end

  private

  def book_available(book_id)
    return false unless @books.by_col[0].include?(book_id)
    return true unless @borrowed_books.include?(book_id)

    false
  end

  def load_books
    CSV.read(@books_file_path, headers: true)
  end

  def load_borrowed_books
    return [] unless File.exist?(@borrowed_file_path)

    File.readlines(@borrowed_file_path).map(&:chomp)
  end

  def save_borrowed_book(book_id)
    File.write(@borrowed_file_path, "#{book_id}\n", mode: 'a')
  end

  def update_borrowed_books
    File.open(@borrowed_file_path, mode: 'w') do |file|
      file.puts(@borrowed_books.join('\n'))
    end
  end
end

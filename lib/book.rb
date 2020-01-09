class Book
  attr_accessor :name
  attr_reader :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all()
    from_db_books = DB.exec("SELECT * FROM books;")
    books = []
    from_db_books.each do |book|
      name = book.fetch("name")
      id = book.fetch("id").to_i
      books.push(Book.new({:name => name, :id => id}))
    end
    books
  end

  def save()
    results = DB.exec("INSERT INTO books (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first().fetch("id").to_i
  end

  def ==(self_compare)
    self.name == self_compare.name ? true : false
  end

  def self.find(id)
    returned_books = DB.exec("SELECT * FROM books WHERE id = #{id};").first()
    name = returned_books.fetch("name")
    book = Book.new({:name => name, :id => id})
  end
end

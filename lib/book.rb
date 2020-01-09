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

  def update(attributes)
    @name = attributes
    DB.exec("UPDATE books SET name = '#{@name}' WHERE id = #{@id}")
  end

  def delete()
    DB.exec("DELETE FROM books WHERE id = #{@id};")
  end

  def self.search(name)
    search_results = []
    results = DB.exec("SELECT * FROM books WHERE name ILIKE '%#{name}%';")
    results.each do |result|
      id = results.first().fetch("id").to_i
      name = results.first().fetch("name")
      search_results.push(Book.new({:id => id, :name => name}))
    end
    search_results
  end
end

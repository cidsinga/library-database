class Author
  attr_accessor :name
  attr_reader :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all()
    returned_authors = DB.exec("SELECT * FROM authors;")
    authors = []
    returned_authors.each() do |author|
      id = author.fetch("id").to_i
      name = author.fetch("name")
      authors.push(Author.new({:id => id, :name => name}))
    end
    authors
  end

  def save()
    new_id = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
    @id = new_id.first().fetch("id").to_i
  end

  def ==(self_compare)
    self.name == self_compare.name ? true : false
  end

  def self.find(id)
    returned_author = DB.exec("SELECT * FROM authors WHERE id = #{id};")
    name = returned_author.first().fetch("name")
    author = Author.new({:id => id, :name => name})
  end

  def update(attributes)
    if (attributes.has_key?(:name))  && (attributes.fetch(:name) != nil)
      @name = attributes.fetch(:name)
      DB.exec("UPDATE authors SET name = '#{@name}' WHERE id = #{@id};")
    end
    book_name = attributes.fetch(:book_name)
    if book_name != nil
      book = DB.exec("SELECT * FROM books WHERE lower(name)='#{book_name.downcase}';").first
      if book != nil
        DB.exec("INSERT INTO authors_books (book_id, author_id) VALUES (#{book['id'].to_i}, #{@id});")
      end
    end
  end

  def books
    books = []
    results = DB.exec("SELECT books.*
      FROM authors
      JOIN authors_books ON (authors.id = authors_books.author_id)
      JOIN books ON (authors_books.book_id = books.id)
      WHERE authors.id = #{@id};")
      results.each do |result|
        id = results.first().fetch("id").to_i
        name = results.first().fetch("name")
        books.push(Book.new({:id => id, :name => name}))
      end
      books
    end

    def delete()
      DB.exec("DELETE FROM authors WHERE id = #{@id};")
    end
    def self.search(name)
      search_results = []
      results = DB.exec("SELECT * FROM authors WHERE name ILIKE '%#{name}%';")
      results.each do |result|
        id = results.first().fetch("id").to_i
        name = results.first().fetch("name")
        search_results.push(Author.new({:id => id, :name => name}))
      end
      search_results
    end
  end

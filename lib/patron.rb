class Patron
  attr_accessor :name
  attr_reader :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id).to_i
  end

  def self.all
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    patrons = []
    returned_patrons.each do |patron|
      name = patron.fetch("name")
      id = patron.fetch("id").to_i
      patrons.push(Patron.new({:name => name, :id => id}))
    end
    patrons
  end

  def save()
    results = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first().fetch("id").to_i
  end

  def ==(self_compare)
    self.name == self_compare.name ? true : false
  end

  def self.find(id)
    returned_patrons = DB.exec("SELECT * FROM patrons WHERE id = #{id};").first
    name = returned_patrons.fetch("name")
    patron = Patron.new({:name => name, :id => id})
  end

  def update(attributes)
    if (attributes.has_key?(:name)) && (attributes.fetch(:name) != nil)
      @name = attributes.fetch(:name)
      DB.exec("UPDATE patrons SET name ='#{@name}' WHERE id = #{@id};")
    end
    book_name = attributes.fetch(:book_name)
    if book_name != nil
      book = DB.exec("SELECT * FROM books WHERE lower(name)='#{book_name.downcase}';").first
      if book != nil
        DB.exec("INSERT INTO checkouts (book_id, patron_id, checkout_date, return_date, checked_out) VALUES (#{book['id'].to_i}, #{@id}, NOW(), NOW() + '14 days', true);")
      end
    end
  end

  def books
    books = []
    results = DB.exec("SELECT books.*, checkouts.return_date
      FROM patrons
      JOIN checkouts ON (patrons.id = checkouts.patron_id) JOIN books ON (checkouts.book_id = books.id)
      WHERE patrons.id = #{id}")
      results.each do |result|
        id = results.first().fetch("id").to_i
        name = results.first().fetch("name")
        return_date = results.first().fetch("return_date")
        books.push(Book.new({:id => id, :name => name}))
        books.push(return_date)
      end
      books
    end

    def delete()
      DB.exec("DELETE FROM patrons WHERE id = #{@id};")
    end

    def self.search(name)
      results = DB.exec("SELECT * FROM patrons WHERE name = '#{name}';")
      if results.first().has_key?("name")
        id = results.first().fetch("id").to_i
        name = results.first().fetch("name")
        Patron.new({:id => id, :name => name})
      else
         return nil
      end
    end
  end

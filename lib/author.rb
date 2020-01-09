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
end

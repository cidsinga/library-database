require('spec_helper')

describe(Book) do
  describe('#self.all') do
    it('return empty if no results') do
      expect(Book.all).to(eq([]))
    end
  end
  describe(".save") do
    it('saves an patron') do
      book = Book.new({:name => "Steve", :id => nil})
      book.save()
      expect(Book.all).to(eq([book]))
    end
  end
  describe("#find") do
    it('finds a book by id') do
      book = Book.new({:name => "Cat", :id => nil})
      book.save()
      book = Book.new({:name => "Dog", :id => nil})
      book.save()
      expect(Book.find(book.id)).to(eq(book))
    end
  end
  describe(".update") do
    it('updates a book') do
      book = Book.new({:name => "Steve", :id => nil})
      book.save()
      book.update("Bill")
      expect(book.name).to(eq("Bill"))
    end
  end
end

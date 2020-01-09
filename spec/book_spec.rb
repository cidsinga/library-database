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

  describe(".delete") do
    it("delete based on id") do
      book = Book.new({:name => "Steve", :id => nil})
      book.save()
      book2 = Book.new({:name => "Bill", :id => nil})
      book2.save()
      book2.delete
      expect(Book.all).to(eq([book]))
    end
  end

  describe("#search") do
    it("returns resluts based on search string") do
      book = Book.new({:name => "Steve", :id => nil})
      book.save()
      book2 = Book.new({:name => "Bill", :id => nil})
      book2.save()
      expect(Book.search("Ill")).to(eq([book2]))
    end
  end
end

require('spec_helper')

describe(Patron) do
  describe('#self.all') do
    it('return empty if no results') do
      expect(Patron.all).to(eq([]))
    end
  end

  describe(".save") do
    it('saves an patron') do
      patron = Patron.new({:name => "Steve", :id => nil})
      patron.save
      expect(Patron.all).to(eq([patron]))
    end
  end
  describe("#find") do
    it('finds a patron by id') do
      patron = Patron.new({:name => "Cat", :id => nil})
      patron.save()
      patron2 = Patron.new({:name => "Dog", :id => nil})
      patron2.save()
      expect(Patron.find(patron.id)).to(eq(patron))
    end
  end

  describe(".update") do
    it('updates a patron') do
      patron = Patron.new({:name => "Steve", :id => nil})
      patron.save()
      book = Book.new({:name => "cat", :id => nil})
      book.save()
      patron.update({:book_name => "cat"})
      expect(patron.books).to(eq([book]))
    end
  end

  describe("#duedates")

end

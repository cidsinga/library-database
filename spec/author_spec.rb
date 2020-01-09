require('spec_helper')

describe(Author) do
  describe('#self.all') do
    it('return empty if no results') do
      expect(Author.all).to(eq([]))
    end
  end

  describe(".save") do
    it('saves an author') do
      author = Author.new({:name => "Steve", :id => nil})
      author.save()
      expect(Author.all).to(eq([author]))
    end
  end

  describe("#find") do
    it('finds author by id') do
      author = Author.new({:name => "Steve", :id => nil})
      author.save()
      author2 = Author.new({:name => "Bill", :id => nil})
      author2.save()
      expect(Author.find(author.id)).to(eq(author))
    end
  end
  describe(".update") do
    it('updates an author') do
      author = Author.new({:name => "Steve", :id => nil})
      author.save()
      author.update("Bill")
      expect(author.name).to(eq("Bill"))
    end
  end
end


    require('rspec')
    require('library')

    describe(Author) do
    describe('#self.all') do
      it('test') do
        test = Author.new()
        expect(test.self.all()).to(eq('test'))
      end
    end
  end
  
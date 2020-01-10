require('sinatra')
require('sinatra/reloader')
require('pry')
require('./lib/author')
require('./lib/patron')
require('./lib/book')
require('pg')

DB = PG.connect({:dbname => "library"})

get('/') do
  erb(:index)
end
get('/books') do
   erb(:books)
end

get('/books/search') do
  book_search = params[:book_search]
  author_search =  params[:book_search]
  if (book_search =~ /^[a-z0-9 \_ \- ]*$/) || (author_search =~ /^[a-z0-9 \_ \-]*$/)
    @books = Book.search(book_search)
    @authors = Author.search(author_search)
    erb(:book_results)
  else
    erb(:error)
  end
end

get('/books/new') do
  erb(:book_new)

end

get('/books/:id') do

end
post('/books') do
  book_title = params[:book_title]
  author_name = params[:author_name]
  if (book_title =~ /^[a-z0-9 \_ \-]*$/) || (author_name =~ /^[a-z0-9 \_ \-]*$/)
    author = Author.new({:name => author_name, :id => nil})
    author.save
    book = Book.new({:name => book_title, :id => nil})
    book.save
    author.update({:book_name => book.name})
    erb(:book_new)
  else
    erb(:error)
  end
end

get('/books/:id/edit') do

end

patch('/books/:id') do

end

delete('/books/:id') do

end
get('/authors') do

end

get('/authors/new') do

end

get('/authors/:id') do

end
post('/authors') do

end

get('/authors/:id/edit') do

end

patch('/authors/:id') do

end

delete('/authors/:id') do

end
get('/patrons') do

end
get('/patrons/login') do
  erb(:user_login)
end

post('/patrons/login') do
  user = params[:user_name]
  if user =~ /^[a-z0-9 \_ \-]*$/
    results = Patron.search(user)
    unless results.nil?
      id = results.id.to_i
      redirect to("/patrons/#{id}")
    else
      erb(:error)
    end
  else
    erb(:error)
  end
end

get('/patrons/new') do
  erb(:patron_new)
end

get('/patrons/:id') do
  @user = Patron.find(params[:id].to_i)
  erb(:patron)
end
post('/patrons') do
  name = params[:user_name]
  if name =~ /^[a-z0-9 \_ \-]*$/
    user = Patron.new({:name => name, :id => nil})
    user.save()
    erb(:admin)
  else
    erb(:error)
  end
end

get('/patrons/:id/edit') do

end

patch('/patrons/:id') do

end

delete('/patrons/:id') do

end

get('/admin') do
  erb(:admin)
end

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
  @books = Book.search(params[:book_search])
  @authors = Author.search(params[:book_search])
  erb(:books)
end

get('/books/new') do
  erb(:book_new)

end

get('/books/:id') do

end
post('/books') do
author = Author.new({:name => params[:author_name], :id => nil})
author.save
book = Book.new({:name => params[:book_title], :id => nil})
book.save
author.update({:book_name => book.name})
erb(:book_new)
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
  results = Patron.search(user)
  if (results != []) && (results != nil)  &&  ( user =~ /^[a-z0-9 \_ \-]*$/ )
    id = results.first().id.to_i
    redirect to("/patrons/#{id}")
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
  user = Patron.new({:name => name, :id => nil})
  user.save()
  erb(:admin)
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

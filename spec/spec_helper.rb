require('pry')
require('author')
require('patron')
require('book')
require('pg')
require('rspec')

DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM authors *;")
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM patrons *;")
  end
end

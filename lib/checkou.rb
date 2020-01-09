"SELECT books.* FROM patrons JOIN checkouts ON (patrons.id = checkouts.patron_id) JOIN books ON (checkouts.book_id = books.id) WHERE patrons.id = #{id}"

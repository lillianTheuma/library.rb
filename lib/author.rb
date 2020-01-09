class Author
  attr_accessor :id, :name, :bio

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @bio = attributes.fetch(:bio)
  end


  def self.all
    returned_authors = DB.exec("SELECT * FROM authors;")
    authors = []
    returned_authors.each() do |author|
      name = author.fetch("name")
      id = author.fetch("id").to_i
      bio = author.fetch("bio")
      authors.push(Author.new({:name => name, :id => id, :bio => bio}))
    end
    authors
  end

  def save
    result = DB.exec("INSERT INTO authors (name, bio) VALUES ('#{@name}', '#{@bio}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(author_to_compare)
    self.name().downcase().eql?(author_to_compare.name.downcase())
  end

  def self.clear
    DB.exec("DELETE FROM authors *;")
  end

  def self.find(id)
    author = DB.exec("SELECT * FROM authors WHERE id = #{id};").first
    name = author.fetch("name")
    id = author.fetch("id").to_i
    bio = author.fetch("bio")
    Author.new({:name => name, :id => id, :bio => bio})
  end

  def self.query(name)
    search_results = []
    authors = DB.exec("SELECT * FROM authors WHERE name LIKE '%#{name}%';")
    authors.each() do |author|
      name = author.fetch("name")
      id = author.fetch("id").to_i
      bio = author.fetch("bio")
      search_results.push(Author.new({:name => name, :id => id, :bio => bio}))
    end
    return search_results
  end


  def books
    Book.find_by_author(self.id)
  end

  def update(attributes)
    @name = attributes.fetch(:name)
    @bio = attributes.fetch(:bio)
    DB.exec("UPDATE authors SET name = '#{@name}' WHERE id = #{@id};")
    DB.exec("UPDATE authors SET bio = '#{@bio}' WHERE id = #{@id};")
  end

  def books
    books = []
    results = DB.exec("SELECT book_id FROM creators WHERE author_id = #{@id};")
    results.each() do |result|
      book_id = result.fetch("book_id").to_i()
      book = DB.exec("SELECT * FROM books WHERE id = #{book_id};")
      name = book.first().fetch("name")
      genre = book.first().fetch("genre")
      isbn = book.first().fetch("isbn")
      books.push(Book.new({:name => name, :id => id, :genre => genre, :isbn => isbn}))
    end
    return books
  end

  def delete
    DB.exec("DELETE FROM creators WHERE author_id = #{@id};")
    DB.exec("DELETE FROM authors WHERE id = #{@id};")
  end
end

class Patron
  attr_accessor :id, :name, :phone, :address


  def initialize(attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @phone = attributes.fetch(:phone)
    @address = attributes.fetch(:address)
  end

  def self.all
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    patrons = []
    returned_patrons.each() do |patron|
      name = patron.fetch("name")
      id = patron.fetch("id").to_i
      phone = patron.fetch("phone").to_i
      address = patron.fetch("address")
      patrons.push(Patron.new({:id => id, :name => name, :phone => phone, :address => address}))
    end
    patrons
  end

  def save
    result = DB.exec("INSERT INTO patrons (name, address, phone) VALUES ('#{@name}', '#{@address}', #{@phone.to_i}) RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(patron_to_compare)
    self.name().downcase().eql?(patron_to_compare.name.downcase())
  end

  def self.clear
    DB.exec("DELETE FROM patrons *;")
  end

  def self.search(name)
    patron = DB.exec("SELECT * FROM patrons WHERE name = '#{name}';").first
    name = patron.fetch("name")
    id = patron.fetch("id").to_i
    phone = patron.fetch("phone").to_i
    address = patron.fetch("address")
    Patron.new({:id => id, :name => name, :phone => phone, :address => address})
  end

  def self.find(id)
    patron = DB.exec("SELECT * FROM patrons WHERE id = #{id};").first
    name = patron.fetch("name")
    id = patron.fetch("id").to_i
    phone = patron.fetch("phone").to_i
    address = patron.fetch("address")
    Patron.new({:id => id, :name => name, :phone => phone, :address => address})
  end

  def find_by_author(author_id)
    patrons = []
    returned_patrons = DB.exec("SELECT * FROM patrons_authors WHERE author_id = #{author_id};")
    returned_patrons.each() do |patron|
      name = patron.fetch("name")
      id = patron.fetch("id").to_i
      patrons.push(Patron.new({:name => name, :id => id}))
    end
    return patrons
  end

  def books
    books = []
    results = DB.exec("SELECT book_id FROM checkouts WHERE patron_id = #{@id};")
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

  def update(name)
    @name = name
    DB.exec("UPDATE patrons SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM patrons WHERE id = #{@id};")
  end
end

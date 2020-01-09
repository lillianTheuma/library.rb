require 'rspec'
require 'book'
require('spec_helper')

describe '#Book' do

  describe('#save') do
    it("Saves book") do
      book = Book.new({:id => nil, :name => "Kind of Blue", :genre => "Sci Fi", :isbn => 123234234})
      book.save()
      book.addAuthor(1)
      book2 = Book.new({:id => nil, :name => "Kind of Green", :genre => "Sci Fi", :isbn => 345789234})
      book2.save()
      book2.addAuthor(1)
      expect(Book.all).to(eq([book, book2]))
    end
  end

  describe('.all') do
    it("returns an empty array when there are no books") do
      expect(Book.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same book if it has the same attributes as another book") do
      book = Book.new({:id => 1, :name => "Kind of Blue", :genre => "Sci Fi", :isbn => 123234234})
      book2 = Book.new({:id => 2, :name => "Kind of Blue", :genre => "Sci Fi", :isbn => 123234234})
      expect(book).to(eq(book2))
    end
  end
  #
  describe('.clear') do
    it('clears all books') do
      book = Book.new({:name => "Giant Steps", :id => nil, :genre => "Sci Fi", :isbn => 123234234})
      book.save()
      book2 = Book.new({:name => "Blue", :id => nil, :genre => "Sci Fi", :isbn => 123234234})
      book2.save()
      Book.clear()
      expect(Book.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds an book by id") do
      book = Book.new({:name => "Giant Steps", :id => nil, :genre => "Sci Fi", :isbn => 123234234})
      book.save()
      book2 = Book.new({:name => "Blue", :id => nil, :genre => "Sci Fi", :isbn => 123234234})
      book2.save()
      expect(Book.find(book.id)).to(eq(book))
    end
  end

  describe('#update') do
    it("updates an book by id") do
      book = Book.new({:name => "Giant Steps", :id => nil, :genre => "Sci Fi", :isbn => 123234234})
      book.save()
      book.update({:name => "Blue", :genre => "Sci Fi", :isbn => 123234234})
      expect(book.name).to(eq("Blue"))
    end
  end

  describe('#delete') do
    it('deletes an book by id') do
      book = Book.new({:name => "Giant Steps", :id => nil, :genre => "Sci Fi", :isbn => 123234234})
      book.save()
      book2 = Book.new({:name => "Blue", :id => nil, :genre => "Sci Fi", :isbn => 123234234})
      book2.save()
      book.delete()
      expect(Book.all).to(eq([book2]))
    end
  end

  describe('.search') do
    it('searches for the given book name') do
      Book.clear()
      book = Book.new({:name => "Giant Steps", :id => nil, :genre => "Sci Fi", :isbn => 123234234})
      book.save()
      book2 = Book.new({:name => "Blue", :id => nil, :genre => "Sci Fi", :isbn => 123234234})
      book2.save()
      book3 = Book.new({:name => "Blue", :id => nil, :genre => "Sci Fi", :isbn => 123234234})
      book3.save()
      expect(Book.search("Giant Steps")).to(eq(book))
    end
  end

end

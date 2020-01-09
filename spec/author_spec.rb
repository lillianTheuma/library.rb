require 'rspec'
require 'author'
require('spec_helper')
require 'pry'

describe '#Author' do

  describe('#save') do
    it("Saves author") do
      author = Author.new({:id => nil, :name => "Cormac McCarthy", :bio => "Cool guy"})
      author.save()
      author2 = Author.new({:id => nil, :name => "J. R. R. Tolkien", :bio => "Fantasy daddy"})
      author2.save()
      expect(Author.all).to(eq([author, author2]))
    end
  end

  describe('.all') do
    it("returns an empty array when there are no authors") do
      expect(Author.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same author if it has the same attributes as another author") do
      author = Author.new({:name => "Cormac McCarthy", :id => 1, :bio => "Cool guy"})
      author2 = Author.new({:name => "Cormac McCarthy", :id => 2, :bio => "Cool guy"})
      expect(author).to(eq(author2))
    end
  end
  #
  describe('.clear') do
    it('clears all authors') do
      author = Author.new({:name => "Cormac McCarthy", :id => nil, :bio => "Cool guy"})
      author.save()
      author2 = Author.new({:name => "J. R. R. Tolkien", :id => nil, :bio => "Fantasy daddy"})
      author2.save()
      Author.clear()
      expect(Author.all).to(eq([]))
    end
  end
  #
  describe('.find') do
    it("finds an author by id") do
      author = Author.new({:name => "Cormac McCarthy", :id => nil, :bio => "Cool guy"})
      author.save()
      author2 = Author.new({:name => "J. R. R. Tolkien", :id => nil, :bio => "Fantasy daddy"})
      author2.save()
      expect(Author.find(author.id)).to(eq(author))
    end
  end


  describe('#delete') do
    it('deletes an author by id') do
      author = Author.new({:name => "Cormac McCarthy", :id => nil, :bio => "Cool guy"})
      author.save()
      author2 = Author.new({:name => "J. R. R. Tolkien", :id => nil, :bio => "Fantasy daddy"})
      author2.save()
      author.delete()
      expect(Author.all).to(eq([author2]))
    end
  end

  describe('#update') do
    it("Able to change an authors name") do
      author = Author.new({:name => "John Coltrane", :id => nil, :bio => "Musician"})
      author.save()
      author.update({:name => "Joan Rivers", :id => nil, :bio => "Comedy"})
      expect(author.name).to(eq("Joan Rivers"))
    end
  end

end

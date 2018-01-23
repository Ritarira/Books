class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :books_count

  def books_count
    object.books.count
  end
end

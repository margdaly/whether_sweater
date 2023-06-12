class BookSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :publisher, :isbn
end
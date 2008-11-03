class Post
  include DataMapper::Resource
  
  property :id, Serial

  property :subject, String
  property :content, Text

end

class Post < ApplicationRecord
  acts_as_votable
  attr_accessor :image
  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_attached_file :image , styles: { medium: "900x700", small: "400x300" }#validate_media_type: false
 validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  #do_not_validate_attachment_file_type :image

end

require "#{Rails.root}/app/controllers/core/interpolations"
# Photo class
# Fields:
#  [Integer]        id
#  [String]         file_file_name
#  [String]         file_content_type
#  [Integer]        file_file_size
#  [DateTime]       file_updated_at
#  [DateTime]       deleted_at
#  [DateTime]       created_at
#  [DateTime]       updated_at
#  [User::User]     user
#  [Object]         file
class Uploaded::Photo < ActiveRecord::Base
  extend Core::Deletable

  belongs_to :user, inverse_of: :photos, class_name: 'User::User'

  has_attached_file :file,
                    url: '/images/:hash/:id/:style/image.:extension',
                    styles: { :small => '400x400#' },
                    path: ENV['UPLOAD_FOLDER'] + '/images/:hash/:id/:style/image.:extension',
                    hash_secret: 'asd1we1478yasdhbjhqbekhjqb',
                    use_timestamp: false

  validates_attachment_presence :file
  validates_attachment_content_type :file, content_type: %r{\Aimage/.*\Z}

  # Generates a photo
  # @param [User::User] user
  # @param [Object] file
  # @return [Uploaded::Photo]
  def initialize(user, file)
    super()
    self.user = user
    self.file = file
  end
end

class Podcast < ApplicationRecord
  has_many :episodes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   has_attached_file :thumbnail, styles: { large: "1000x1000#", medium: "550x550#" }
   validates_attachment_content_type :thumbnail, content_type: /\Aimage\/.*\z/
end

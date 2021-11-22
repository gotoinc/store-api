# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  jti                    :string           not null
#  last_name              :string
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("customer")
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_jti                   (jti) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_role                  (role)
#
class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  ROLES = %i[customer provider admin].freeze
  ALLOWED_MIME_TYPES = %w[
    image/png
    image/gif
    image/jpeg
    image/webp
  ].freeze
  ALLOWED_PASSWORD = /\A(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{8,}\z/.freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :validatable,
         :registerable,
         :confirmable,
         :recoverable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  enum role: ROLES

  # Attachment initialization
  has_one_attached :photo

  # Relations
  has_one :category_user, dependent: :destroy
  has_one :cart, dependent: :destroy, inverse_of: :user
  has_one :category, through: :category_user
  has_many :products, through: :category, dependent: :destroy
  has_many :invoices, through: :cart, dependent: :destroy, inverse_of: :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_products, class_name: 'Product', through: :favorites, source: :product, dependent: :destroy

  # Validators
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true, on: :create, if: :customer?
  validates :photo, file_size: { less_than_or_equal_to: 3.megabyte },
                    file_content_type: { allow: ALLOWED_MIME_TYPES }

  # Scopes
  scope :activated, -> { all }

  # Callbacks
  before_create :build_cart, if: :customer?

  def self.check_password(password)
    ALLOWED_PASSWORD === password
  end
end

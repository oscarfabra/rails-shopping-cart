class Customer < ActiveRecord::Base
  has_many :orders, dependent: :destroy

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :password, length: { minimum: 7 }, presence: true

  after_destroy :ensure_an_admin_remains

  private
    def ensure_an_admin_remains
      if Customer.count.zero?
        # Raises exception to avoid deleting last user. Rollbacks transaction.
        raise "Can't delete last user"
      end
    end
end

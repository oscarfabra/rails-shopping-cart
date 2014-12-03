class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true, uniqueness: true
  validates :password, presence: true

  after_destroy :ensure_an_admin_remains

  private
    def ensure_an_admin_remains
      if User.count.zero?
        # Raises exception to avoid deleting last user. Rollbacks transaction.
        raise "Can't delete last user"
      end
    end
end

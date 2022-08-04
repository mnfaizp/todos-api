class User < ApplicationRecord
    had_secure_password

    has_may :todos, foreign_key: :created_by

    validates_presence_of :email, :name, :password_digest
end

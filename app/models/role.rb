class Role < ApplicationRecord
    has_many :account, dependent: :restrict_with_exception
end

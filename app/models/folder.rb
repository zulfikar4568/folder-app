class Folder < ApplicationRecord
  belongs_to :account

  has_many :documents, dependent: :destroy
end

class Folder < ApplicationRecord
    has_many :documents, dependent: :destroy
end

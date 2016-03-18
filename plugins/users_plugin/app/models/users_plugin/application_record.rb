module UsersPlugin
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end

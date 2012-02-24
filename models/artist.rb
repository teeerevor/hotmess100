class Artist < ActiveRecord::Base
  has_many :songs

  def the_name_fix
    return self.name.split(/, /).reverse.join(' ') if self.name =~ /, the/
    self.name
  end
end

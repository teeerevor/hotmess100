class Artist < ActiveRecord::Base
  has_many :songs

  def the_name_fix
    return self.name.split(/, /).reverse.join(' ') if self.name =~ /, the/i
    self.name
  end

  def short_desc
    if desc && desc.size > 500
      return desc[0..500].to_s + '...'
    end
    desc
  end
end

class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: 'Catamaran'})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: 'Sailboat'}).uniq
  end

   def self.motorboaters
    includes(boats: :classifications).where(classifications: {name: 'Motorboat'}).uniq
  end

  def self.talented_seamen
    where("id in (?)", self.sailors & self.motorboaters)
  end

  def self.non_sailors
    where.not("id in (?)", self.sailors.pluck(:id))
  end



end

require_relative 'database'

class Player

  attr_accessor :name, :id, :email

  def initialize(name, email)
    @name = name
    @email = email
    @id = get_id.to_i
  end

  def win_loss
    from_db[2..4]
  end


  private
    def get_id
      to_db
      from_db[0].to_s
    end

    def to_db
      Database.insert_player(self)
    end

    def from_db
      Database.retrieve_player(self)
    end

end
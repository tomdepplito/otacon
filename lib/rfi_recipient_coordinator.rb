class RfiRecipientCoordinator
  attr_accessor :sender_id, :body

  def initialize(sender_id, body)
    @recipient_ids = Set.new
    @sender_id = sender_id
    @body = body
  end

  private

  def create_rfis
    @recipient_ids.each do |recipient_id|
      rfi = Rfi.new(:body => @body, :receiver_id => recipient_id, :sender_id => @sender_id)
      rfi.save
    end
  end
end

class ErrorMessage
  attr_reader :message, :status

  def initialize(message, status)
    @message = message
    @status = status
  end

  def as_json(*)
    { message: message, status: status }
  end
end
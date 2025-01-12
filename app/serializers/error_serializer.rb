class ErrorSerializer
  def self.format_error(error_message)
    {
      errors: [
        {
          status: error_message.status.to_s,
          title: "Error",
          detail: error_message.message
        }
      ]
    }
  end
end

class ErrorSerializer
  def self.format_error(error_message, status)
    {
      errors: [
        {
          status: status.to_s,
          title: "Error",
          detail: error_message
        }
      ]
    }
  end
end
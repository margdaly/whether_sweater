class ErrorSerializer
  def initialize(error)
    @error = error
  end

  def error_message
    {
      errors: [
        {
          detail: @error.message,
          status: @error.status
        }
      ]
    }
  end
end

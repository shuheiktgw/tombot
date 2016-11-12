class ResponseService
  PREFIX_KEY = 'tmb'

  def initialize(input_text)
    @prefix, @command, @data = input_text.split('_')
  end

  def form_response
    return '' unless @prefix == PREFIX_KEY

    case @command
      when 'ping'
        return 'pong'
      else
        return ''
    end
  end
end
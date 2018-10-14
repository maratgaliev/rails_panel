require 'callsite'

module MetaRequest
  module LogReader

    private
    def push_event(level, message)
      c = Callsite.parse(caller[1])
      payload = {:message => message, :level => level, :line => c.line, :filename => c.filename, :method => c.method}
      AppRequest.current.events << Event.new('meta_request.devlog', 0, 0, 0, payload)
    rescue Exception => e
      MetaRequest.logger.fatal(e.message + "\n " + e.backtrace.join("\n "))
    end
  end
end

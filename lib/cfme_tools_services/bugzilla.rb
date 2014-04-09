module CFMEToolsServices
  class Bugzilla
    include ServiceMixin

    class << self
      attr_accessor :credentials
    end
    delegate :credentials, :to => self

    def initialize
      service # initialize the service
    end

    def service
      @service ||= begin
        require 'ruby_bugzilla'
        bz = ::RubyBugzilla.new(*credentials.values_at("bugzilla_uri", "username", "password"))
        bz.login
        bz
      end
    end

    def self.ids_in_git_commit_message(message)
      ids = []
      message.each_line.collect do |line|
        match = %r{^\s*https://bugzilla\.redhat\.com/show_bug\.cgi\?id=(?<bug_id>\d+)$}.match(line)
        ids << match[:bug_id].to_i if match
      end
      ids
    end
  end
end

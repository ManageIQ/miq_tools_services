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
  end
end

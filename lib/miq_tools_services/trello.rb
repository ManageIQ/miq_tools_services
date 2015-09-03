module MiqToolsServices
  class Trello
    include ServiceMixin

    class << self
      attr_accessor :credentials
    end
    delegate :credentials, :to => self

    def self.configure
      return if @configured
      # Trello OAuth Configuration
      #Trello.configure do |config|
        #config.consumer_key       = credentials["consumer_key"]
        #config.consumer_secret    = credentials["consumer_secret"]
        #config.oauth_token        = credentials["oauth_token"]
        #config.oauth_token_secret = credentials["oauth_token_secret"]
      #end

      # Trello Basic Auth Configuration
      ::Trello.configure do |config|
        config.developer_public_key = credentials["username"]
        config.member_token         = credentials["password"]
      end

      @configured = true
    end

    attr_reader :organization_id

    def initialize(organization_id)
      @organization_id = organization_id
      service # initialize the service
    end

    def service
      @service ||= begin
        require 'trello'
        require 'miq_tools_services/trello/core_ext'
        self.class.configure
        ::Trello::Organization.find(organization_id)
      end
    end
  end
end

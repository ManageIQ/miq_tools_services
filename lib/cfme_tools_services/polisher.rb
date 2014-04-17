module CFMEToolsServices
  class Polisher
    include ServiceMixin

    attr_accessor :gemfile_path

    def initialize(opts)
      targets = opts[:targets]
      @gemfile_path = opts[:gemfile_path]

      require 'polisher/gemfile'
      ::Polisher::VersionChecker.check(*targets)

      if targets.include?(:git)
        require 'polisher/git/pkg'
        ::Polisher::Git::Pkg.dist_git_url opts[:dist_git_uri]
      end

      if targets.include?(:koji)
        require 'polisher/koji'
        ::Polisher::Koji.koji_tag opts[:build_tags]
        ::Polisher::Koji.koji_url opts[:build_uri]
        ::Polisher::Koji.package_prefix opts[:pkg_prefix]
      end

      if targets.include?(:errata)
        require 'polisher/errata'
        ::Polisher::Errata.advisory_url opts[:advisory_uri]
        ::Polisher::Errata.package_prefix opts[:pkg_prefix]
      end
    end

    def gemfile
      @gemfile ||= ::Polisher::Gemfile.parse(gemfile_path)
    end
  end # class Polisher
end # module CFMEToolsServices

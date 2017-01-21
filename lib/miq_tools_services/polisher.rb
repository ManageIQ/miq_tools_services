module MiqToolsServices
  class Polisher
    include ThreadsafeService

    attr_accessor :gemfile_path

    def initialize(opts)
      targets = Array.new(opts[:targets])
      @gemfile_path = opts[:gemfile_path]

      targets.delete(:errata) if opts[:advisory_uri].blank?
      targets.delete(:git)    if opts[:dist_git_uri].blank?
      targets.delete(:koji)   if opts[:build_uri].blank? ||
                                 opts[:build_tags].blank?

      require 'polisher/gemfile'
      ::Polisher::VersionChecker.check(*targets)

      if targets.include?(:git)
        require 'polisher/git/pkg'
        ::Polisher::Git::Pkg.dist_git_url opts[:dist_git_uri]
        ::Polisher::Git::Pkg.pkg_cmd opts[:pkg_cmd]
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
end # module MiqToolsServices

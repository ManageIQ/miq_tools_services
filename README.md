# MiqToolsServices

[![Build Status](https://travis-ci.org/ManageIQ/miq_tools_services.svg)](https://travis-ci.org/ManageIQ/miq_tools_services)
[![Code Climate](https://codeclimate.com/github/ManageIQ/miq_tools_services/badges/gpa.svg)](https://codeclimate.com/github/ManageIQ/miq_tools_services)

Shared services for ManageIQ tools and applications

The service wrappers allow us to have a central location for "extension"
methods, as well as providing thread safety around things that may not be thread
safe.  The latter is important because most of the ManageIQ tools use
[Sidekiq](http://sidekiq.org/) which runs in a threaded context.

Services that are wrapped or extended include
- Bugzilla (via the [ActiveBugzilla](http://rubygems.org/gems/active_bugzilla)
  gem)
- GitHub (via the [GitHub API](http://peter-murach.github.io/github/) gem)
- Git (via the [MiniGit](http://rubygems.org/gems/minigit) gem)
- Sidekiq (extension mixin)
- Ruby gem / rpm services (via the [Polisher](http://rubygems.org/gems/polisher)
  gem)

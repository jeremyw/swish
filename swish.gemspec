Gem::Specification.new do |s|
  s.name = %q{swish}
  s.version = "0.6.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jeremy Weiskotten", "Jon Distad", "Michael Parenteau"]
  s.date = %q{2010-10-08}
  s.description = %q{A Ruby wrapper for the Dribbble API}
  s.email = %q{jeremy@weiskotten.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
    ".gitignore",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/dribbble/base.rb",
    "lib/dribbble/comment.rb",
    "lib/dribbble/config.rb",
    "lib/dribbble/paginated_list.rb",
    "lib/dribbble/player.rb",
    "lib/dribbble/redis_cache.rb",
    "lib/dribbble/shot.rb",
    "lib/swish.rb",
    "swish.gemspec",
    "test/base_test.rb",
    "test/comment_test.rb",
    "test/helper.rb",
    "test/paginated_list_test.rb",
    "test/player_test.rb",
    "test/shot_test.rb"
  ]
  s.homepage = %q{http://github.com/michaelparenteau/swish}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A Ruby wrapper for the Dribbble API}
  s.test_files = [
    "test/helper.rb",
     "test/player_test.rb",
     "test/shot_test.rb"
  ]

  s.add_runtime_dependency(%q<crack>, "~> 0.1.8")
  s.add_runtime_dependency(%q<httparty>, "~> 0.6.1")
  s.add_runtime_dependency(%q<json_pure>, "~> 1.4.6")
end


class jenkins_plugin::plugins::base::structs {

  # this plugin is managed by jenkins upstream.
  # keep this class empty to avoid duplicate resource declaration
  jenkins::plugin { 'structs':
    version => '1.19',
  }
}

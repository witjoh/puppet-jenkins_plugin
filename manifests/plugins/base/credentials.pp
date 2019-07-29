class jenkins_plugin::plugins::base::credentials {

  # this plugin is managed by jenkins upstream.
  # keep this class empty to avoid duplicate resource declaration
  jenkins::plugin { 'credentials':
    version => '2.2.0',
  }
}

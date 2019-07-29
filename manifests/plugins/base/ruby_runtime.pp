class jenkins_plugin::plugins::base::ruby_runtime {

  jenkins::plugin { 'ruby-runtime':
    version => '0.12',
  }
}

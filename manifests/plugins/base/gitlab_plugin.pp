class jenkins_plugin::plugins::base::gitlab_plugin {
  jenkins::plugin { 'gitlab-plugin':
    version => '1.5.12',
  }
}


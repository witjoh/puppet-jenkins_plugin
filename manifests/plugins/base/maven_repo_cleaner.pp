class jenkins_plugin::plugins::base::maven_repo_cleaner {

  jenkins::plugin { 'maven-repo-cleaner':
    version => '1.2',
  }
}

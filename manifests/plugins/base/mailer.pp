class jenkins_plugin::plugins::base::mailer {

  jenkins::plugin { 'mailer':
    version => '1.23',
  }
}

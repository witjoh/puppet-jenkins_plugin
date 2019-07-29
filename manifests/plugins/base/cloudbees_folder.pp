class jenkins_plugin::plugins::base::cloudbees_folder {

  jenkins::plugin { 'cloudbees-folder':
    version =>  '6.9',
  }
}

# Manages the Jenkins build-name-setter plugin
# 
class jenkins_plugin::plugins::base::build_name_setter (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'build-name-setter':
    version => $version,
  }
}

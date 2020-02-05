# Manages the Jenkins conditional-buildstep plugin
# 
class jenkins_plugin::plugins::base::conditional_buildstep (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'conditional-buildstep':
    version => $version,
  }
}

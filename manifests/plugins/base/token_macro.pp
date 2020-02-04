class jenkins_plugin::plugins::base::token_macro (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'token-macro':
    version => $version,
  }
}

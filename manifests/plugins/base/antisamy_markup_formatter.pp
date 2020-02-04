class jenkins_plugin::plugins::base::antisamy_markup_formatter (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'antisamy-markup-formatter':
    version => $version,
  }
}

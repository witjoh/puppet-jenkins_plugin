class jenkins_plugin::plugins::base::generic_webhook_trigger (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin{ 'generic-webhook-trigger':
    version => $version,
  }
}

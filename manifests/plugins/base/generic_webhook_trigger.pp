class jenkins_plugin::plugins::base::generic_webhook_trigger {

  jenkins::plugin{ 'generic-webhook-trigger':
    version => '1.54',
  }
}

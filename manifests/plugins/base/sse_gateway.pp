class jenkins_plugin::plugins::base::sse_gateway {

  jenkins::plugin { 'sse-gateway':
    version => '1.18',
  }
}

type Jenkins_plugin::JenkinsUrl =Variant[
  Pattern[/(?i:^https?:\/\/[^:]*$)/],
  Pattern[/(?i:^https?:\/\/.*:\d+$)/],
  Pattern[/(?i:^https?:\/\/.*:\d+\/.*$)/]
]

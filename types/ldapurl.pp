type Jenkins_plugin::LDAPUrl = Variant[
  Pattern[/(?i:^ldaps?:\/\/(.*)$)/], 
  Pattern[/(?i:^ldaps?:\/\/(.*):(\d*)$)/], 
  Pattern[/(?i:^\w*\.\w*(\.\w*)*(:\d*)*$)/],
]

#address not configured yet <nobody@nowhere>
type Jenkins_plugin::Email = Variant[
  Pattern[/(?i:^([A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4})$)/],
  Pattern[/(?i:^.+ <([A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4})>$)/],
]

# taken from https://semver.org/#is-there-a-suggested-regular-expression-regex-to-check-a-semver-string
type Jenkins_plugin::SemVer = Variant[
  Pattern[/^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-((?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?$/],
  Pattern[/^(0|[1-9]\d*)\.(0|[1-9]\d*)$/],
  Pattern[/^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)$/],
  Pattern[/(?i:latest)/],
]

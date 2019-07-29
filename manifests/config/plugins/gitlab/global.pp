# Configures the global gitlab settings.
#
# @summary Gitlab clobal configuration
#
# @params use_authenticated_endpoint: Enable authenticated API calls from gitlab.
#   Default: true
#
class jenkins_plugin::config::plugins::gitlab::global (
  Boolean $use_authenticated_endpoint = true,
) {

  jenkins::cli::exec { 'gitlab_set_global':
    command => "gitlab_set_global ${bool2str($use_authenticated_endpoint)}",
    unless  => "[ \$(\$HELPER_CMD gitlab_insync_global ${bool2str($use_authenticated_endpoint)}) = true ]",
    plugin  => 'gitlab-plugin',
  }
}

# This class manages initial setup for the role-strategy plugin.
# It installs a groovy script on the jenkinsmaster managing the setup
# for minimal roles and assign users to them needed to keep the jenkins
# accessibe for both initial administrators and the puppet user.
#
# Otherwise we could lock adminsitrators and the puppet user from jenkins
#
class jenkins_plugin::config::master::bootstrap_role_strategy (
  String $bootstrap_user = 'puppet',
) {

  include jenkins_plugin::config::master::bootstrap_setup

  $fixed_roles = {
    'global'          => {
      'bootstrap'     => {
        'permissions' => [
          'com.cloudbees.plugins.credentials.CredentialsProvider.Create',
          'com.cloudbees.plugins.credentials.CredentialsProvider.Delete',
          'com.cloudbees.plugins.credentials.CredentialsProvider.ManageDomains',
          'com.cloudbees.plugins.credentials.CredentialsProvider.Update',
          'com.cloudbees.plugins.credentials.CredentialsProvider.View',
          'hudson.model.Computer.Build',
          'hudson.model.Computer.Configure',
          'hudson.model.Computer.Connect',
          'hudson.model.Computer.Create',
          'hudson.model.Computer.Delete',
          'hudson.model.Computer.Disconnect',
          'hudson.model.Computer.Provision',
          'hudson.model.Hudson.Administer',
          'hudson.model.Hudson.Read',
          'hudson.model.Item.Build',
          'hudson.model.Item.Cancel',
          'hudson.model.Item.Configure',
          'hudson.model.Item.Create',
          'hudson.model.Item.Delete',
          'hudson.model.Item.Discover',
          'hudson.model.Item.Move',
          'hudson.model.Item.Read',
          'hudson.model.Item.Workspace',
          'hudson.model.Run.Delete',
          'hudson.model.Run.Replay',
          'hudson.model.Run.Update',
          'hudson.model.View.Configure',
          'hudson.model.View.Create',
          'hudson.model.View.Delete',
          'hudson.model.View.Read',
          'hudson.scm.SCM.Tag',
          'jenkins.metrics.api.Metrics.HealthCheck',
          'jenkins.metrics.api.Metrics.ThreadDump',
          'jenkins.metrics.api.Metrics.View',
          'org.jenkins.plugins.lockableresources.LockableResourcesManager.Reserve',
          'org.jenkins.plugins.lockableresources.LockableResourcesManager.Unlock',
          'org.jenkins.plugins.lockableresources.LockableResourcesManager.View',
        ],
        'users'       => [
          $bootstrap_user,
        ],
      },
    },
  }

  file { '/var/lib/jenkins/init.groovy.d/init_role_strategy.groovy':
    ensure  => file,
    owner   => 'jenkins',
    group   => 'jenkins',
    mode    => '0750',
    content => epp('jenkins_plugin/init_role_strategy.groovy.epp', { 'roles' => $fixed_roles }),
  }
}

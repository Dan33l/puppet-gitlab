# == Class gitlab::repos
#
# This class is used to configure gitlab repositories
#
class gitlab::omnibus_package_repository (
  Hash $repository_configuration,
  Boolean $manage_omnibus_repository = true,
) {
  if $manage_omnibus_repository {
    $repository_configuration.each() | String $resource_type, Hash $resources | {
      create_resources($resource_type, $resources, {tag => 'gitlab_omnibus_repository_resource'})
    }

    # ensure all repository configuration are in place before the gitlab omnibus package is installed
    Resource <| tag == 'gitlab_omnibus_repository_resource' |> -> Package['gitlab-omnibus']
  }
}

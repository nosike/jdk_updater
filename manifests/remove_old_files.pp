# Class: umuc_configure_jdk_patch_scripts_prod
#
# This module manages the RHEL 6 patch repos for us-aws, eu-aws, and ade
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  include umuc_configure_jdk_patch_scripts_prod
#
# [Remember: No empty lines between comments and class definition]
class jdk_updater::remove_old_files {
  file { '/usr/local/patching/jdk_updater_starter_prod.sh':
      ensure  => absent,
  }
  file { '/usr/local/patching/jdk_updater.sh':
      ensure  => absent,
  }
}

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
class jdk_updater {
  if $facts['os']['name'] == "RedHat" {
    if  $facts['os']['major'] == "6" {
      include jdk_updater::remove_old_cron
      include jdk_updater::remove_old_files
      package { 'umuc-jdk-updater':
        ensure => 'latest',
      }
      if $facts['hostname'] =~ /^[a-zA-Z]+-[a-zA-Z]+-d/ {
        # dev tier
        file { '/opt/umuc-jdk-updater/etc/jdk.conf':
          ensure  => file,
          owner   => 'root',
          group   => 'root',
          mode    => '0644',
          backup  => false,
          content => file("jdk_updater/jdk_conf_dev"),
        }
      }
      elsif $facts['hostname'] =~ /^[a-zA-Z]+-[a-zA-Z]+-q/ {
        # qat tier
        file { '/opt/umuc-jdk-updater/etc/jdk.conf':
          ensure  => file,
          owner   => 'root',
          group   => 'root',
          mode    => '0644',
          backup  => false,
          content => file("jdk_updater/jdk_conf_qat"),
        }
      }
      else {
        # production tier
        file { '/opt/umuc-jdk-updater/etc/jdk.conf':
          ensure  => file,
          owner   => 'root',
          group   => 'root',
          mode    => '0644',
          backup  => false,
          content => file("jdk_updater/jdk_conf_prd"),
        }
      }
    }
  }
}

#if $::operatingsystem == "RedHat" {
#  if  $::operatingsystemmajrelease == "6" {
#
#if $facts['os']['name'] == "RedHat" {
#  if $facts['virtual'] != "physical" {
#    package { 'mcelog':
#      ensure => 'absent',
#    }
#  }
#}


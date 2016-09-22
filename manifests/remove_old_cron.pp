class jdk_updater::remove_old_cron {
  # if a line in the root cron contains, jdk_updater_starter
  # change it to the exact comment in line
  file_line { 'jdk patch a':
    path => '/var/spool/cron/root',
    line => '# jdk_updater_cron now in /etc/cron.d',
    match => 'jdk_updater_starter',
  }
  # If line exists, remove it
  file_line { 'jdk patch b':
    ensure => absent,
    path => '/var/spool/cron/root',
    line => '# jdk_updater_cron now in /etc/cron.d',
  }
  # if a line in the root crontab contained
  # jdk_updater_starter (and was thus removed), restart cron
  service { 'crond':
    ensure    => running,
    enable    => true,
    subscribe => File_line['jdk patch a'],
  }
}

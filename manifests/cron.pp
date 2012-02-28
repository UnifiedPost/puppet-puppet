# = Class: puppet::cron
#
# Run the puppet client using cron.
#
# == Parameters:
#
# $ensure::     Can be present or absent. Defaults to 'present'.
#
# $command::    Command to execute.
#
# $user::       User to run command as. Defaults to 'root'
#
# $sleep::      Insert a custom amount of seconds to sleep before running
#               the actual command. If not defined, no sleep is introduced.
#               If set to 'random', we will generate a random value.
#
# $minute::     Minute(s) to run cron job on. If you set this to 'random',
#               the cronjob will be run twice each hour with a 30 minute
#               interval at a random time.
#
# $hour::       Hour(s) to run cron job on.
#
# $month::      Month(s) of the year to run cron job on.
#
# $monthday::   Day(s) of the month to run cron job on.
#
# $weekday::    The weekday(s) to run the cron job on.
#
# == Sample Usage:
#
# class { 'puppet::cron':
#
# }
#
class puppet::cron (
  $ensure   = 'present',
  $user     = 'root',
  $command  = undef,
  $sleep    = undef,
  $minute   = undef,
  $hour     = undef,
  $month    = undef,
  $monthday = undef,
  $weekday  = undef
) {

  case $sleep {
    'random': {
      $seconds = fqdn_rand(60000) / 1000
      $sleepcmd = "sleep ${seconds};"
    }
    undef: {
      $sleepcmd = ''
    }
    default: {
      $sleepcmd = "sleep ${sleep};"
    }
  }

  case $minute {
    'random': {
      $min1 = fqdn_rand(30)
      $min2 = $min1 + 30
      $minutes = [$min1, $min2]
    }
    default: {
      $minutes = $minute
    }
  }

  $croncommand =  $command ? {
    undef   => "${sleepcmd} puppet agent --onetime",
    default => "${sleepcmd}${command}",
  }

  cron {'puppet_cron_client':
    ensure   => $ensure,
    user     => $user,
    command  => $croncommand,
    minute   => $minutes,
    hour     => $hour,
    month    => $month,
    monthday => $monthday,
    weekday  => $weekday,
  }

}


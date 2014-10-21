default['asterisk']['install_method'] = 'source'

# Ownership / run-as user
default['asterisk']['user']   = 'asterisk'
default['asterisk']['group']  = 'asterisk'

default['asterisk']['prefix']['bin']    = '/usr'
default['asterisk']['prefix']['conf']   = '/etc'
default['asterisk']['prefix']['state']  = '/var'
default['asterisk']['prefix']['keys']   = "#{default['asterisk']['prefix']['conf']}/asterisk/keys"

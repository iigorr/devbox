require 'yaml'

yml = YAML.load_file 'private/user.yml'

  username = 'vagrant'
  password = '$6$aqzOtgCM$OxgoMP4JoqMJ1U1F3MZPo2iBefDRnRCXSfgIM36E5cfMNcE7GcNtH1P/tTC2QY3sX3BxxJ7r/9ciScIVTa55l0'
  public_key = ''

  if yml.has_key?('username')
    username = yml['username']
  end

  if yml.has_key?('password')
    password = yml['password']
  end

  if yml.has_key?('public_key')
    public_key = yml['public_key']
  end

  if yml.has_key?('aws')
    if yml['aws'].has_key?('id')
      aws_id = yml['aws']['id']
    end
    if yml['aws'].has_key?('key')
      aws_key = yml['aws']['key']
    end
  end

Vagrant.configure("2") do |config|

  config.vm.box = 'box'
  config.vm.host_name = 'box.dev'
  config.vm.box_url = 'http://files.vagrantup.com/precise64.box'

  config.vm.network :forwarded_port, guest: 80, host: 80

  config.vm.network :forwarded_port, guest: 137, host: 137 # Windows Shares
  config.vm.network :forwarded_port, guest: 138, host: 138 # Windows Shares
  config.vm.network :forwarded_port, guest: 139, host: 139 # Windows Shares
  config.vm.network :forwarded_port, guest: 445, host: 445 # Windows Shares

  config.ssh.forward_agent = false

  config.vm.provision  :puppet do  |puppet|
    puppet.manifests_path = 'puppet/vagrant-manifests'
    puppet.manifest_file = 'base.pp'
    puppet.module_path  = 'puppet/modules'
    puppet.facter = { 
      'fqdn'       => 'box.dev',
      'username'   => username,
      'password'   => password,
      'public_key' => public_key,
      'aws_id'     => aws_id,
      'aws_key'    => aws_key,
    }
  end

end

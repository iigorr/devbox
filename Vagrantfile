require 'yaml'

username = 'vagrant'
password = '$6$aqzOtgCM$OxgoMP4JoqMJ1U1F3MZPo2iBefDRnRCXSfgIM36E5cfMNcE7GcNtH1P/tTC2QY3sX3BxxJ7r/9ciScIVTa55l0'
public_key = ''

if File.exists? ('private/user.yml')
  yml = YAML.load_file 'private/user.yml'

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
end

Vagrant.configure("2") do |config|

  config.vm.box = 'thebox'
  config.vm.host_name = 'box.dev'
  config.vm.box_url = 'https://www.dropbox.com/s/23gupgb0xompvkm/Wheezy64.box?dl=1'

  config.vm.network "private_network", ip: "192.168.23.23"

  # config.vm.network :forwarded_port, guest: 80, host: 80
  # config.vm.network :forwarded_port, guest: 8080, host: 8080
  # config.vm.network :forwarded_port, guest: 8081, host: 8081
  # config.vm.network :forwarded_port, guest: 9200, host: 9200
  # config.vm.network :forwarded_port, guest: 9300, host: 9300


  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

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

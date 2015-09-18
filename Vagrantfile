maindisk = 'maindisk.vdi'
volatile = 'volatile.vdi'

Vagrant.configure("2") do |config|
  config.vm.box = "debian/jessie64"

  diskExists = File.exist?(maindisk)

  config.vm.provider "virtualbox" do |v|
    v.name = "TestingDebian"
    v.memory = 1024
    v.cpus = 2

    if ! diskExists
      v.customize ['storagectl', :id, '--name', 'SataController', '--add', "sata", '--controller', 'IntelAhci', '--sataportcount', 2, '--hostiocache', 'on', '--bootable', 'off']
    end

    if ! diskExists
      v.customize ['createhd', '--filename', maindisk, '--size', 50 * 1024]
    end
    v.customize ['storageattach', :id, '--storagectl', 'SataController', '--port', 0, '--device', 0, '--type', 'hdd', '--medium', maindisk]

    if ! diskExists
      v.customize ['createhd', '--filename', volatile, '--size', 20 * 1024]
    end
    v.customize ['storageattach', :id, '--storagectl', 'SataController', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', volatile]
  end

  if ! diskExists
    config.vm.provision :shell, path: "bootstrap_disks.sh"
  end

end
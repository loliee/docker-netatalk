require 'serverspec'
require 'docker'

describe 'Dockerfile' do
  image = Docker::Image.build_from_dir(".")
  set :os, family: :debian
  set :backend, :docker
  set :docker_image, image.id

  describe command('/usr/sbin/netatalk -v') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /3.1.11/ }
  end
end

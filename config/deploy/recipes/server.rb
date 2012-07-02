Capistrano::Configuration.instance(:must_exist).load do
  desc "Remote console"
  task :console, :roles => :worker do
    input = ''
    run "cd #{current_path} && rails console #{rails_env}" do
      |channel, stream, data|
      next if data.chomp == input.chomp || data.chomp == ''
      print data
      channel.send_data(input = $stdin.gets) if data =~ /^(>|\?)>/
    end
  end
end
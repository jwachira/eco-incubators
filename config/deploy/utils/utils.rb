def upload_string(string, location, options={})
  require 'tempfile'
  temp_file = Tempfile.new('deploy_tmp', 'tmp')
  file = File.new(temp_file.path, "w+")
  file.puts(string)
  file.close
  if !options.empty?
    upload file.path, location, options
  else
    upload file.path, location
  end
end

# This method is to help format messages to the user in a more recognizable way
# perhaps there is a way to make this more salient...?!
def alert_user(message, options={})
  abort = options.delete(:abort) || false
  wrapped_message = <<-EOF
  \n\n
  *******************************************************************\n
    #{message} \n
  *******************************************************************
  \n\n
  EOF
  
  if abort
    abort(wrapped_message)
  else
    puts wrapped_message
  end
end

# There should be a cleaner way, but this works for now
# symlinking remote directories that exist cause the symlink to fail
# these directories should not be checked into git - we use this method
# to check for them
def remote_dir_exists?(path, raise_me=0)
  file_exists = false
  run "ls #{path}" do |ch, stream, data|
    if stream == :err
      alert_user("captured output on STDERR while checking if remote directory exist file: #{data}", :abort => true)
    elsif stream == :out
      file_exists = ! data =~ /No such file or directory/
      if raise_me == 1
        raise "#{ch} -- #{stream} -- #{data} -- #{file_exists}"
      end
    end
  end
  return file_exists
end
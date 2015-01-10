repos = "aur".split

task :default => [:prepare, :source]

task :pull do
  puts "Pulling Repository"
  `git pull`
  `git submodule foreach git pull`
end

task :prepare => :pull do
  repos.each do |r|
    Dir["#{r}/*.sh"].each do |s|
      puts "Executing #{s}"
      `#{s}`
    end
  end
end

task :source do
  repos.each do |r|
    Dir["#{r}/*/"].each do |pack|
      Dir.chdir(pack) do
	puts "Creating Source Package for #{pack}"
	`makepkg --source`
      end
    end
  end
end

task :clean do
  puts "Cleaning the Repository"
  `git clean -f -d -x`
end
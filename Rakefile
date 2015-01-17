repos = "aur".split

task :default => [:prepare, :source]

task :pull do
  puts "Pulling Repository"
  `git pull`
  `git submodule foreach git reset --hard HEAD`
  `git submodule foreach git pull`
end

task :prepare => :pull do
  repos.each do |r|
    Dir["#{r}/*.sh"].each do |s|
      puts "Executing #{s}"
      `#{s}` unless Dir.exist? s[0..-4]
    end
    Dir["#{r}/*.patch"].each do |p|
      Dir.chdir(p[0..-7]) do
        puts "Patching #{File.basename p}"
        `patch -p1 < ../#{File.basename p}`
        `updpkgsums`
      end
    end
  end
end

task :source do
  repos.each do |r|
    Dir["#{r}/*/"].each do |pack|
      Dir.chdir(pack) do
	puts "Creating Source Package for #{pack}"
	`makepkg -f --source --skippgpcheck`
      end
    end
  end
end

task :build do
  repos.each do |r|
    Dir["#{r}/*/"].each do |pack|
      Dir.chdir(pack) do
	puts "Building Package for #{pack}"
	`makepkg -c -f --skippgpcheck`
      end
    end
  end
end

task :clean do
  puts "Cleaning the Repository"
  `git clean -f -d -x`
end

namespace :dev do

  desc "Use watchr to automatically run spec"
  task :watchr do
    system("bundle exec watchr script/watchr.rb")
  end

end

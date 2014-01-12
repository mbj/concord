require 'devtools'
Devtools.init_rake_tasks

Rake.application.load_imports
task('metrics:mutant').clear

namespace :metrics do
  task :mutant => :coverage do
    $stderr.puts 'Concord is a dependency of mutant and zombification is currently defunkt :('
  end
end

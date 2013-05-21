require 'devtools'
Devtools.init_rake_tasks

class Rake::Task
  def overwrite(&block)
    @actions.clear
    enhance(&block)
  end
end

Rake.application.load_imports

begin
  require 'mutant'
rescue LoadError
end

mutant_present = defined?(Mutant)

allowed_versions = %w(mri-1.9.3 rbx-1.9.3)

if allowed_versions.include?(Devtools.rvm) and mutant_present and !ENV['DEVTOOLS_SELF']
  Rake::Task['metrics:mutant'].overwrite do
    status = Mutant::CLI.run(%W(--rspec-full -r ./spec/spec_helper.rb ::Concord))
    unless status.zero?
      fail "Not mutation covered :("
    end
  end
end

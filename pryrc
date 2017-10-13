Pry.config.prompt_name = File.basename(Dir.pwd)
Pry.config.color = true
Pry.config.theme = "velina"
Pry.config.editor = 'vim'
Pry.editor = 'vim'

# These colors are optimized for use with Solarized scheme for your terminal
Pry.config.ls.separator = "\n"
Pry.config.ls.heading_color = :magenta
Pry.config.ls.public_method_color = :green
Pry.config.ls.protected_method_color = :yellow
Pry.config.ls.private_method_color = :bright_black

# setup for custom prompt
def nest_level(level)
  black = "\e[30m"
  bold = "\e[1m"
  normal = "\e[0m"
  level == 0 ? '' : " #{black + bold}#{level}#{normal}"
end

def custom_prompt(symbol, rails_root, rails_env_prompt, obj, level)
  black, green, blue, magenta, cyan = "\e[30m", "\e[32m", "\e[34m", "\e[35m", "\e[36m"
  normal, bold = "\e[0m", "\e[1m"

  repo = "#{magenta}#{rails_root}" if rails_root
  dev_prompt = "#{black}[#{bold + green}#{rails_env_prompt}#{normal + black}]" if rails_env_prompt
  object_and_level = " #{blue}(#{obj}#{nest_level(level)} )" unless rails_env_prompt

  "#{repo}#{dev_prompt}#{object_and_level} #{blue}#{symbol} #{normal}"
end

require 'rubygems' unless defined?(Gem) # rubygems is only needed in 1.8

def unbundled_require(gem)
  loaded = false

  if defined?(::Bundler)
    Gem.path.each do |gems_path|
      gem_path = Dir.glob("#{gems_path}/gems/#{gem}*").last
      unless gem_path.nil?
        $LOAD_PATH << "#{gem_path}/lib"
        require gem
        loaded = true
      end
    end
  else
    require gem
    loaded = true
  end

  raise(LoadError, "couldn't find #{gem}") unless loaded

  loaded
end

def load_gem(gem, &block)
  begin
    if unbundled_require gem
      yield if block_given?
    end
  rescue Exception => err
    warn "Couldn't load #{gem}: #{err}"
  end
end


# wrap ANSI codes so Readline knows where the prompt ends
def pry_color(name, text)
  if Pry.color
    "#{Pry::Helpers::Text.send name, '{text}'}".sub '{text}', "#{text}"
  else
    text
  end
end


##### CUSTOM PROMPT ###############################################################
Pry.prompt = [
  proc { |obj, level, _| custom_prompt('»', nil, nil, obj, level) },
  proc { |obj, level, _| custom_prompt('·', nil, nil, obj, level) }
]


##### STARTUP HOOKS ###############################################################
org_logger_active_record = nil
org_logger_rails = nil
Pry.hooks.add_hook :before_session, :rails do |output, target, pry|
  # show ActiveRecord SQL queries in the console
  if defined? ActiveRecord
    org_logger_active_record = ActiveRecord::Base.logger
    ActiveRecord::Base.logger = Logger.new STDOUT
  end

  if defined?(Rails) && Rails.env
    # output all other log info such as deprecation warnings to the console
    if Rails.respond_to?(:logger=)
      org_logger_rails = Rails.logger
      Rails.logger = Logger.new STDOUT
    end

    # load Rails console commands
    if Rails::VERSION::MAJOR >= 3
      require 'rails/console/app'
      require 'rails/console/helpers'
      extend Rails::ConsoleMethods if Rails.const_defined?(:ConsoleMethods)
    else
      require 'console_app'
      require 'console_with_helpers'
    end
  end
end

Pry.hooks.add_hook :after_session, :rails do |output, target, pry|
  ActiveRecord::Base.logger = org_logger_active_record if org_logger_active_record
  Rails.logger = org_logger_rails if org_logger_rails
end


# Launch Pry with access to the entire Rails stack
rails = File.join(Dir.getwd, 'config', 'environment.rb')

if File.exist?(rails) && ENV['SKIP_RAILS'].nil?

  # Rails pry prompt
  env = ENV['RAILS_ENV'] || Rails.env
  rails_root = File.basename(Dir.pwd)

  rails_env_prompt = case env
    when 'development' then 'DEV'
    when 'production' then 'PROD'
    else "#{env.upcase}"
  end

  Pry.config.prompt = [
    proc { |obj, level, _| custom_prompt('»', rails_root, rails_env_prompt, obj, level) },
    proc { |obj, level, _| custom_prompt('·', rails_root, rails_env_prompt, obj, level) }
  ]

  # [] acts as find()
  ActiveRecord::Base.instance_eval { alias :[] :find } if defined?(ActiveRecord)

  # Add Rails console helpers (like `reload!`) to pry
  if defined?(Rails::ConsoleMethods)
    extend Rails::ConsoleMethods
  end

  # r! to reload Rails console
  def r!
    reload!
  end

  # sql for arbitrary SQL commands through the AR
  def sql(query)
    ActiveRecord::Base.connection.execute(query)
  end

  # set logging to screen
  if ENV.include?('RAILS_ENV')
    # Rails 2.x
    if !Object.const_defined?('RAILS_DEFAULT_LOGGER')
      require 'logger'
      Object.const_set('RAILS_DEFAULT_LOGGER', Logger.new(STDOUT))
    end
  else
    # Rails 3
    if Rails.logger and defined?(ActiveRecord)
      Rails.logger = Logger.new(STDOUT)
      ActiveRecord::Base.logger = Rails.logger
    end
  end

  # returns a collection of the methods that Rails added to the given class
  class Class
    def core_ext
      self.instance_methods
          .map    { |m| [m, self.instance_method(m).source_location] }
          .select { |m| m[1] && m[1][0] =~/activesupport/ }
          .map    { |m| m[0] }.sort
    end
  end

end

# local methods helper
class Object
  def _local_methods(class_name)
    self.public_methods - class_name.public_methods
  end

  def local_methods
    case self.class
    when Class  then _local_methods(Class)
    when Module then _local_methods(Module)
    else _local_methods(Object)
    end
  end
end

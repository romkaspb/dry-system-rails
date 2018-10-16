# frozen_string_literal: true

module Dry
  module System
    module Rails
      module Resolver
        CORE_FOLDER = "app/".freeze
        DEFAULT_RESOLVER = ->(k) { k.new }

        def lib_folder!(folder)
          @lib_folder = folder
          @lib_folder = "#{@lib_folder}/" unless @lib_folder.end_with?('/')
        end

        def register_folder!(folder, resolver: DEFAULT_RESOLVER)
          all_files_in_folder(folder).each do |file|
            register_file(file, resolver)
          end
        end

        def register_file!(file, resolver: DEFAULT_RESOLVER)
          register_file(find_file(file), resolver)
        end

        private

        def lib_folder
          @lib_folder
        end

        def find_file(file)
          Dir.chdir(::Rails.root) do
            Dir.glob("#{CORE_FOLDER}#{lib_folder}#{file}.rb")
               .map! { |file_name| file_name.sub('.rb', '').to_s }.first
          end
        end

        def all_files_in_folder(folder)
          Dir.chdir(::Rails.root) do
            Dir.glob("#{CORE_FOLDER}#{lib_folder}#{folder}/**/*.rb")
               .map! { |file_name| file_name.sub('.rb', '').to_s }
          end
        end

        def register_file(file, resolver)
          register_name = file.sub(lib_folder, '').sub(CORE_FOLDER, '').tr('/', '.')
          register(register_name, memoize: true) { load! file, resolver }
        end

        def load!(path, resolver)
          load_file!(path)

          right_path = path.sub(lib_folder, '').sub(CORE_FOLDER, '')
          resolver.call(Object.const_get(Dry::Inflector.new.camelize(right_path)))
        end

        def load_file!(path)
          require_relative "#{::Rails.root}/#{path}"
        end
      end
    end
  end
end

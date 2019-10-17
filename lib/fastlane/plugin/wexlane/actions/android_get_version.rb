require 'fastlane/action'
require_relative '../helper/wexlane_helper'

module Fastlane
  module Actions
    class AndroidGetVersionAction < Action
      def self.run(params)
        path = params[:gradle_path]#{}"app/build.gradle"
        version_name = "0"
          if !File.file?(path)
              UI.message(" -> No file exist at path: (#{path})!")
              return version_name
          end
          begin
              file = File.new(path, "r")
              while (line = file.gets)
                  if line.include? "versionName"
                     versionComponents = line.strip.split(' ')
                     version_name = versionComponents[versionComponents.length - 1].tr("\"","")
                     break
                  end
              end
              file.close
          rescue => err
              UI.error("An exception occured while readinf gradle file: #{err}")
              err
          end
          return version_name
        UI.message("The wexlane plugin is working!")
      end

      def self.description
        "Common tools for CI"
      end

      def self.authors
        ["Chris River"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "Dependencies shared between all WEX mobile projects"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :gradle_path,
                                  env_name: "WEXLANE_GRADLE_PATH",
                               description: "Path to the gradle file",
                                  optional: false,
                                      type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end

    end
  end
end

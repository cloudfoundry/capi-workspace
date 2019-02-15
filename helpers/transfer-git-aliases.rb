#!/usr/bin/env ruby

# Transfer only sections from the capi-workspace-managed gitconfig
# Leave the other parts in place for OSS contributors.

require 'inifile'

source_path = ARGV[0]
target_path = ARGV[1]

source = IniFile.load(source_path, force_array: true)
target = IniFile.load(target_path, force_array: true)

source.sections.each do |section_name|
  target[section_name] = source[section_name]
end
target.write

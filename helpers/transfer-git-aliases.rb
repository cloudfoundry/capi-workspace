#!/usr/bin/env ruby

# Transfer only sections from the capi-workspace-managed gitconfig
# Leave the other parts in place for OSS contributors.

require 'inifile'

source_path = ARGV[0]
target_path = ARGV[1]

source = IniFile.load(source_path)
target = IniFile.load(target_path)

source.sections.each do |section_name|
  target[section_name] = source[section_name]
end
target.write

# The iniFile library treats .ini files as pure hashes, where the last key wins.
# We need to cheat with the pushInsteadOf setting.  AFAIK, there are no other
# duplicated keys.  But if there are, the following code should be generalized.  
# YAGNI at this time.

# Patch the target if the source has multiple pushInsteadOf lines

pushInsteadSourceLines = IO.readlines(source_path).grep(/pushInsteadOf\s*=/).map(&:strip)
if pushInsteadSourceLines.size == 2
  targetLines = IO.readlines(target_path)
  idx0 = targetLines.find_index {|x| x[pushInsteadSourceLines[0]] }
  idx1 = targetLines.find_index {|x| x[pushInsteadSourceLines[1]] }
  if idx0 && idx1
    puts "No further change needed"
  else
    if idx0
      pivot = idx0
      sourceIndex = 1
    else
      pivot = idx1
      sourceIndex = 0
    end
    fixedTargetLines = targetLines[0..pivot] + [pushInsteadSourceLines[sourceIndex] + "\n"] + targetLines[pivot + 1..-1]
    File.open(target_path, 'w'){ |fd| fd.write(fixedTargetLines.join("")) }
  end
end
    
  

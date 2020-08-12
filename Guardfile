guard :minitest, spring: 'bin/rails test', all_on_start: false do
  watch(%r{^test/.+_test\.rb$})
  watch(%r{^app/(.+)\.rb$})        { |m| "test/#{m[1]}_test.rb" }
end

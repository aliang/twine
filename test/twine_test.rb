require 'test/unit'
require 'twine'

class TwineTest < Test::Unit::TestCase
  def test_generate_string_file_1
    Dir.mktmpdir do |dir|
      output_path = File.join(dir, 'fr.xml')
      Twine::Runner.run(%W(generate-string-file test/fixtures/strings-1.txt #{output_path}))
      assert_equal(File.read('test/fixtures/test-output-1.txt'), File.read(output_path))
    end
  end

  def test_generate_string_file_2
    Dir.mktmpdir do |dir|
      output_path = File.join(dir, 'en.strings')
      Twine::Runner.run(%W(generate-string-file test/fixtures/strings-1.txt #{output_path} -t tag1))
      assert_equal(File.read('test/fixtures/test-output-2.txt'), File.read(output_path))
    end
  end

  def test_consume_string_file_1
    Dir.mktmpdir do |dir|
      output_path = File.join(dir, 'strings.txt')
      Twine::Runner.run(%W(consume-string-file test/fixtures/strings-1.txt test/fixtures/fr-1.xml -o #{output_path} -l fr))
      assert_equal(File.read('test/fixtures/test-output-3.txt'), File.read(output_path))
    end
  end

  def test_consume_string_file_2
    Dir.mktmpdir do |dir|
      output_path = File.join(dir, 'strings.txt')
      Twine::Runner.run(%W(consume-string-file test/fixtures/strings-1.txt test/fixtures/en-1.strings -o #{output_path} -l en -a))
      assert_equal(File.read('test/fixtures/test-output-4.txt'), File.read(output_path))
    end
  end
  
  def test_generate_report_1
    Twine::Runner.run(%w(generate-report test/fixtures/strings-1.txt))
  end
end

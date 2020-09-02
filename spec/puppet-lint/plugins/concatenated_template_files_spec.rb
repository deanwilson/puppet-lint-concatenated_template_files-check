require 'spec_helper'

describe 'concatenated_template_files' do
  let(:msg) { 'calling "template" with multiple files concatenates them into a single string' }

  context 'when the manifest has no file resources' do
    let(:code) do
      <<-TEST_CLASS
        class no_file_resource {
          host { 'syslog':
            ip => '10.10.10.10',
          }
        }
      TEST_CLASS
    end

    it 'does not detect any problems' do
      expect(problems).to have(0).problems
    end
  end

  context 'with file resource but no template call' do
    context 'when the template has a relative module path' do
      let(:code) do
        <<-TEST_CLASS
          class template_tester {
            file { '/tmp/template':
              content => 'A static string',
            }
          }
        TEST_CLASS
      end

      it 'detects no problems' do
        expect(problems).to have(0).problems
      end
    end
  end

  context 'when template function is passed one filename' do
    let(:code) do
      <<-TEST_CLASS
        class single_templated_file {
          file { '/tmp/templated':
            content => template('mymodule/single_file.erb'),
          }
        }
      TEST_CLASS
    end

    it 'does not detect any problems' do
      expect(problems).to have(0).problems
    end
  end

  context 'when template function is passed multiple filenames' do
    let(:code) do
      <<-TEST_CLASS
        class multi_templated_file {
          file { '/tmp/templated':
            content => template('mymodule/first_file.erb', 'mymodule/second_file.erb'),
          }
        }
      TEST_CLASS
    end

    it 'detects a single problem' do
      expect(problems).to have(1).problem
    end

    it 'creates a warning' do
      expect(problems).to contain_warning(msg).on_line(3).in_column(24)
    end
  end
end

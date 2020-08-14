require 'spec_helper'

describe 'concatenated_template_files' do
  let(:msg) { 'calling "template" with multiple files concatenates them into a single string' }

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

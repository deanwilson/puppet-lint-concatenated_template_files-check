require 'spec_helper'

describe 'concatenated_template_files' do
  let(:msg) { 'calling "template" with multiple files concatenates them into a single string' }

  context 'template function with one filename' do
    let(:code) do
      <<-EOS
        class single_templated_file {
          file { '/tmp/templated':
            content => template('mymodule/single_file.erb'),
          }
        }
      EOS
    end

    it 'should not detect any problems' do
      expect(problems).to have(0).problems
    end
  end


  context 'template function with multiple filenames' do
    let(:code) do
      <<-EOS
        class multi_templated_file {
          file { '/tmp/templated':
            content => template('mymodule/first_file.erb', 'mymodule/second_file.erb'),
          }
        }
      EOS
    end

    it 'should detect a single problem' do
      expect(problems).to have(1).problem
    end

    it 'should create a warning' do
      expect(problems).to contain_warning(msg).on_line(3).in_column(24)
    end

  end
end


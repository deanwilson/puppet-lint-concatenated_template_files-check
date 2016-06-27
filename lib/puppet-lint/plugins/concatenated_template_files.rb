PuppetLint.new_check(:concatenated_template_files) do

  def check
    resource_indexes.each do |resource|
      if resource[:type].value == 'file'
        resource[:param_tokens].select { |param_token|
          param_token.value == 'content'
        }.each do |content_token|

          value_token = content_token.next_code_token.next_code_token

          if value_token.value == 'template'

            file_names = []

            current_token = value_token.next_token
            until current_token.type == :RPAREN
              current_token = current_token.next_code_token
              file_names << current_token.value if current_token.type == :SSTRING
            end

            if file_names.length > 1

              warning = 'calling "template" with multiple files concatenates them into a single string'

              notify :warning, {
                :message     => warning,
                :line        => value_token.line,
                :column      => value_token.column,
                :param_token => content_token,
                :value_token => value_token,
              }
            end
          end
        end
      end
    end
  end
end

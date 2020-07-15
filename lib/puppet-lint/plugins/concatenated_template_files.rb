PuppetLint.new_check(:concatenated_template_files) do
  def check
    resource_indexes.each do |resource|
      next unless resource[:type].value == 'file'

      content_tokens = resource[:param_tokens].select { |pt| pt.value == 'content' }

      content_tokens.each do |content_token|
        value_token = content_token.next_code_token.next_code_token

        next unless value_token.value == 'template'

        file_names = []

        current_token = value_token.next_token
        until current_token.type == :RPAREN
          current_token = current_token.next_code_token
          file_names << current_token.value if current_token.type == :SSTRING
        end

        next unless file_names.length > 1

        warning = 'calling "template" with multiple files concatenates them into a single string'

        notify :warning, {
          message:     warning,
          line:        value_token.line,
          column:      value_token.column,
          param_token: content_token,
          value_token: value_token,
        }
      end
    end
  end
end

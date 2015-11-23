require 'redcarpet'
require 'action_view'
# require File.dirname(__FILE__) + '/markdown_checkboxes/data_struct'

class CheckboxMarkdown < Redcarpet::Render::HTML
  include ActionView::Helpers::FormTagHelper
  CHECKBOX_REGEX = /<li>\s*\[(x|X|\s)?\]/

  VERSION = '2.0.0'

  def postprocess(text)
    text.gsub(CHECKBOX_REGEX).with_index do |_, current_index|
      checkbox_content = Regexp.last_match[1]
      checked = checkbox_content =~ /x|X/ ? true : false

      '<li class="task-list-item">' +
        check_box_tag("check_#{current_index}", '', checked, disabled: true)
    end
  end
end

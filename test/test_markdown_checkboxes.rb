require 'test/unit'
require File.dirname(__FILE__) + '/../lib/markdown_checkboxes'

class MarkdownCheckboxesTest < Test::Unit::TestCase
  def setup
    @m ||= Redcarpet::Markdown.new(CheckboxMarkdown.new)
  end

  def test_html_not_escaped
    m_escape_html = Redcarpet::Markdown.new(CheckboxMarkdown.new(escape_html: true))
    assert_match %r{<input.* />}, m_escape_html.render("<script>alert('bad!')</script>\n\n- [ ]")
  end

  def test_standard_markdown
    assert_equal @m.render("## Hello"), "<h2>Hello</h2>\n"
    assert_equal @m.render("**Bold**"), "<p><strong>Bold</strong></p>\n"
  end

  def test_checkbox_existence
    assert_match /<input.* \/>/,    @m.render("- [ ]")
    assert_match /type="checkbox"/, @m.render("- [ ]")
  end

  def test_checkbox_check_attribute
    assert_match /checked="checked"/,     @m.render("- [x]")
    assert_no_match /checked="checked"/,  @m.render("- [ ]")
  end

  def test_checkbox_list_item_class
    assert_match(/class="task-list-item"/, @m.render('- [x]'))
  end

  def test_checkbox_data_setting
    # assert_match(/data-remote="true"/,
    #   @m.render("- [ ]") do |data, updated_text|
    #     data.remote = true
    #   end
    # )
    #
    # assert_match(/data-method="put"/,
    #   @m.render("- [x]") do |data, updated_text|
    #     data.remote = true
    #     data.method = :put
    #   end
    # )
  end
end

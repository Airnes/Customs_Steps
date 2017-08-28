class Steps

  def scroll_to_element(label)
    wait_poll({:timeout_message => "There's no '#{label}' on screen. Tired of scrolling. Will go drink some coffee'",
               :until_exists => "label text:'#{label}'",
               :timeout => 3}) do
      scroll("tableView", :down)
    end
  end

  def wait_to_see_text_containing(text)
    wait_for(:timeout => 20) { element_exists("view {text LIKE '*#{text}*'}") }
  end

  def swipe_with_no_delta(direction)
    #up, down, left, right
    swipe :"#{direction}", swipe_opt = {:'swipe-delta' => {} }
    wait_for_none_animating
  end

  def check_ios_version
    server_version['iOS_version'].to_i
  end

  def is_disabled(button)
    check_element_exists("button marked:'#{button}' isEnabled:0")
  end

  def is_enabled(button)
    check_element_exists("button marked:'#{button}' isEnabled:1")
  end

  def check_focus_in_field(field)
    check_element_exists("view:'UIResponder' isFirstResponder:1 placeholder:'#{field}'")
  end

  def is_keyboard_presented
    res = element_exists("keyboardAutomatic")
    if res.empty?
      screenshot_and_raise("Keyboard is not presented")
    end
  end

  def hide_keyboard
    query("view isFirstResponder:1", :resignFirstResponder)
  end

  def check_ui_element_label(ui_element, label)
    query ("#{ui_element} marked:'#{label}'")
  end

  def touch_ui_element_text(ui_element, text)
    touch ("#{ui_element} marked:'#{text}'")
  end

  def wait_for_ui_element_text(ui_element, text)
    wait_for_element_exists ("#{ui_element} marked:'#{text}'")
  end

  def count_number_ui_elements(ui_element)
    query("#{ui_element}").count
  end

  #workaround for situation when touching input field is required
  def enter_text_to_field(text, field)
    puts "I'm going to touch #{field} label"
    field.to_s.start_with?("UI") ? touch("#{field}") : touch("* marked:'#{field}'")
    wait_for_keyboard
    keyboard_enter_text text
  end

end
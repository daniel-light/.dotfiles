require 'tk'

module Pomo
  module TkWidgets
    DEFAULTS = {
      'padx' => 10,
      'pady' => 10,
    }.freeze

    def comment_input_form(on_data_entry)
      @comment_input_form_raw = TkVariable.new

      entry = TkEntry.new(top, 'textvariable' => @comment_input_form_raw)
      entry.pack(DEFAULTS)

      TkButton.new(top) do
        text 'Enter data'
        command { on_data_entry.call }
        pack DEFAULTS
      end
    end

  end

  # A popup for recording pomo completion
  class Popup
    include TkWidgets

    def initialize(&data_entry_callback)
      on_data_entry = proc do
        puts 'hey'
        comment_text = @comment_input_form_raw.value
        data_entry_callback.call(comment_text)
      end

      root = TkRoot.new { title 'POMO' }
      top = TkFrame.new(root)
      TkLabel.new(top) do
        text 'Enter Text: '
        pack DEFAULTS
      end

      comment_input_form(on_data_entry)

      TkButton.new(top) do
        text 'Cancel'
        command { exit }
        pack DEFAULTS
      end

      top.pack('fill' => 'both', 'side' => 'top')
    end

    def run
      Tk.mainloop
    end
  end
end

P = Pomo::Popup

P.new { |comment| puts comment }.run if $PROGRAM_NAME == __FILE__

class PdfReport
  include Prawn::View

  def initialize
    @now = Date.today
    font 'Helvetica'
    font_size 10
  end

  def consumer=(consumer: {}, user: {})
    @consumer = consumer
    @user = user
  end

  def header_and_footer(title, &block)
    document.repeat(:all, :dynamic => true) do
      # header
      reference_table = make_table([
        [ Cell.text('Datum:').align_left,          Cell.text(@now.to_s).align_right ],
        [ Cell.text('Your reference:').align_left, Cell.text(@user[:name]).align_right ],
        [ Cell.text('Our reference:').align_left,  Cell.text("#{@consumer[:id]}/#{@user[:id]}").align_right ]
      ],  Cell.no_borders.small.padding(0, 0, 2, 0).in_table.column_widths(0 => 70, 1 => 130) )

      bounding_box [bounds.left, bounds.top], :width  => bounds.width do
        table([
          [ Cell.text(title).h1.align_left.vertical_align_center, reference_table]
        ], Cell.no_borders.align_left.padding(0, 0).in_table.column_widths(0 => 338, 1 => 200) )
        stroke_horizontal_rule
      end

      # footer
      bounding_box [bounds.left, bounds.bottom + 25], :width  => bounds.width do
        stroke_horizontal_rule
        move_down(5)
        text "This report is generated for the exclusive use of #{@consumer[:name]} - #{@user[:name]}", Text.tiny
        text "Page #{page_number} of #{page_count}", Text.tiny
      end
    end

    # set default bounding box outside the header and footer text
    document.bounding_box([bounds.left, bounds.top - 50], :width  => bounds.width, :height => bounds.height - 100, &block)
  end

  class Text < Hash

    def align_right
      self[:align] = :right
      self
    end
    def self.align_right
      Text.new.align_right
    end

    def align_left
      self[:align] = :left
      self
    end
    def self.align_left
      Text.new.align_left
    end

    def vertical_align_center
      self[:valign] = :center
      self
    end
    def self.vertical_align_center
      Text.new.vertical_align_center
    end

    def h1
      self[:size] = 14
      self
    end
    def self.h1
      Text.new.h1
    end

    def small
      self[:size] = 8
      self
    end
    def self.small
      Text.new.small
    end

    def tiny
      self[:size] = 6
      self
    end
    def self.tiny
      Text.new.tiny
    end

  end

  class Cell < Text

    def text(text)
      self[:content] = text
      self
    end
    def self.text(text)
      Cell.new.text(text)
    end

    def no_borders
      self[:borders] = []
      self
    end
    def self.no_borders
      Cell.new.no_borders
    end

    def padding(top, right, bottom = top, left = right)
      self[:padding] = [top, right, bottom, left]
      self
    end
    def self.padding(top, right, bottom = top, left = right)
      Cell.new.padding(top, right, bottom, left)
    end

    def width(document, percentage)
      self[:width] = document.bounds.width.to_f / 100 * percentage
      self
    end
    def self.width(document, percentage)
      Cell.new.full_width(document)
    end

    def in_table
      table = Table.new
      table[:cell_style] = self
      table
    end

  end

  class Table < Hash

    def column_widths(widths)
      self[:column_widths] = widths
      self
    end
  end

end

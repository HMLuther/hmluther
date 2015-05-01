require "open-uri"

class CollectionPdf < Prawn::Document

  def initialize(collection, view)
    super(top_margin: 70)
    @collection = collection
    @view = view
    @color_orange = "f47321"
    default_leading 5
    stroke_color "e5e5e5"
    collection_info
    # collection_items
    pdf_merge
    # tearsheet_images
    # footer
  end

  def collection_info
  	self.header
  	move_down 20
    text "Collection: #{@collection.name}", size: 20, style: :bold
    move_down 10
    text @collection.description, :color => "666666"
    # self.footer
    # start_new_page
  end

  def footer
  	repeat(:all) do
  		# draw_text "FOOTER", :at => bounds.bottom_left
	  	bounding_box([0, 45], :width => 540) do
		  	stroke_horizontal_rule
	  	end
	  	bounding_box([0, 35], :width => 220) do
	  		move_down 10
		  	text "HMLUTHER.COM", :size => 20, :color => @color_orange
		  end
	  	bounding_box([220, 35], :width => 320) do
	  		move_down 3
		  	text "The Carlyle 35 East 76th Street New York City (212) 439-7919", :size => 9, :color => @color_orange
		  	line [-10,-15], [-10, 15]
		  	stroke_color "f47321"
		  	stroke
		  	move_down 5
		  	text "Greenwich Village 61 East 11th Street New York City (212) 505-1485", :size => 9, :color => @color_orange
		  end
		end
  end

  def header
    svg IO.read("#{Rails.root}/app/assets/images/HML_logo.svg"), :at => bounds.top_left
		move_down 10
		stroke_color "e5e5e5"
    stroke_horizontal_rule
    move_cursor_to 600
  end

  def pdf_merge
    pdf_file_paths = @collection.collection_items.active.map { |ci| ci.item.images.where(:image_type => 'Tearsheet').first.url }
    pdf_file_paths.each do |pdf_file|
      start_new_page(:template => open(pdf_file))
    end
  end

  def collection_items
  	@count = ( @collection.collection_items.active.count - 1 )
  	@collection.collection_items.active.each_with_index do |c, index|
 	    self.header
  		image open(c.item.images.where(image_type: "Comp Web").first.url), :width => 540, :position => :center
  		y_position = cursor - 15
  		bounding_box([0, y_position], :width => 540) do
	  		text text c.item.maker_list.map { |t| t.titlecase }.join(', '), :color => "f47321", :size => 16
	  		move_down 5
	  		text c.item.description
	  		move_down 5
	  		text c.item.circa, :color => "666666", :size => 10
	  		# move_down 5
	  		# text "Height: #{c.item.height}", :color => "666666", :size => 10
	  		move_down 5
	  		text "Item: #" + c.item.filemaker_id, :color => "666666", :size => 10
		  	if index < @count
	  			start_new_page
	  		end
	  	end
  	end
  end

  def tearsheet_images
    @count = ( @collection.collection_items.active.count - 1 )
    @collection.collection_items.active.each_with_index do |c, index|
      image open(c.item.images.where(webcomp: true).first.url), :width => 612, :position => :center
      if index < @count
        start_new_page
      end
    end
  end

end
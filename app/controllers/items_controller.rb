class ItemsController < ApplicationController

  before_action :authenticate_admin, :except => [:category, :show, :set_recently_viewed], unless: :json_request?
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_api_user, only: [:create, :edit, :update, :destroy], if: :json_request?

  before_action :store_history, only: [:show]
  before_action :find_history, only: [:category, :show, :set_recently_viewed]

  # GET /items
  # GET /items.json
  def index
      @items = Item.all
  end

  #GET /category/:category
  def category
    unless params[:archive_item].blank?
      @archive_item = Item.find_by_slug!(params[:archive_item]).decorate
    end
    @items = Item.category_list.tagged_with(params[:category]).order(size: :asc).decorate
    @items = @items.shuffle
    # impressionist(@items, "category", :unique => [:session_hash])
    # render 'category_scroll'
  end

  # GET /items/1
  # GET /items/1.json
  def show
    if !@item.active and !@item.listed_category and !@item.listed_designer
      redirect_to category_path(@item.category_list.last, archive_item: @item.filemaker_id)
     else
      # @item_images = @item.images.show_list.order('image_type')
      @item_images = @item.images.detail_images.order('position')
      impressionist(@item, "item detail")
    end
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set_recently_viewed
    respond_to do |format|
        format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find_by_slug!(params[:id]).decorate
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:active, :circa, :description, :description_short, :featured, :filemaker_id, :sold, :listed_category, :listed_designer, :location, :reference, :height_cm, :width_cm, :depth_cm, :diameter_cm, :height_in, :width_in, :depth_in, :diameter_in, :size, :category_list, :maker_list, :designer_connector_1, :designer_connector_2)
    end

    def store_history
      if @item.active
        @recent_item = @item.filemaker_id
        session[:history] ||= []
        session[:history].delete_at(0) if session[:history].size >= 50
        session[:history] << @recent_item unless session[:history].include?(@recent_item)
      end
    end

    def find_history
      @history_items = Item.where(slug: session[:history])
    end

end

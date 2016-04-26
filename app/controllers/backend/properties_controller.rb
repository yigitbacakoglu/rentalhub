module Backend
  class PropertiesController < Backend::BaseController
    before_action :authorize_user
    before_action :set_property, except: [:index, :new, :create, :show, :own]
    # GET /properties
    # GET /properties.json
    def index
      @properties = @current_user.properties.includes(:wish_lists).page(params[:page])
    end

    # GET /properties/1
    # GET /properties/1.json
    def show
      @property = Property.find params[:id]
    end

    # GET /properties/new
    def new
      @property = @current_user.properties.new
      @property.image #this builds image
    end

    # GET /properties/1/edit
    def edit
      @property.image #this builds image
    end

    def own
      @property = Property.find_by(verification_token: params[:token])
      if @property && @current_user.owner?
        @current_user.own_property(@property.id)
        flash[:success] = 'You successfully owned the property.'
        redirect_to edit_backend_property_path(@property)
      else
        flash[:errr] = 'You are not authorised to perform this action'
        redirect_to :back
      end
    end

    # POST /properties
    # POST /properties.json
    def create
      @property = @current_user.properties.new(property_params)

      respond_to do |format|
        if @property.save
          format.html { redirect_to backend_properties_url, notice: 'Property was successfully created.' }
          format.json { render :show, status: :created, location: @property }
        else
          format.html { render :new }
          format.json { render json: @property.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /properties/1
    # PATCH/PUT /properties/1.json
    def update
      respond_to do |format|
        if @property.update(property_params)
          format.html { redirect_to backend_properties_url, notice: 'Property was successfully updated.' }
          format.json { render :show, status: :ok, location: @property }
        else
          format.html { render :edit }
          format.json { render json: @property.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /properties/1
    # DELETE /properties/1.json
    def destroy
      @property.destroy
      respond_to do |format|
        format.html { redirect_to backend_properties_url, notice: 'Property was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      begin
        @property = @current_user.properties.find(params[:id])
      rescue
        flash[:warning] = 'You are not authorized to view this page'
        redirect_to backend_properties_path and return
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_params
      params.require(:property).permit(:title, :description, :owner_name, :owner_email, :owner_phone,
                                       :city, :country, :listing_type, :street1, :street2, :lat, :long, :zipcode,
                                       :user_id, :images_attributes => [:attachment, :id, :_destroy])
    end

    def authorize_user
      if @current_user.provider?
        flash[:warning] = 'You are not authorized to view this page'
        redirect_to root_path and return
      end
    end

  end
end

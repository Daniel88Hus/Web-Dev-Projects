class KittensController < ApplicationController
  
  def index
  	@kittens = Kitten.all
  	respond_to do |format|
  		format.html
  		format.json { render json: @kittens }
  	end

  end

  def show
  	@kitten = Kitten.find_by(params[:id])
  	respond_to do |format|
  		format.html
  		format.json { render json: @kitten }
  	end
  end

  def new
  	@kitten = Kitten.new
  end

  def create
  	@kitten = Kitten.new(kitten_params)
  	if @kitten.save
  		redirect_to @kitten, notice: 'Kitten created'
  	else
  		render 'new'
  	end
  end

  def edit
  	@kitten = Kitten.find_by(params[:id])
  end

  def update
  	@kitten = Kitten.find_by(params[:id])
  	if @kitten.update(kitten_params)
  		redirect_to @kitten, notice: 'Kitten updated'
  	else
  		render 'edit'
  	end
  end

  def destroy
  	@kitten = Kitten.find_by(params[:id])
  	@kitten.destroy
  	redirect_to kittens_url
  end

  private

    def kitten_params
      params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  	end
end

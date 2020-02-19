class OfficesController < ApplicationController
  def show
    @office = Office.find(params[:id])
  end
  
  def new
    @office = Office.new
  end
  
  def create
    @office = Office.new(office_params)    # 実装は終わっていないことに注意!
    if @office.save
      flash[:success] = "Your office account created successfully!"
      redirect_to @office
    else
      render 'new'
    end
  end
  
  private

    def office_params
      params.require(:office).permit(:name, :email)
    end
end

class StaticPagesController < ApplicationController

  def home
    @categories = Category.all
    @items = Item.all
  end

  def collections
   @categories = Category.all
  end

  def category
    hats = params[:cat_name]
    @items = Item.where("category like ?", hats)
  end

  def search
     st = "%#{params[:q]}%"
     @items = Item.where("title like ?", st)
  end

  def about
  end

  def contact
    
  end

  #def support
    #session[:cart] = nil #a little hack to clear cart if you make error and it refuses to clear the session and clears the error in your code
  #end
  
  def myOrder
    @user= User.find(current_user.id)
    @orders = @user.orders.all
  end

  def returns
  end
  
  #admin rules
  def admincontrol
    @users = User.all
    @orders = Order.all
  end

  def makeadmin
    @user = User.find_by(id: params[:id])
    @user.update_attribute(:admin, true)
    redirect_to "/"
    #redirect_to :controller => :"/"
  end

  def removeadmin
    @user = User.find_by(id: params[:id])
    @user.update_attribute(:admin, false)
    redirect_to "/"
    #redirect_to :controller => :"/"
  end

  def paid
    @order = Order.last
    #@order = Order.find(params[:id])
    #@order.update_attribute(:status, 'Order Paid')
    @order.update_attribute(:status, 'Paid with PayPal')
  end

end
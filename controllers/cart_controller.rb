class CartController < ApplicationController
  #before_action :authenticate_user!
  
  def index
    #build logic to pass the cart data to the view
    if session[:cart] then #check if cart exists
      @cart=session[:cart]#if the cart does exist then all the items to be displayed on the cart index page are all the items in that cart 
    else
      @cart={}#if the cart doesn't exist then set the cart to be an empty object
    end
  end 
  
  def add#find id of product to add to cart
    id=params[:id]#find id of product to cart
    if session[:cart]then#find cart to to put product in or create a new cart
      cart=session[:cart]#if exists use it
    else
      session[:cart]={}#if it does not exist then make one
      cart=session[:cart]#make the cart an empty cart at that time
    end
    #control the products in the cart
    if cart[id] then# check if product is in cart
      cart[id]=cart[id] + 1#if it is then increase quanitiy by 1
    else
      cart[id] = 1#if it was not in the cart then add one now
    end
      #send the user somewhere now that the product is added
      redirect_to :action => :index
  end
  
  def clearcart
    session[:cart] = nil
    redirect_to :action => :index
  end
    
  def remove
    id = params[:id]
    cart = session[:cart]
    cart.delete id
    redirect_to :cart
  end
    
  def decrease
    id = params[:id]
    cart = session[:cart]
    
    if cart[id] == 1 then
      cart.delete id
    else
      cart[id] = cart[id] - 1
    end
    redirect_to :action => :index
  end 
  
  def increase
    id = params[:id]
    cart = session[:cart]
    
    #cart.delete id
    cart[id] = cart[id] + 1
    
    redirect_to :action => :index
  end 
  
  def createOrder 
    # Step 1 Find user information
    @user = User.find(current_user.id)
      
    # Step 2 Make a anew order and link that order with the current user
    @order = @user.orders.build(:order_date => DateTime.now, :status => 'Pending')
    @order.save
    
    # Step three - Save each order item from the cart into the orderitems table 
    @cart = session[:cart] || {} # This gets the items from the users cart session
    
    @cart.each do | id, quantity |
    item = Item.find_by_id(id)
    
    @orderitem = @order.orderitems.build(:item_id => item.id, :title => item.title, :description => item.description, :quantity => quantity, :price => item.price)
    @orderitem.save
    end 
    
    @orders = Order.all
    @orderitems = Orderitem.where(order_id: Order.last)
    #<% @orderitems.each do |id, quantity| %>
    #redirect_to '/done'
    #redirect_to :action => :done
  end 
  
  #def done
    #@orders.limit(1).order(id: :desc).where(user: User.find(current_user.id))
    #@orderitems = Orderitem.where(order_id: Order.limit(1).order(id: :desc).where(user: User.find(current_user.id)))
    #Permission.find_by(user_id: params[:user_id], project_id: params[:project_id])
  #end
  
  #def paid
  #  redirect_to :action => :items
  #end
    
end
  
class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
      @@cart.each do |item|
        resp.write "#{item}\n"
        end
      end 
    elsif req.path.match(/add/)
      item_to_add = req.params["item"]
      if @@items.include? item_to_add
        @@cart << item_to_add
        resp.write "We added #{item_to_add} to your cart."
      else 
        resp.write "We don't have that item."
      end 
      #takes in GET parameter (??)
      #check if item is in @@items
      ## if it is in items, add to cart
      #else, give an error 

    else
      resp.write "Path Not Found"
    end

    resp.finish
  end #end of #call 

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end #end of #handle search method



end #end of class 

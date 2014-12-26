rails-shopping-cart
===================

Sample E-Commerce Application Developed with Ruby 2 and Rails 4. It's a simple web-based shopping cart application called Depot. Its uses cases are summarized as follows:
* The buyer uses Depot to browse the products available for sale, select some to purchase adding them to an ajax-powered shopping cart, and supply the information needed to create an order.
* When the buyer creates an order, Depot connects with a standalone payments gateway consuming one of its web services; receives a response, updates its database and sends an email to the customer with the result of the payment. (A basic prototype of such payment gateway is found in the <b>rails-dummy-gateway</b> repository).
* The seller uses Depot to maintain a list of products to sell, to determine the orders that are awaiting shipping, and to mark orders as shipped. When orders are shipped an email is sent to its customer. (The seller also uses Depot to make scads of money and retire to a tropical island, but that’s another story).

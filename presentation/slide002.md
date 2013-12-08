        An alternative to after callbacks and observers

        This shows how to mimic the behaviour of `ActiveRecord::Observer` callbacks. The observer is a simple PORO.

        @begin=ruby@
        # models/bid_observer.rb

        class BidObserver
          def after_create(bid)
            # ...
          end
        end

        # models/bid.rb

        class Bid < ActiveRecord::Base
          include Wisper::Publisher

          validates :amount, :presence => true

          after_create do
            broadcast(:after_create, self)
          end
        end

        # controllers/bids_controller.rb

        class BidsController < ApplicationController
          def new
            @bid = Bid.new
          end

          def create
            @bid = Bid.new(bid_params)
            @bid.subscribe(BidObserver.new)
            @bid.save
          end
        end
        @end=ruby@

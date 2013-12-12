        Using Wisper as an alternative to `ActiveRecord::Observer`

        The Observer
        @begin=ruby@
        class BidObserver
          def after_create(bid)
            # ...
          end
        end
        @end=ruby@
        The Model
        @begin=ruby@
        class Bid < ActiveRecord::Base
          include Wisper::Publisher

          belongs_to :user
          belongs_to :product

          validates :amount, :presence => true

          after_create do
            broadcast(:after_create, self)
          end
        end
        @end=ruby@
        The Controller
        @begin=ruby@
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

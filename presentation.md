# Complimenting methods and attributes with events using the Wisper gem

Kris Leech

https://github.com/krisleech
https://twitter.com/krisleech
http://teamcoding.com
http://new.teamcoding.com


# An alternative to after callbacks and observers

This shows how to mimic the behaviour of `ActiveRecord::Observer` callbacks. The observer is a simple PORO.

```ruby
# models/bid_observer.rb

class BidObserver
  def after_create(bid)
    # ...
  end
end
```

```ruby
# models/bid.rb

class Bid < ActiveRecord::Base
  include Wisper::Publisher

  validates :amount, :presence => true

  after_create do
    broadcast(:after_create, self)
  end
end
```

```ruby
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
```

Why is this better than ActiveRecord::Observer?


# Reserving seats for a conference

```haml
%h2 #{@conference.name}

= simple_form_for @reservation_form, :url => new_conference_reservations_path(@conference) do |form|
  = form.input :number_of_seats
  = form.submit 'Reserve Seats'
```

```ruby
# Form

class ReservationForm
  include ActiveModel::Model
  include Virtus

  attribute :customer
  attribute :conference
  attribute :number_of_seats

  validates :customer, :event, :presence => true, :strict => true
  validates :number_of_seats, :presence => true, :numericity => true
end

# Service

class ReserveSeats
  include Wisper::Publisher

  def execute(form)
    if form.valid?
      reserved_seats = # ...
      reservation = # ...

      broadcast(:create_reservation_successful, reservation)
    else
      broadcast(:create_reservation_failed)
    end
  end
end

# Controller

class ReservationsController
  before_filter :find_conference

  # GET /conference/:id/reservations/new
  def new
    @reservation_form = ReserveSeats::ReservationForm.new
  end

  # POST /conference/:id/reservations
  def create
    @reservation_form = ReserveSeats::ReservationForm.new(form_params)
    command = ReserveSeats.new
    command.subscribe(ReservationMailer.new)
    command.subscribe(StatisticsListener.new)
    command.on(:create_reservation_successful) { |reservation| redirect_to my_reservations_path(reservation) }
    command.on(:create_reservation_failed)     { render :action => :new }
    command.execute(@reservation_form)
  end

  private

  def form_params
    params[:reservation_form].reverse_merge(:customer   => current_user,
                                            :conference => @conference)

  def find_conference
    @conference = Conference.find(event_id)
  end
end

# The subscribers

class ReservationMailer
  def create_reservation_successful(reservation)
    # send email to customer
  end
end

class StatisticsListener
  def create_reservation_successful(reservation)
    # update stats
  end
end
```


# Global Listeners

The use case: Allowing engines to build on one another without being coupled.

In our 'core' engine there is a service which broadcasts an event.

```ruby
class CreateStudy
  include Wisper::Publisher

  def execute(attributes)
    study = # ...
    create_folders(study)
    broadcast(:study_created_successfully, study)
  end

  private

  def create_folders(study)
    # ...
  end
end
```

In another engine which handles recruitment for a study we want to do some
additional work when a study is created.

```ruby
# when the engine is initialized globally subscribe the listener

Wisper.add_listener(Recruitment::StudyListener.new)

# The listener

class Recruitment::StudyListener
  def study_created_successfully(study)
    # ...
  end
end
```


# Async

```ruby
user_creator.subscribe(UserEmailer.new, :async => true)
```


SUMMARY

* Nicely encapsulate non-core concerns, such as updating the UI via websockets
* Keep domain objects free from unrelated side effects
* Smaller objects with fewer responsibilities
* Objects can be wired up based on context in a lightweight manner
* Objects tell listeners what happened, not what to do (trusting, not controlling)
* Clear boundaries exist between objects in different layers.


FURTHER READING

* http://www.sitepoint.com/using-wisper-to-decompose-applications/
* https://github.com/krisleech/wisper/wiki
* http://devblog.reverb.com/post/57704562313/getting-hexagonal-with-wisper-a-listener-framework-for


# Thanks for your time! QUESTIONS?


        Reserving seats for a conference

        @begin=haml@
        %h2 #{@conference.name}

        = simple_form_for @reservation_form, :url => new_conference_reservations_path(@conference) do |form|
          = form.input :number_of_seats
          = form.submit 'Reserve Seats'
        @end=haml@

        @begin=ruby@
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
        @end=ruby@

        # Service

        @begin=ruby@
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
        @end=ruby@

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
















































































slide 3

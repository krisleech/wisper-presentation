        Async

        @begin=ruby@
        user_creator.subscribe(UserEmailer.new, :async => true)
        @end=ruby@

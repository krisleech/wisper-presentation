        Async
        @begin=ruby@
        gem 'wisper-async'
        @end=ruby@
        And...
        @begin=ruby@
        user_creator.subscribe(UserEmailer.new, :async => true)
        @end=ruby@

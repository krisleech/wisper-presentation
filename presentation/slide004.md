        Global Listeners

        The use case: Allowing engines to build on one another without being coupled.

        In our 'core' engine there is a service which broadcasts an event.

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

        additional work when a study is created.

        # when the engine is initialized globally subscribe the listener

        Wisper.add_listener(Recruitment::StudyListener.new)

        # The listener

        class Recruitment::StudyListener
          def study_created_successfully(study)
            # ...
          end
        end
















































































slide 4
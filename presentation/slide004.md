        Using Global Listeners to communicate between Rails Engines

        @begin=ruby@
        # In the core engine

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

        # Somewhere in another engine...

        Wisper.add_listener(Recruitment::StudyListener.new)

        # The listener

        class Recruitment::StudyListener
          def study_created_successfully(study)
            # ...
          end
        end
        @end=ruby@
















































































slide 4

        Using Global Listeners to communicate between Rails Engines

        In the core engine

        @begin=ruby@
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
        @end=ruby@

        Somewhere is another engine...

        @begin=ruby@
        Wisper.add_listener(Recruitment::StudyListener.new)

        # The listener

        class Recruitment::StudyListener
          def study_created_successfully(study)
            # ...
          end
        end
        @end=ruby@
















































































slide 4

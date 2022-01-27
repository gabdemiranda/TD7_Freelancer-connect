module Api
  module V1
    class ProjectsController < Api::V1::ApiController
      def index
        @projects = Project.where(status: 5)

        render json: @projects.as_json(
          except: %i[created_at updated_at regular_user_id],
          include: { regular_user: { only: %i[email] } }
        )
      end
    end
  end
end
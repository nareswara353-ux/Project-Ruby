module Api
  module V1
    class SearchController < BaseController
      def index
        query = params[:q].to_s.strip
        return render json: { courses: [], users: [] } if query.blank?

        render json: {
          courses: CourseSerializer.serialize(search_courses(query)),
          users: UserSerializer.serialize(search_users(query))
        }
      end

      private

      def search_courses(query)
        Course.published.search_by_title(query).limit(10)
      end

      def search_users(query)
        User.where("name ILIKE ?", "%#{query}%").limit(10)
      end
    end
  end
end

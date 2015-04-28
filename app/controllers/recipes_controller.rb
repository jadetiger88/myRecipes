class RecipesController < ApplicationController
  
  before_action :set_recipe,          only:   [:edit, :update, :show, :like]
  before_action :require_user,        except: [:show, :index, :like]
  before_action :require_user_like,   only:   [:like]
  before_action :require_same_user,   only:   [:edit, :update]
  
    def index
        # @recipes = Recipe.all.sort_by{|likes| likes.thumbs_up_total}.reverse
        @recipes = Recipe.paginate(page: params[:page], per_page: 4)
    end
    
     def show
     end
     
     def new
         @recipe = Recipe.new
     end
     
     def create
         @recipe = Recipe.new(recipe_params)
         @recipe.chef = current_user
         
         if @recipe.save 
           flash[:success] = "Your recipe was created successfully!"
           redirect_to recipes_path
         else 
            render :new
         end
     end
     
     def edit
     end
     
     def update
       if @recipe.update(recipe_params)
         flash[:success] = "Your recipe was updated sucessfully!"
         redirect_to recipe_path(@recipe)
       else
         render :edit
       end
     end
     
     def like
       like = Like.create(like: params[:like], chef: current_user, recipe: @recipe)
       if like.valid? 
          flash[:success]   = "your selection was sucessfully"
       else
          flash[:danger]    = "you can only vote once"
       end
       redirect_to :back
     end
     
     private
     
      def recipe_params
          params.require(:recipe).permit(:name, :summary, :description, :picture, style_ids: [], ingredient_ids: [])
      end
      
      def set_recipe
          @recipe = Recipe.find(params[:id])
      end
      
      def require_same_user
        if current_user != @recipe.chef
          flash[:danger] = "You can only edit your own recipes"
          redirect_to recipes_path
        end
      end
      
        def require_user_like
          if !logged_in? 
              flash[:danger] = "You must be logged in to perform that action"
              redirect_to :back
          end
        end

end

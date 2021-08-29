class RegistrationsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        # render plain: "Thanks!"
        # render plain: params[:user]
        # params (v)
        # {"authenticity_token"=>"[FILTERED]", "user"=>{"email"=>"leejyang00@gmail.com", "password"=>"[FILTERED]", "password_confirmation"=>"[FILTERED]"}, "commit"=>"Sign Up"}
        # params[:user] (v)
        # {"email"=>"leejyang00@gmail.com", "password"=>"[FILTERED]", "password_confirmation"=>"[FILTERED]"}

        # (v) same as doing User.new({email:"some@email.com", password: "pass", password_confirmation: "pass"})
        @user = User.new(user_params)

        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path, notice:"Successfully created acccount"
        else
            render :new
        end
    end


    private

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
        # ^ same as params[:user], just with more restrictions
        # .permit, only allows these attributes to be set
    end
end

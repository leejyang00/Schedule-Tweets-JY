class OmniauthCallbacksController < ApplicationController
    
    def twitter

        # Rails.logger.info auth

        # Current.user.twitter_accounts will query the table,
        # .create, will create a new record, will automatically set a new user_id for us

        # first_or_inittialize, query table and get first record if username exist, or give me new twitter account
        # with this username assigned

        twitter_accounts = Current.user.twitter_accounts.where(username: auth.info.nickname).first_or_initialize
        twitter_accounts.update(
            name: auth.info.name,
            image: auth.info.image,
            token: auth.credentials.token,
            secret: auth.credentials.secret,
        )
        
        redirect_to twitter_accounts_path, notice: "Successfully connected to your account"
    end

    # Omniauth gives us info in Hash of all the things the api sent back
    def auth
        request.env['omniauth.auth']
    end
end
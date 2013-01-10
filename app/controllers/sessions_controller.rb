class SessionsController < ApplicationController
        # displays login form
        def new
        end

        # POST login action
        def create
                user = User.authenticate params[:email], params[:password]
                if user
                        session[:user_id] = user.id
                        redirect_to root_url, :notice => 'Welcome back, ' + user.username + '!'
                else
                        flash[:notice] = "Please enter valid information."
                        render 'new'
                end
        end

        # DELETE logout action
        def destroy
                session[:user_id] = nil
                redirect_to root_url
        end

end

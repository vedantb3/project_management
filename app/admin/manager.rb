ActiveAdmin.register User, as: "Manager" do
  permit_params :email, :password, :password_confirmation, :first_name, :last_name, :contact_number, :job_title, :team_name, :skills, :joining_date

  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name
    column :contact_number
    column :job_title
    column :team_name
    column :skills
    column :joining_date
    actions
  end

  form do |f|
    f.inputs "Manager Details" do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :contact_number
      f.input :job_title
      f.input :team_name
      f.input :skills
      f.input :joining_date
    end
    f.actions
  end

  show do
    attributes_table do
      row :email
      row :first_name
      row :last_name
      row :contact_number
      row :job_title
      row :team_name
      row :skills
      row :joining_date
    end
  end
  controller do
    def scoped_collection
      super.with_role(:manager)
    end

    def create
      @user = User.new(permitted_params[:user])
      @user.add_role(:manager)

      # Generate a random password
      random_password = Devise.friendly_token[0, 8]
      @user.password = random_password
      @user.password_confirmation = random_password

      if @user.save
        # Send the random password to the user's email
        UserMailer.random_password_email(@user, random_password).deliver_now

        redirect_to admin_users_path, notice: 'User created successfully!'
      else
        render :new
      end
    end
  end
end

class RegistrationMailer < ActionMailer::Base


  default from: "Administrator <misha.skubenich@gmail.com>"
  def registration_email(user)
      @user = user
      mail :to => user.email, :subject => "You have been Invited!"
  end


end

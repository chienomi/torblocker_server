class Mailer < ApplicationMailer
  default from: 'hq@torblocker.com'

  def sendmail_confirm(user)
  	@user = user
    @sender = "TorBlocker"

    mail to: user.email, subject: "Sign Up Confirmation"
  end
end

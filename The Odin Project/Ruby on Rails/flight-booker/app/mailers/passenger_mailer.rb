class PassengerMailer < ActionMailer::Base
  default from: "mikemagss@gmail.com"


  def thank_you_email(passenger)
    @passenger = passenger
    @booking = @passenger.bookings.last
    email_with_name = "#{@passenger.name} <#{@passenger.email}>"
    @url  = 'http://mikemagss.com/dota2/n0tail.html'

    mail(to: email_with_name, subject: 'Thank you for booking with FlightBooker!')

  end
end

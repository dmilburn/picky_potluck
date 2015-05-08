class RsvpsController < ApplicationController

  def edit
    @party = Party.find(params[:party_id])
    @rsvp = Rsvp.find(params[:id])
  end

  def update
  end

  def create
    good_emails = []
    bad_emails = []
    party = Party.find(params[:party_id])
    emails = params[:emails][0].split(" ")
    emails.each do |email|
      user = User.find_by(email: email)
      if user
        user.rsvps.create(party_id: party.id)
        good_emails << email
      else
        bad_emails << email
      end
    end
    flash[:notice] = create_notice(good_emails, bad_emails)
    redirect_to party_path(party)
  end

  private

  def create_notice(good_emails, bad_emails)
    notice = ""
    notice += "Invitations sent to #{good_emails.join(' ')}. " if good_emails.length > 0
    notice += "Could not locate Picky Potluck memberships for #{bad_emails.join(', ')}. " if bad_emails.length > 0
    notice
  end

end
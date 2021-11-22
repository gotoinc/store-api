# frozen_string_literal: true

module Notifiers
  module Admin
    class NotificationsJob < Base

      def perform(room_ids, opts)
        ActiveStorage::Current.host = ENV.fetch('DEFAULT_HOST')

        rooms = Notifications::Room.find(room_ids)
        return if rooms.blank?

        rooms.each do |room|
          notification = room.notifications.create!(opts)

          ActionCable.server.broadcast "Room-#{room.id}",
                                       Notifications::ItemSerializer.new(notification,
                                                                         include: %i[customer admin]).serializable_hash
        end
      end
    end
  end
end

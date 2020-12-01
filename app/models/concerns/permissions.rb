module Permissions
  extend ActiveSupport::Concern

  included do
    rolify role_cname: 'Permission', role_table_name: :permission, role_join_table_name: :members_permissions

    include InstanceMethods
  end

  module InstanceMethods
    def is_organiser?
      organised_chapters.present?
    end

    def is_admin_or_organiser?
      has_role?(:admin) || is_organiser?
    end

    def is_monthlies_organiser?
      Meeting.with_role(:organiser, self).present?
    end

    def organised_chapters
      Chapter.with_role(:organiser, self)
    end
  end
end

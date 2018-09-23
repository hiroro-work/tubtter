# no deprecation warning if custom_parent_classes==[]
# https://github.com/tcocca/acts_as_follower/pull/93
module ActsAsFollower
  module FollowerLibExtention

    private

    DEFAULT_PARENTS = [ApplicationRecord, ActiveRecord::Base]

    def parent_classes
      return DEFAULT_PARENTS unless ActsAsFollower.custom_parent_classes.present?

      ActiveSupport::Deprecation.warn("Setting custom parent classes is deprecated and will be removed in future versions.")
      ActsAsFollower.custom_parent_classes + DEFAULT_PARENTS
    end
  end

  FollowerLib.prepend(FollowerLibExtention)
end

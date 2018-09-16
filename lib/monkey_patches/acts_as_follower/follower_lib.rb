module ActsAsFollowerExtention
  module FollowerLib
    private

    def parent_class_name(obj)
      obj.class.base_class.name
    end
  end
end

ActsAsFollower.prepend(ActsAsFollowerExtention)

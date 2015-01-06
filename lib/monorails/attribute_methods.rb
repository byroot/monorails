module DoubleCheckedLockPatch
  # Backport of https://github.com/rails/rails/commit/28d52c59f2cb32180ca24770bf95597ea3ad8198
  def define_attribute_methods
    return false if @attribute_methods_generated
    super
  end
end

ActiveRecord::Base.extend(DoubleCheckedLockPatch)

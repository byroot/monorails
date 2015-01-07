module ActiveSupport::PerThreadRegistry

  def instance
    @__instance ||= new
  end
end

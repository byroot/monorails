module ActiveSupport::PerThreadRegistry
  private

  def instance
    @__instance ||= new
  end
end

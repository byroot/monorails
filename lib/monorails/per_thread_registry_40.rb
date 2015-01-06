module ActiveSupport::PerThreadRegistry
  private

  def per_thread_registry_instance
    @__instance ||= new
  end
end

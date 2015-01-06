require 'spec_helper'

class Registry
  extend ActiveSupport::PerThreadRegistry

  def itself
    self
  end

  def thruth
    42
  end
end

describe ActiveSupport::PerThreadRegistry do

  it 'is memoized' do
    expect { nil }.to_not change { Registry.itself.object_id }
  end

  it 'still forward methods just fine' do
    expect(Registry.thruth).to be == 42
  end

  it 'share the memoized instance between all threads (that is why you should not use that patch in threading environments)' do
    child_thread_object_id = nil
    Thread.new { child_thread_object_id = Registry.itself.object_id }.join
    expect(child_thread_object_id).to be == Registry.itself.object_id
  end
end

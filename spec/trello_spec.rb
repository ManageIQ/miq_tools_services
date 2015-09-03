require 'spec_helper'

describe MiqToolsServices::Trello do
  let(:service) { double("trello service") }

  before do
    described_class.any_instance.stub(:service => service)
  end

  def with_service
    described_class.call("org name") { |service| yield service }
  end

  it_should_behave_like "ServiceMixin service"
end

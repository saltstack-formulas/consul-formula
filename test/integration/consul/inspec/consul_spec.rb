# frozen_string_literal: true

describe service('consul') do
  it { should be_enabled }
  it { should be_running }
end

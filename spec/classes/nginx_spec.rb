#!/usr/bin/env rspec

require 'spec_helper'

describe 'nginx' do
  it { should contain_class 'nginx' }
end

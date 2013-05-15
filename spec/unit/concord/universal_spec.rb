require 'spec_helper'

describe Concord do

  let(:class_under_test) do
    Class.new do
      include Concord.new(:foo, :bar)
    end
  end

  let(:instance_a) { class_under_test.new(foo, bar) }
  let(:instance_b) { class_under_test.new(foo, bar) }
  let(:instance_c) { class_under_test.new(foo, mock('Baz')) }

  let(:foo) { mock('Foo') }
  let(:bar) { mock('Bar') }

  context 'initializer lines' do
    unless Devtools.jruby?
      it 'sets initializer correctly' do
        klass = Class.new
        # Nicer way to assert this?
        klass.should_receive(:class_eval) do |code, file, line|
          file.should eql(File.expand_path('../../../../lib/concord.rb', __FILE__))
          line.should be(83)
        end
        klass.send(:include, Concord.new)
      end
    end
  end

  context 'visibiluty' do
    it 'should set attribute readers to public' do
      klass = Class.new
      klass.send(:include, Concord.new(:foo))
      klass.protected_instance_methods.should == [:foo]
    end
  end

  context 'attribute behavior' do
    subject { instance_a }

    specify { subject.send(:foo).should be(foo) }
    specify { subject.send(:bar).should be(bar) }
  end

  context 'equalization behavior' do
    specify 'composed objects are equalized on attributes' do
      instance_a.should      == instance_b
      instance_a.hash.should == instance_b.hash
      instance_a.should      eql(instance_b)

      instance_a.should_not  == instance_c
      instance_a.should_not  eql(instance_c)
    end
  end

  context 'to much composition behavior' do
    specify 'it raises an error' do
      expect { Concord.new(:a, :b, :c, :d) }.to raise_error(RuntimeError, 'Composition of more than three objects is not allowed')
    end
  end
end

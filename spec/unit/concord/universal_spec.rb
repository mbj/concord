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
          expect(file).to eql(File.expand_path('../../../../lib/concord.rb', __FILE__))
          expect(line).to be(86)
        end
        klass.send(:include, Concord.new)
      end
    end
  end

  context 'visibility' do
    it 'should set attribute readers to protected' do
      protected_methods = class_under_test.protected_instance_methods.map(&:to_sym)
      expect(protected_methods).to match_array([:foo, :bar])
    end
  end

  context 'attribute behavior' do
    subject { instance_a }

    specify { expect(subject.send(:foo)).to be(foo) }
    specify { expect(subject.send(:bar)).to be(bar) }
  end

  context 'equalization behavior' do
    specify 'composed objects are equalized on attributes' do
      expect(instance_a).to eql(instance_b)
      expect(instance_a.hash).to eql(instance_b.hash)
      expect(instance_a).to      eql(instance_b)
      expect(instance_a).to_not  be(instance_c)
      expect(instance_a).to_not  eql(instance_c)
    end
  end

  context 'when composing too many objects' do
    specify 'it raises an error' do
      expect {
        Concord.new(:a, :b, :c, :d)
      }.to raise_error(RuntimeError, 'Composition of more than 3 objects is not allowed')
      expect {
        Concord.new(:a, :b, :c)
      }.to_not raise_error
    end
  end

  context Concord::Public do
    let(:class_under_test) do
      Class.new do
        include Concord::Public.new(:foo, :bar)
      end
    end

    it 'should create public attr readers' do
      object = class_under_test.new(:foo, :bar)
      expect(object.foo).to eql(:foo)
      expect(object.bar).to eql(:bar)
    end
  end
end

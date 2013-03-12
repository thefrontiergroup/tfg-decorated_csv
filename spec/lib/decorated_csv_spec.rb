require 'spec_helper'

describe DecoratedCSV do

  class GenericObject

    attr_accessor :name, :email

    def initialize(attributes = {})
      attributes.each{ |key, value| send("#{key}=", value) }
    end

  end

  class GenericDecorator < Draper::Decorator

    decorate :generic_object

  end

  describe '.generate' do

    let(:decorator)   { GenericDecorator }
    let(:obj_a)       { GenericObject.new(name: 'test', email: 'test@example.com') }
    let(:obj_b)       { GenericObject.new(name: 'another test', email: 'anothertest@example.com') }
    let(:collection)  { [obj_a, obj_b] }
    subject { CSV.parse DecoratedCSV.generate(decorator, collection) }

    context 'when CSV_HEADER_ROW is defined' do

      class DecoratorWithHeader < GenericDecorator
        CSV_HEADER_ROW = ['Name', 'Email']
      end

      let(:decorator)   { DecoratorWithHeader }

      context 'and #as_csv_row is defined' do

        class ValidDecorator < DecoratorWithHeader

          def as_csv_row
            [
              source.name,
              source.email
            ]
          end

        end

        let(:decorator)   { ValidDecorator }

        it 'should generate the correct header row for the csv' do
          subject[0][0].should == 'Name'
          subject[0][1].should == 'Email'
        end

        it 'should generate the correct row for each item in the collection' do
          subject[1][0].should == 'test'
          subject[1][1].should == 'test@example.com'
          subject[2][0].should == 'another test'
          subject[2][1].should == 'anothertest@example.com'
        end

      end

      context 'and #as_csv_row is undefined' do

        specify { expect{subject}.to raise_error NoMethodError, '#as_csv_row is undefined on the decorator class' }

      end

    end

    context 'when CSV_HEADER_ROW is undefined' do

      specify { expect{subject}.to raise_error NameError, 'CSV_HEADER_ROW is undefined on the decorator class' }

    end

  end

end
require_relative '../../spec_helper'

describe PrimeMultiplicationGenerator::PrimeException do

  subject { PrimeMultiplicationGenerator::PrimeException }

  context 'when exception is raised' do

    let(:input_num) { 'Invalid' }
    let(:expected_msg) {
      subject::EX_MSG + ":: #{input_num}"
    }

    context 'when no input message is provided' do

      let(:ex_obj) {
        subject.new(input_num)
      }

      before do
        ex_obj
      end

      it 'includes default message' do
        expect { raise ex_obj }.to raise_exception do |ex|
          expect(ex.msg).to eq(expected_msg)
        end
      end
    end

    context 'when input message is provided' do

      let(:msg) { 'Incorrect Input' }
      let(:expected_msg) { msg + ':: ' +  input_num }
      let(:ex_obj) {
        subject.new(input_num, msg)
      }

      before do
        ex_obj
      end

      it 'includes provided message' do
        expect { raise ex_obj }.to raise_exception do |ex|
          expect(ex.msg).to eq(expected_msg)
        end
      end
    end
  end
end

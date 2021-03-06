require 'spec_helper'

module Ivan
  describe Output do
    let(:display) { double(send_instructions: true) }
    let(:output) { Output.new(frame: Frame.new, display: display) }
    let(:object_1) { double(render: [1,2,3]) }

    describe '#render' do
      it 'sends :add_instructions to the frame object' do
        expect(output.frame).to receive(:add_instructions)
        output.render(object_1)
      end
    end

    describe '#send_frame_to_display' do
      context 'when it has instructions in the frame' do
        it 'sends instructions to display' do
          output.render(object_1)
          expect(output.display).to receive(:send_instructions).at_least(:once)
          output.send_frame_to_display
        end
      end
    end

    describe '#render_and_send' do
      it 'calls #clear, #render and #send_frame_to_display in order' do
        expect(output).to receive(:clear)
        expect(output).to receive(:render)
        expect(output).to receive(:send_frame_to_display)
        output.render_and_send(nil)
      end
    end

    describe '#clear' do
      it 'clears the frame' do
        expect(output.frame).to receive(:clear)
        output.clear
      end
    end
  end
end
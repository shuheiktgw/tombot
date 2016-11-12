require_relative '../../app/services/response_service'

class ResponseServiceSpec
  describe 'ResponseService' do
    describe '#form_response' do
      before do
        @params = {"events" => [{"type" => 'message', "message" => {"text" => ''}}]}
        @cleaning_date_mock = double('Cleaning date service mock')
      end
      it 'should return nothing without prefix' do
        @params["events"][0]["message"]["text"] = 'smb_ping'
        response_service = ResponseService.new(@params, @cleaning_date_mock)

        actual = response_service.form_response

        expect(actual).to be_empty
      end

      it 'should return pong to ping' do
        @params["events"][0]["message"]["text"] = 'tmb_ping'
        response_service = ResponseService.new(@params, @cleaning_date_mock)

        expect = 'pong'
        actual = response_service.form_response

        expect(actual[0]).to eq(expect)
      end

      it 'should call cleaning_date#scheduled_cleaning_date if valid date is given' do
        @params["events"][0]["message"]["text"] = 'tmb_set-cleaning-date_2016/11/11'
        expect(@cleaning_date_mock).to receive(:scheduled_cleaning_date=)

        response_service = ResponseService.new(@params, @cleaning_date_mock)
        response_service.form_response
      end

      it 'should return error message if invalid date is given' do
        @params["events"][0]["message"]["text"] = 'tmb_set-cleaning-date_false-date'
        expect(@cleaning_date_mock).not_to receive(:scheduled_cleaning_date=)
        response_service = ResponseService.new(@params, @cleaning_date_mock)

        expect = '日付の形式が正しくありません'
        actual = response_service.form_response
        expect(actual[0]).to eq(expect)
      end

      it 'should return commands to help command' do
        @params["events"][0]["message"]["text"] = 'tmb_help'
        response_service = ResponseService.new(@params, @cleaning_date_mock)

        expect = '選択可能なコマンドは以下のとおりです'
        actual = response_service.form_response
        expect(actual[0]).to start_with(expect)
      end
    end

  end
end
class Dialogflow
  def self.client(api_session_id = nil)
    if api_session_id.present?
      ApiAiRuby::Client.new do |config|
        config.client_access_token = ENV['dialogflow_client_access_token']
        config.api_session_id = api_session_id
        config.api_lang = 'th'
      end
    else
      ApiAiRuby::Client.new do |config|
        config.client_access_token = ENV['dialogflow_client_access_token']
        config.api_lang = 'th'
      end
    end
  end

  def self.send(message, api_session_id = nil)
    response = client(api_session_id).text_request(message)
    data = response[:result][:metadata]

    resp = { 
      session_id: response[:sessionId], 
      agent_message: response[:result][:resolvedQuery], 
      action: response[:result][:action],
      intent_name: data[:intentName],
      fulfillment: response[:result][:fulfillment]
    }

    ap resp
  end
end
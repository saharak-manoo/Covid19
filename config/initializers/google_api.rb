class GoogleApi

  def self.client
    EasyTranslate.api_key = ENV['google_api_key']
  end

  def self.translate(text = 'Hi')
    client
    EasyTranslate.translate(text, to: :th)
  end
end
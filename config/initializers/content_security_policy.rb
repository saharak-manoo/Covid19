Rails.application.config.content_security_policy do |policy|
  if Rails.env.development?
    policy.script_src :self, :https, :unsafe_eval
  else
    policy.script_src :self, :https, :unsafe_eval
  end
end
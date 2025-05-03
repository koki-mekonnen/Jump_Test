import Config

# Enable server in production if PHX_SERVER environment variable is set
if System.get_env("PHX_SERVER") do
  config :markdown_editor, MarkdownEditorWeb.Endpoint, server: true
end

if config_env() == :prod do
  # The secret key base is used to sign/encrypt cookies and other secrets.
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  host = System.get_env("PHX_HOST") || "example.com"
  port = String.to_integer(System.get_env("PORT") || "4000")

  config :markdown_editor, MarkdownEditorWeb.Endpoint,
    url: [host: host, port: 443],
    http: [
      ip: {0, 0, 0, 0},
      port: port
    ],
    secret_key_base: secret_key_base,
    server: true

  # Configure mailer for production
  # config :markdown_editor, MarkdownEditor.Mailer,
  #   adapter: Swoosh.Adapters.SMTP,
  #   relay: "smtp.example.com",
  #   username: System.get_env("SMTP_USERNAME"),
  #   password: System.get_env("SMTP_PASSWORD"),
  #   tls: :always,
  #   auth: :always,
  #   port: 587
end

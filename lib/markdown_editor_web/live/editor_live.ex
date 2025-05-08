defmodule MarkdownEditorWeb.EditorLive do
  use MarkdownEditorWeb, :live_view

  def mount(_params, _session, socket) do
    # Assign a default value for control_codes
    {:ok, assign(socket, control_codes: "")}
  end

  def handle_event("update_control_codes", %{"value" => value}, socket) do
    {:noreply, assign(socket, control_codes: value)}
  end
end

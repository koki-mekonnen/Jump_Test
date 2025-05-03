defmodule MarkdownEditorWeb.EditorLive do
  use MarkdownEditorWeb, :live_view
  alias Phoenix.LiveView.JS
  import Phoenix.HTML

  def mount(_params, _session, socket) do
    {:ok, assign(socket, markdown: "", html: "")}
  end

  def render(assigns) do
    ~H"""
    <div class="flex h-screen">
      <div class="w-1/2 p-4 border-r">
        <h2 class="text-lg font-bold mb-2">Markdown</h2>
        
        <textarea
          class="w-full h-full border rounded p-2"
          phx-debounce="300"
          phx-change="update"
          name="markdown"
          value={@markdown}
        />
      </div>
      
      <div class="w-1/2 p-4">
        <div class="flex justify-between items-center mb-2">
          <h2 class="text-lg font-bold">Preview</h2>
          
          <div>
            <button phx-click="export_pdf" class="px-3 py-1 bg-blue-600 text-white rounded mr-2">
              Export
            </button>
             <button id="copy-btn" class="px-3 py-1 bg-green-600 text-white rounded">Copy</button>
          </div>
        </div>
        
        <div
          id="preview"
          class="prose max-w-none"
          phx-update="ignore"
          dangerously_set_inner_html={@html}
        />
      </div>
    </div>
    """
  end

  def handle_event("update", %{"markdown" => md}, socket) do
    html = Earmark.as_html!(md)
    {:noreply, assign(socket, markdown: md, html: html)}
  end

  def handle_event("export_pdf", _, socket) do
    File.write!("priv/static/export.html", socket.assigns.html)
    System.cmd("node", ["priv/static/pdf_exporter.js"])
    {:noreply, push_event(socket, "download_pdf", %{url: "/export.pdf"})}
  end
end

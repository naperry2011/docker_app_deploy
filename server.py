from http.server import SimpleHTTPRequestHandler, HTTPServer

port = 8000
handler = SimpleHTTPRequestHandler
server = HTTPServer(("0.0.0.0", port), handler)

print(f"Server running on port {port}")
server.serve_forever()
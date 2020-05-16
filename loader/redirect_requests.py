from mitmproxy import http

def request(flow: http.HTTPFlow) -> None:
    if flow.request.pretty_host == "assets.checkra.in":
        flow.request.host = "crkatri.github.io"

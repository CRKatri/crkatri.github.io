from mitmproxy import http

def request(flow: http.HTTPFlow) -> None:
    if flow.request.pretty_host == "assets.checkra.in/loader/config.json":
        flow.request.host = "crkatri.github.io/loader/config.json"

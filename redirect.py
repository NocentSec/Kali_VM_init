#!/usr/bin/env python3
#redirect script by Bruno Brononsky on stackoverflow https://stackoverflow.com/questions/2506932/how-do-i-redirect-a-request-to-a-different-url-in-python
# run like this:
# sudo ./redirect.py 80 http://jenkins.example.com:8080/

import sys
from http.server import HTTPServer, BaseHTTPRequestHandler

if len(sys.argv)-1 != 2:
    print("""
Usage: {} <port_number> <url>
    """.format(sys.argv[0]))
    sys.exit()

class Redirect(BaseHTTPRequestHandler):
   def do_GET(self):
       self.send_response(302)
       self.send_header('Location', sys.argv[2])
       self.end_headers()

HTTPServer(("", int(sys.argv[1])), Redirect).serve_forever()
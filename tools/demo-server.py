#!/usr/bin/env python3
#
# A small web server that can serve the `${root}/microzig-deploy` folder for testing the package infrastructure.
#
# Basically `python -m http.server 8080`, but also hides folders starting with `.data` so the "internals" aren't shown
# to the user in the file listing.
#

from pathlib import Path
from http.server import HTTPServer,SimpleHTTPRequestHandler
from http import HTTPStatus
import sys, os, io, urllib.parse, html

SELF_DIR = Path(__file__).parent
assert SELF_DIR.is_dir()

ROOT_DIR = SELF_DIR.parent
assert SELF_DIR.is_dir()

DEPLOYMENT_DIR = ROOT_DIR / "microzig-deploy"
if not DEPLOYMENT_DIR.is_dir():
    print(f"{DEPLOYMENT_DIR} isn't a directory. Please create a directory first with ./tools/bundle.sh!")
    exit(1)

class Handler(SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=str(DEPLOYMENT_DIR), **kwargs)

    def list_directory(self, path):
        """Helper to produce a directory listing (absent index.html).

        Return value is either a file object, or None (indicating an
        error).  In either case, the headers are sent, making the
        interface the same as for send_head().

        """
        try:
            list = os.listdir(path)
        except OSError:
            self.send_error(
                HTTPStatus.NOT_FOUND,
                "No permission to list directory")
            return None
        list.sort(key=lambda a: a.lower())
        r = []
        try:
            displaypath = urllib.parse.unquote(self.path,
                                               errors='surrogatepass')
        except UnicodeDecodeError:
            displaypath = urllib.parse.unquote(self.path)
        displaypath = html.escape(displaypath, quote=False)
        enc = sys.getfilesystemencoding()
        title = 'Directory listing for %s' % displaypath
        r.append('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" '
                 '"http://www.w3.org/TR/html4/strict.dtd">')
        r.append('<html>\n<head>')
        r.append('<meta http-equiv="Content-Type" '
                 'content="text/html; charset=%s">' % enc)
        r.append('<title>%s</title>\n</head>' % title)
        r.append('<body>\n<h1>%s</h1>' % title)
        r.append('<hr>\n<ul>')
        for name in list:
            fullname = os.path.join(path, name)
            displayname = linkname = name
            if name.startswith("."):
                # ignore "hidden" directories
                continue 
            # Append / for directories or @ for symbolic links
            if os.path.isdir(fullname):
                displayname = name + "/"
                linkname = name + "/"
            if os.path.islink(fullname):
                # displayname = name + "@"
                linkname = os.readlink(fullname) # resolve the symlink
            r.append('<li><a href="%s">%s</a></li>' % (urllib.parse.quote(linkname, errors='surrogatepass'), html.escape(displayname, quote=False)))
        r.append('</ul>\n<hr>\n</body>\n</html>\n')
        encoded = '\n'.join(r).encode(enc, 'surrogateescape')
        f = io.BytesIO()
        f.write(encoded)
        f.seek(0)
        self.send_response(HTTPStatus.OK)
        self.send_header("Content-type", "text/html; charset=%s" % enc)
        self.send_header("Content-Length", str(len(encoded)))
        self.end_headers()
        return f

if __name__ == "__main__":
    httpd = HTTPServer(('', 8080), Handler)
    httpd.serve_forever()


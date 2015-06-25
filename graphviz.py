#!/usr/bin/env python

"""
Pandoc filter to process code blocks with class "graphviz" into
graphviz-generated images.
"""

import contextlib
import hashlib
import os
import subprocess
import sys
import tempfile

from pandocfilters import toJSONFilter, Str, Para, Image


IMAGEDIR = "build"


@contextlib.contextmanager
def get_tempfile(contents):
    f = tempfile.NamedTemporaryFile(delete=False)
    f.write(contents)
    f.close()
    yield f.name
    os.unlink(f.name)


def sha1(x):
    return hashlib.sha1(x.encode(sys.getfilesystemencoding())).hexdigest()


def call_graphviz(code, filetype, destination_filepath):
    try:
        os.mkdir(IMAGEDIR)
        sys.stderr.write('Created directory ' + IMAGEDIR + '\n')
    except OSError:
        pass
    with get_tempfile(code) as code_filepath:
        args = ["dot", "-T%s" % filetype, code_filepath,
                "-o", destination_filepath]
        sys.stderr.write('calling: %s\n' % (args, ))
        try:
            subprocess.check_output(args)
        except subprocess.CalledProcessError as e:
            sys.stderr.write(e.output)
            return
    sys.stderr.write('Created image ' + destination_filepath + '\n')


def graphviz(key, value, format, meta):
    if key == 'CodeBlock':
        [[ident, classes, keyvals], code] = value
        caption = "caption"
        if "graphviz" not in classes:
            return
        filename = sha1(code)
        if format == "html":
            filetype = "png"
        elif format == "latex":
            filetype = "pdf"
        else:
            filetype = "png"
        alt = Str(caption)
        src = os.path.join(IMAGEDIR, "%s.%s" % (filename, filetype))
        if not os.path.isfile(src):
            call_graphviz(code, filetype, src)
        tit = ""
        return Para([Image([alt], [src, tit])])

if __name__ == "__main__":
    toJSONFilter(graphviz)

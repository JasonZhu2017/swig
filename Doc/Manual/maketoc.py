#!/usr/local/bin/python

import sys
import os
chs = open("chapters").readlines()

f = open("Contents.html","w")
print >>f, """
<HTML>
<HEAD>
<TITLE>SWIG Users Manual</TITLE>
</HEAD>
<BODY BGCOLOR="#ffffff">
<H1>SWIG Users Manual</H1>

<p>
"""

f.close()

num = 0

for c in chs:
    c = c.strip()
    print "Processing %s" % c
    if c:
        os.system("python makechap.py %s %d >> Contents.html" % (c,num))
    num += 1
    
f = open("Contents.html","a")
print >>f, """
</BODY>
</HTML>
"""



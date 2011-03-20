# Copyright (c) 2011, Mael Clerambault <mael@clerambault.fr>
# 
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
# 
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.


require 'socket'
require 'base64'

class DovecotAuth
  VERSION="0.2".freeze
  DEFAULT_PATH="/var/run/dovecot/auth".freeze
  CONNECT_LINE="VERSION\t1\t1\nCPID\t%d\n".freeze
  AUTH_LINE="AUTH\t1\tPLAIN\tservice=%s\tresp=%s\n".freeze
  
  def initialize(path = DEFAULT_PATH); @path = path end
  def auth_line(u, p, s); AUTH_LINE % [s, Base64.strict_encode64("\0#{u}\0#{p}")] end
  def authenticate(username, password, service = "imap")
    UNIXSocket.open(@path) {|f|
      line = ""
      f.write CONNECT_LINE % object_id
      line = f.gets while line.strip != "DONE"
      f.write auth_line(username, password, service)
      f.gets =~ /^OK/ ? true : false
    }                       
  end
end

require 'rubygems'
require 'hpricot'

html = File.read(File.join(File.dirname(__FILE__), '..', 'data', 'site-1004549-swimming-pool.html'))
doc = Hpricot(html)

p (doc/'table:nth(0) td:nth(0) span.site').inner_text
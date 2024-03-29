# What

This is a utility to determine what wells are already loaded into a
GeoFrame project and therefor what wells need to be loaded into the project
given a file containing well information

# Why?

One of my customers was having issues with wells being loaded multiple times
into the same GeoFrame project and wanted a way to determine which wells had
already been loaded and which wells needed to be loaded.  This was done in perl
because, at the time I started working on it, I felt Perl was the best fit
(because of my skill level with it and my customer's knowledge of it). I
attempted to rewrite it in Ruby, but could not get the performance needed for
performing tens of thousands of Oracle queries.

# I'm proud of this because...

  * It's still used [very] frequently and still works quite well
  * I <del>reverse engineered</del> investigated how the [commercial]
  application talks to its Oracle database, and I was then able to gleen all
  the information we needed regarding wells in the project
  * Anything that took longer than several (or maybe a few tens) of seconds was
  not acceptable to me, and on several occasions I was able to change an
  implementation and cut runtime[s] by an order of magnitude


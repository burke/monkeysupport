#MonkeySupport#

MonkeySupport is a collection of monkeypatches to Rails, replacing
existing methods with (somewhat) optimized C equivalents.

If this interests you, you should also check out methodmissing's
excellent HashWithIndifferentAccess at
http://github.com/methodmissing/hwia .

##Modules##

MonkeySupport is largely a bunch of modules, each overwriting a part
of ActiveSupport. By setting `$MonkeyModuleExcludes` to an array of
module names before loading MonkeySupport, those modules will not be
loaded. For example:

    $MonkeyModuleExcludes = ["inflector", "output_safety"]
    require 'monkeysupport'

You can also specify a whitelist of modules to load with
`$MonkeyModuleIncludes`, if you'd like. Typically, leaving both these
variables undefined is what you'll want, though.

MonkeySupport is currently comprised of the following modules:

* inflector
* output_safety

##Note on Patches/Pull Requests##
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but
   bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

##Testing##

There are some simple specs in `./spec`. To run against the
activesupport test suite, add `require 'monkeysupport'` below the
activesupport requires in activesupport's `Rakefile`. and rake away.

##Problems / TODO##

* Certain functions used to be memoized, then rails added test cases
  for adding new inflections on the fly. The memoization is currently
  disabled, but could be tweaked to be invalidated when the inflection
  rules change.
* Need to do a better job of identifying ruby versions for
  output_safety module.
* There's always more to port...

##Copyright##

Copyright (c) 2009 Burke Libbey. MIT License. See LICENSE for details.

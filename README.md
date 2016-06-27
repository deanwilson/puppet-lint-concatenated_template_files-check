# puppet-lint concatenated template files check

Extends puppet-lint to ensure all `template` functions expand a single
file, rather than unexpectedly concatenating multiple template files in
to a single string.

There is a slightly obscure difference in the way that puppet handles
multiple file names when calling the `file` or `template` functions. In
the case of the `file` function it will return the contents of the first
file found from those given, skipping any that don’t exist. The
`template` function on the other hand will evaluate all of the specified
templates and return their outputs concatenated into a single string.

This is very rarely what you want. Assuming absent_file is, well absent,
and real_file is in the correct place this will return the content of real_file.

    class multi_templated_file {
      file { '/tmp/symbolic-mode':
        content => file('mymodule/absent_file.erb', 'mymodule/real_file.erb'),
      }
    }

However if both of these files exist then the contents will be
concatenated and the combination of all given files will be returned to
`content`.

    class multi_templated_file {
      file { '/tmp/symbolic-mode':
        content => template('mymodule/first_file.erb', 'mymodule/second_file.erb'),
      }
    }

If you do want to select from multiple templates then
[puppet-multitemplate](https://github.com/deanwilson/puppet-multitemplate)
will give you a new function that behaves as you'd expect.

## Installation

To use this plugin add the following line to your Gemfile

    gem 'puppet-lint-concatenated_template_files-check'

and then run `bundle install`.

## Usage

This plugin provides a new check to `puppet-lint`.

    calling "template" with multiple files concatenates them into a single string

#### Author

[Dean Wilson](http://www.unixdaemon.net)

### License

 * MIT

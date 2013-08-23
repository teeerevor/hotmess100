hotmess100
==========

A better site for picking your songs for the triple j hotest 100

Getting started
- bundle up your shiz
- setup your config/database.rb with your db creds

``` ruby
padrino rake ar:create
```

Load previous years hottest100
``` ruby
padrino rake load_csv
```

start padrino server
``` ruby
padrino start
```

and you're away

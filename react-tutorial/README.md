# Original source: https://github.com/reactjs/react-tutorial

## React Tutorial (ES6 + [axios](https://github.com/mzabriskie/axios))

This is the React comment box **based on** [the React tutorial](http://facebook.github.io/react/docs/tutorial.html).

## To use

There are several simple server implementations included. They all serve static files from `public/` and handle requests to `/api/comments` to fetch or add data. Start a server with one of the following:

### Ruby
```sh
ruby server.rb
```

And visit <http://localhost:3000/>. Try opening multiple tabs!

## Changing the port

You can change the port number by setting the `$PORT` environment variable before invoking any of the scripts above, e.g.,

```sh
PORT=3001 ruby server.rb
```

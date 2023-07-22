type t
@module("hono") @new external make: () => t = "Hono"


let hono = make()

// app.HTTP_METHOD([path,]handler|middleware...)
// app.all([path,]handler|middleware...)
// app.on(method|method[], path, handler|middleware...)
// app.route(path, [app])
// app.use([path,]middleware)
// app.notFound(handler)
// app.onError(err, handler)
// app.showRoutes()
// app.fire()
// app.fetch(request, env, event)
// app.request(path, options)

module Request = {
  type t
  @send external param: (t, string) => string = "param"
  @send external params: (t) => Js.Dict.t<string> = "param"


  @send external query: (t, string) => string = "query"
  @send external queries: (t) => Js.Dict.t<string> = "query"

  @send external header: (t, string) => string = "header"

  @send external cookie: (t, string) => string = "cookie"

  @send external json: (t) => Js.Promise.t<Js.Json.t> = "json"
  @send external text: (t) => string = "text"
}

type response

type headers = Js.Dict.t<array<string>>

module Context = {
  type t
  @get external req: t => Request.t = "req"

  @send external text: (t, string) => response = "text"
  @send external textExt: (t, string, int, headers) => response = "text"

  @send external json: (t, Js.Json.t) => response = "json"
  @send external jsonExt: (t, Js.Json.t, int, headers) => response = "json"

  @send external body: (t, string) => response = "body"
  @send external bodyExt: (t, string, int, headers) => response = "body"
}

type handler = (Context.t) => Js.Promise.t<response>

@send external get: (t, string, handler) => unit = "get"
let get = (hono, path, handler) => {
  get(hono, path, handler)
  hono
}

@send external put: (t, string, handler) => unit = "put"
let put = (hono, path, handler) => {
  put(hono, path, handler)
  hono
}

@send external post: (t, string, handler) => unit = "post"
let post = (hono, path, handler) => {
  post(hono, path, handler)
  hono
}

@send external delete: (t, string, handler) => unit = "delete"
let delete = (hono, path, handler) => {
  delete(hono, path, handler)
  hono
}

@send external notFound: (t, handler) => unit = "notFound"
let notFound = (hono, handler) => {
  notFound(hono, handler)
  hono
}

let void = (_t: t) => ()

type fetch
@get external fetch: t => fetch = "fetch"

type options = {
  port: int,
  fetch: fetch,
}
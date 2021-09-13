import asynchttpserver, asyncdispatch



proc handleRequest(req: Request) {.async.} =
  let headers = {"Date": "Tue, 29 Apr 2014 23:40:08 GMT",
        "Content-type": "text/plain; charset=utf-8"}
  await req.respond(Http200, "Hello World", headers.newHttpHeaders())



proc main {.async.} =
  var server = newAsyncHttpServer()
  
  server.listen Port(8181)
  while true:
    if server.shouldAcceptRequest():
      await server.acceptRequest(handleRequest)
    else:
      poll()

asyncCheck main()
runForever()
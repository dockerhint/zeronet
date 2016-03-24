Intro
=====

Running Zeronet in Docker container


Run
===
```
docker run -d --name zeronet -v zeronet_data:/data -p 43110:43110 -p 15441:15441 my/zeronet
```

Access
======
```
http://127.0.0.1:43110
```

Additional notes
================

If you already have your Web browser running in a container (e.g. Firefox in
the `firefox_net` network), then you can run Zeronet container in the
following way
```
docker run -d --name zeronet -v zeronet_data:/data --net firefox_net -p 15441:15441 my/zeronet
```

With docker-compose it is even simpler
```
docker-compose up -d
```

And access it via `http://zeronet:43110`


If you wish to build the image
```
docker build -t my/zeronet .
```


Tor proxy
---------

Additionally you can use this zeronet container as Tor proxy.

Firefox configuration
```
Manual proxy configuration
SOCKS Host: zeronet
SOCKS Port: 9050
SOCKS version: v5
[x] Remote DNS
No Proxy for: localhost, 127.0.0.1, zeronet
```

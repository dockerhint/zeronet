Intro
=====

Running Zeronet in Docker container

Build
=====
```
docker build -t my/zeronet .
```

Run
===
```
docker run -d --name zeronet -v ~/.zeronetdata:/data -p 43110:43110 my/zeronet
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
docker run -d --name zeronet -v ~/.zeronetdata:/data --net firefox_net my/zeronet
```

And access it via `http://zeronet:43110`

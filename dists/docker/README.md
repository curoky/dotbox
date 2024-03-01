# Images

## Mount

for host

```
/data
  |-share
  |-p
  |-w
    |-workspace
    |-cache
  |-w1
    |-workspace

```

for container

```
/data
  |-cache
    |-vscode-server
    |-...
  |-workspace
  |-share
```

mount mapping

- data/{{profile}}/workspace:/data/workspace \
- data/{{profile}}/cache:/data/cache \
- data/share:/data/share \

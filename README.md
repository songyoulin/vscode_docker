1. A docker image for c/c++ development
2. Start a container
```
    docker run -d --rm                                            \
        --name <container_name>                                   \
        -p <port_of_webservice>:8080                              \
        -e PASSWORD=<webpage_login_password>                      \
        -v <project_dir_in_host>:/<prokect_dir_in_container>      \
        songyoulin/vscode                                         \
        /vscode/bin/code-server --host 0.0.0.0 --port 8080
```
Reference https://github.com/guolinp/dev_ccpp_docker

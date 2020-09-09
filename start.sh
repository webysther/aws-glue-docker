#!/bin/sh
set -e

# install docker
if ! [ -x "$(command -v docker)" ]; then
    curl -sSL https://get.docker.com/ | sh
    sudo usermod -aG docker $USER
fi

GLUE_DOCKER_ALIAS=$(cat <<-END
\n# glue-docker alias
\nalias glue='docker run -v \$PWD:/app -v ~/.aws:/home/docker/.aws -u $(id -u ${USER}):$(id -g ${USER}) -it webysther/aws-glue "\$@"'
\nalias glue-spark='docker run -v \$PWD:/app -v ~/.aws:/home/docker/.aws -u $(id -u ${USER}):$(id -g ${USER}) -it webysther/aws-glue:spark "\$@"'
\n
END
)

case $SHELL in
*/zsh) 
    echo $GLUE_DOCKER_ALIAS >> ~/.zshrc
   ;;
*/bash)
    echo $GLUE_DOCKER_ALIAS >> ~/.bashrc
   ;;
*)
    echo 'Shell not detected, create this alias inside your shell:\n'
    echo $GLUE_DOCKER_ALIAS
esac

cat >&2 <<-'EOF'
Use:
  - glue: Glue Python Shell
  - glue-spark: Glue Pyspark

EOF

case $SHELL in
*/zsh) 
    echo 'Execute source ~/.zshrc to register the alias'
   ;;
*/bash)
    echo 'Execute source ~/.bashrc to register the alias'
   ;;
*)
    echo 'Execute source ~/.*rc to register the alias'
esac
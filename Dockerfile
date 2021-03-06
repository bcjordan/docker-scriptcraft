from deliverous/jessie
env DEBIAN_FRONTEND noninteractive
run apt-get update && \
    apt-get install -y openjdk-7-jre rsync ssh && \
    apt-get clean
# minecraft
add canarymod.jar /opt/minecraft/
add scriptcraft.jar /opt/minecraft/plugins/

run echo "eula=true" > /opt/minecraft/eula.txt
add server.cfg /opt/minecraft/config/server.cfg
add default_NORMAL.cfg /opt/minecraft/config/worlds/default/default_NORMAL.cfg

# a default ssh access to upload js 
add sshd_config /etc/ssh/sshd_config
run rm /etc/nologin
run mkdir -p /opt/minecraft/scriptcraft/players/
run echo "root:minecraft" | chpasswd

add start /start
run chmod +x /start

expose 25565 22
volume ["/minecraft/"]
cmd /start

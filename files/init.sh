#!/sbin/openrc-run

#service_vars
RC_SVCNAME="elasticsearch"
SYS_USER="elasticsearch"
CMD_FLAGS=""
SRC_CMD="/usr/share/elasticsearch/bin/elasticsearch"


#config_daemon
name=$RC_SVCNAME
cfgfile="/etc/$RC_SVCNAME/$RC_SVCNAME.conf"
command="$SRC_CMD"
command_args="$CMD_FLAGS"
command_user="$SYS_USER"
pidfile="/run/$RC_SVCNAME/$RC_SVCNAME.pid"
start_stop_daemon_args="--args-for-start-stop-daemon"
command_background="yes"


#init_daemon
depend() {
        need net
}

start_pre() {
        checkpath --directory --owner $command_user:$command_user --mode 0775 \
                /run/$RC_SVCNAME /var/log/$RC_SVCNAME
}

start_service() {
	todo
}

stop_service() {
	todo
}

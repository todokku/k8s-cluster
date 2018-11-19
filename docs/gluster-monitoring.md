
# Monitoring GlusterFS with prometheus and Telegraf

1. **Installation**
	1. Prometheus Installation
Download prometheus from https://prometheus.io/download/ .
Running prometheus binary to start it. Aborting with CTRL+C will exit the program.
Configuring scrape configs in prometheus.yml to read metrics from telegraf and node_exporter

	2. Telegraf Installation Installing telegraf via apt-get Repo should be added to apt 
	```
	curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
	source /etc/lsb-release
	echo "deb https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
	apt-get update && sudo apt-get install telegraf
	```
     3. Node_Exporter (Optional)
Download Node_exporter from https://prometheus.io/download/#node_exporter
Running Node_exporter binary to start it. Aborting with CTRL+C will exit the program.

2. **Run as Service with SystemD**
	1.  Run Prometheus as Service To run prometheus permanently you have to make it run as service Easiest way is make a service file to run binary with systemd:
	```
	[Unit]
	Description=Prometheus
	Wants=network-online.target
	After=network-online.target

	[Service]
	User=root
	Group=root
	Type=simple
	ExecStart=/PATH/TO/PROMETHEUS/prometheus \
	    --config.file /PATH/TO/PROMETHEUS/prometheus.yml \
	    --storage.tsdb.path /var/lib/prometheus/data \
	    --FLAGS    
	            [Install]
	            WantedBy=multi-user.target
	```
	Some flags and their usage listed here https://prometheus.io/docs/prometheus/latest/migration/#flags
	
	2. Run Node_Exporter as Service 
	Same as Prometheus
	
3. **Collect Metrics**
	1. Collect Generic metrics with nodeExporter or Telegraf
By default Node_exporter and Telegraf collect some generic metric like:
CPU, RAM, Disk, etc. But they are unable to collect glusterfs directory usage.

	2. Collect directories usage with telegraf

	* We use exec method in telegraf combined with bash script to get size of directories in glusterfs. Also we have to enable prometheus output in telegraf.conf
	* To collect directory usage we use this oneline script with telegraf exec module.
	* `du -d1 /opt/storage/k8s-volumes  |sed -e "s/\/opt\/storage\/k8s-volumes\///g" |awk '{print "storage_per_ns,ns="$2  " value="$1}'`

4. **Add collected metrics to dashboard**
	* Metrics collected by prometheus on glusterfs server is the datasource to the grafana dashboard, which use its queries to visualize metrics.
	* This sample query in grafana dashboard is getting total disk usage by a namespace which is equal to /opt/storage/{directory} : storage_per_ns{host="Fandogh-k8s-gluster1",ns=~"$ns"}

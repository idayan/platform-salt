# Change Log
All notable changes to this project will be documented in this file.

## [Unreleased]
### Changed
 - PNDA-2284: hdfs-cleaner creates the archive container it needs
 
## [1.0.1] 2016-10-31
### Fixed
 - PNDA-2368: Include console-backend 0.2.2 to fix version of the redis-parser npm module to 2.0.4

## [1.0.0] 2016-10-21
### Added
- Multi-flavor mechanism, with pico flavor
- PNDA-2320 Kafka manager port is now in pillar
- PNDA-2272 review formulas in order to ensure no issue on deployment even if there is not all roles
- PNDA-2233 Jupyter notebook plugin added to deployment manager

### Fixed
- Some logs were not in /var/log/pnda and so, were not shipped to the logserver
- The 'bulk' directory in HDFS is now owned by the 'pnda' user
- Prevent Gobblin from ingesting internal kafka __consumer_offsets topic

### Changed
- ntp:servers pillar default was removed, but can still be set

## [0.2.0] 2016-09-07
### Added
- Install Jupyter-Spark extension
- Add default Grafana dashboards for PNDA metrics
- PNDA-2010 Create Graphite datasource
- Add a simple minimal notebook to explain basic Jupyter usage
- Create PNDA OpenTSDB default datasource in Grafana
- PNDA-820 Added graphite formula to salt

### Fixed
- PNDA-2022 Re-raise exceptions from cm_setup for fail fast behaviour
- PNDA-2009 Tell upstart to not log console output of data-logger
- PNDA-1933 CM setup waits on cloudera manager being available
- Do not use http download for cloudera manager
- Clean ups to Grafana states
- Clean ups to OpenTSDB states
- Clean ups to Jupyter states

### Changed
- PNDA-2012 Update to Grafana 3.1.1
- PNDA-1485 Update OpenTSDB to 2.2.0
- PNDA-2016 Update Zookeeper to 3.4.6
- Update Kafka Manager to 1.3.1.6
- Update Kafka to 0.10.0.1
- Use saltenv instead of env in anticipation of upcoming Salt Boron
- Automatically set test topic replication based on broker cluster size
- Make the pnda user home directory configurable
- For AWS, launch PNDA on private network
- PNDA-1923 Add the yarn daemon and application logs to logserver
- PNDA-2005 Add a state that creates a PNDA test topic on Kafka instead of using KM 

## [0.1.0] 2016-07-01
### First version
- Creates and configures all PNDA services

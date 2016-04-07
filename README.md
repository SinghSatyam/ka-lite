# ka-lite-scripts
Scripts for setting up ka-lite & Magogenie

Following are the steps to be followed:
- In the scripts folder, run 
```sh
$ ./script_1.sh
```
- Run the following command once first script is completed and follow the steps:
```sh
$ sudo kalite manage setup
```
- In the scripts folder, run the second script:
```sh
$ ./script_2.sh
```
At this moment, following are installed and configured:
- git
- vlc
- python
- nginx
- devscripts
-  debhelper
-  hostapd
-  dnsmasq
-  ka-lite (using pip)
-  nginx configuration is done for serving static assets

- In the scripts folder, run the third script which installs the docker:
```sh
$ ./script_3.sh
```

- In the scripts folder, run the fourth script which pulls the postgres container from dockerhub:
```sh
$ ./script_4.sh
```
Note: You will need credentials for pulling image from dockerhub.


----------


# Optional
You may want to install TeamViewer for remote debugging. For that, In the scripts folder, run the `setup_teamviewer.sh` :
```sh
$ ./setup_teamviewer.sh
```

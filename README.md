# Calibre GUI and Server

Run the Calibre X app accessible in a web browser

This container is forked from aptalca/docker-rdp-calibre (https://github.com/aptalca/docker-rdp-calibre), primarily to use a custom dockergui as a base that doesn't include guacamole.

## Install On unRaid:

On unRaid, install from the Community Repositories and enter the app folder location and the port for the webUI.


## Install On Other Platforms (like Ubuntu, Synology 5.2 DSM, etc.):

On other platforms, you can run this docker with the following command:

```
docker run -d --name="RDP-Calibre" -e EDGE="0" -e WIDTH="1280" -e HEIGHT="720" -v /path/to/config:/config:rw -e TZ=America/New_York -p YYYY:8080 aptalca/docker-rdp-calibre
```

### Setup Instructions
- This fork removes the built in guacamole implementation.  It is intended for a setup where you have a seperate guacamole implementation.  My implementation has a guacamole and a guacd container, with an nginx container that provides access to it.
- Make sure that your guacamole/guacd containers are on the same docker network as your RDP-Calibre container, and you can connect to port 3389 on that container for RDP access.
- Replace the variable "/path/to/config" with your choice of folder on your system. That is where the config and the library files will reside, and they will survive an update, reinstallation, etc. of the container.
- Change "YYYY" to a port of your choice, it will be the port for the Calibre webserver
- If you would like to have the latest updates, change the EDGE variable to "1", and the container will update calibre to the latest version every time it is restarted
- If you'd like to change the resolution for the GUI, you can modify the WIDTH and HEIGHT variables
- IMPORTANT: On first start, select "/config" as the library location in the Calibre wizard
- Calibre webserver can be enabled from the calibre gui under Preferences/Sharing over the net. **Port has to be set to 8080**

You can access the Calibre webserver by pointing your web browser to http://SERVERIP:YYYY

(Replace SERVERIP and YYYY with your values)

### Advanced Features (only for docker pros)
#### Custom library location:
If you would like to change the library location you need to do a couple of things:
- First add a new mount point for the library location in the docker run command. Example: -v /path/to/library:/library:rw
- Then add an environment variable (LIBRARYINTERNALPATH) to specify the internal library location for the webserver. Example: -e LIBRARYINTERNALPATH="/library"
- When you fire up calibre the first time select your library location. Example: /library  

#### (Deprecated)Url Prefix for reverse proxy:
- Add an environment variable (URLPREFIX) to docker run to specify the url prefix for the webserver. Example: -e URLPREFIX="/calibre"
- To access the webserver, go to http://SERVERIP:YYYY/calibre

### Changelog:
+ **2018-03-01:** LIBRARYINTERNALPATH is still used to select your path as the default library.  URLPREFIX variable is deprecated. It was required for the calibre webserver. The new webserver should be enabled from the calibre gui under Preferences/Sharing over the net. **Port has to be set to 8080**
+ **2016-09-16:** Remove X1-lock if exists, which prevents start up following an unclean shutdown
+ **2016-09-15:** Updated base to x11rdp1.3, which now supports clipboard through the left hand side menu (ctrl+alt+shift) - calibre updated to 2.67

# MinecraftServerWatcher
This program is a Minecraft Server Watcher script that continuously runs your Minecraft server. If the server stops for any reason, the script automatically restarts it after a short delay, ensuring the server remains online. Additionally, it prevents multiple instances of the watcher from running simultaneously.
```bat
::=== Configuration ===
set "JAVA_PATH=C:\Java\jdk-21\bin\java.exe"
set "JAVA_OPTIONS=-Xms1G -Xmx1G"
set "JAR_FILE=server-release.jar"
set "SERVER_TITLE=Minecraft Server"
set "RESTART_DELAY=10"

:: Use a fixed lock-file
set "LOCK_FILE=.\mc_watcher_server-release.pid"
```

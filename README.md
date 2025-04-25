# ROS2 Run Commands (rosrc)

## ROS2 Jazzy-Jalisco Setup 

I've condensed the complete basic setup into an one-liner named ros-installer.sh that does everything for you. Next, YKWTD:

```
wget -O - https://raw.githubusercontent.com/uniquetrij/rosrc/refs/heads/main/ros-installer.sh | sh
```
Or if you have prefer `curl` and have it installed:
```
curl -s https://raw.githubusercontent.com/uniquetrij/rosrc/refs/heads/main/ros-installer.sh | sh
```

### `TL;DR` Installation Notes:

* Installation requires `sudo` privilages.

* Installs ROS2 __Jazzy-Jalisco__ at `/opt/ros/jazzy`

* ROS2 packages may be built in both __python__ and __c++__. Installs Miniconda at `/opt/miniconda3` which is used as the default python venv manager.

* Installs a python venv named __jazzy__ at `/opt/miniconda3/envs/jazzy` 

* Customises the bash shell:

    * Installs [rosrc](./rosrc), a collection of useful alias shortcuts for commonly used ROS2 commands, under the user's home directory as `~/.rosrc`. This makes getting started extremely quick.

    * Installs [extrc](https://github.com/uniquetrij/bashrc-extensions/extrc), a collection of custom bash utility functions, under the user's home directory as `~/.extrc`, that I commonly use while working with ubuntu-terminal. Eg. `mkcd` that combines `mkdir` and `cd` into a single command.

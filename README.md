# rosrc

This repo is for shell configuration for managing ROS2 worksapces, and short aliases of frequently used `ros2` commands.   

Add the following code to your ~/.bashrc
```bash
# >>> ros initialize >>>
rosactivate() {
    if [ -f ./install/local_setup.bash ]; then
        echo "[ok] ros workspace detected, reconfiguring symlink"
        rm -f ~/ros2_ws
        ln -s $(pwd -P) ~/ros2_ws
        echo "[ok]" $(ls -l --color=always ~/ros2_ws | awk '/->/ {print $9, $10, $11}')
        if [ ! -f ~/.rosrc ]; then
            wget --no-check-certificate --content-disposition https://raw.githubusercontent.com/uniquetrij/rosrc/refs/heads/main/rosrc -O ~/.rosrc
        fi
        echo "[ok] symlink created, sourcing ~/.rosrc"
        source ~/.rosrc
        echo "[ok] ros workspace activated"
    else
        if [ ! "$1" == "--quite" ]; then
            echo "[fail] no ros workspace detected, please run 'rosinit' to initialize a new workspace"
        fi
        
    fi
}

rosinit() {
    if [ ! -f ./install/local_setup.bash ]; then
        colcon build >> /dev/null 2>&1
        mkdir src
        echo "[ok] ros workspace created"
        rosactivate
    else
        echo "[fail] ros workspace already exists, please run 'rosactivate' to activate it"
    fi
}

rosactivate --quite
# <<< ros initialize <<<
```

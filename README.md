# arch-simple
Automatically install arch

This is a script aiming to help install ArchLinux in the least painful way. Initially, it started as a project for 
personal use, but I quickly realized that it could be helpful for others, too: 
Simply download the <code>auto.sh</code> script in a usb, boot the live iso and run it. So far, you can
install KDE, Gnome and a preconfigured as well as a default DWM (listed as DWM-MOST and DWM-CORE respectively). More options are soon to be added. 

**Usage**

* Burn the iso image to a usb stick as you normally would
* Download the <code>auto.sh</code> script and copy it to another usb stick
* Plug both sticks to the computer you want to install Arch to and boot to the live environment
* Mount the second stick and navigate to its contents
* Run the downloaded script: <code>./auto.sh</code>. 

Remember that the script, as is, will completely overwrite the contents of the drive named <code>/dev/sda</code>. To change that, simply edit the script and replace every occurance
of <code>sda</code> to the drive letter of your choice. For instance, to install in <code>/dev/sdb</code>, the command in vim would be <code>:%s/sda/sdb/g</code>.
Once the script gets going, you will only have to intervene a couple of times to confirm a command and to enter your password. Once the installation is finished, your computer will reboot
and boot into the newly installed system.

**Input fields**

 The first three input fields are self explanatory. Input your desired user name, user and root passwords. 
 
 Then, you will have to input your timezone. Remember to type the full name of the timezone. For example: <code>Europe/Athens</code>. 
 
 Same goes for the kernel. There is no default, but if you are unsure, simply use the regular one: <code>linux</code>.
 
 Then pick a Desktop Environment, Window Manager out of the supported selections. E.g. <code>KDE</code>.
 
 Finally, choose the countries in which the program will look for the fastest mirrors. In most cases, the optimal choices are countries close to your geographical location.
 Example: <code>Germany,France,Belgium</code>. Do not use spaces or quotation marks.
 
   **KDE**

 This is the default plasma desktop. Konsole and dolphin are the only apps installed.

 **GNOME**
 
 Much like KDE, this installs the default Gnome desktop. Mind that gnome-terminal doesn't seem to work with the default

 locale, so I added konsole to its download list. Use it to change to your locale and fix the default terminal, then uninstall it, if you want.

 **DWM-MOST features**
 
 This was the primary reason I created this script. It creates an environment almost equivalent to that of my daily use. Therefore, it is ideal for someone who        wants to try dwm in a virtual machine

 without having to go through the process of configuring it. 

 Open the terminal with <code>ctrl_shift_t</code>. View useful aliases and commands in <code>bashrc</code>. View the dwm

 configuration with <code>dwmc</code>. The default text editor is vim. Session starts automatically after login.

 **DWM-CORE**

 You can also install a plain DWM. The usual shortcuts and configurations apply. After login, run <code>startx</code> to begin the session

 **Important:** Currently, the script only works for UEFI systems.
**Important:** Currently, the script only works for UEFI systems.
 
 

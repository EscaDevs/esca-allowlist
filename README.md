# esca-allowlist
# To open the menu /allowlist


                 ESCA - Allowlist v1.0
    - Allowlist in game panel.
    - 3 separate authorization options for manager accounts.
    - Quickly add allowlist.
    - See Allowlist list.
    - Allowlist deletion.
    - Search option in Allowlist.

Welcome to ESCA DEVS,
Free and Paid scripts.
Here you can find the best for your server.
If you have any problems or suggestions.
We are doing raffles on discord!
Don't forgot to join our discord.

[DISCORD](https://discord.gg/2urvDbHRRD)

# IMAGE
![image](https://user-images.githubusercontent.com/107806100/174495852-f8f14edb-bbef-4322-9063-c259e0ab4c33.png)
#
![image](https://user-images.githubusercontent.com/107806100/174495877-e90a9d07-063e-4762-ae1a-2d4361756c81.png)
#
![image](https://user-images.githubusercontent.com/107806100/174495879-b1d92deb-6ffc-4c14-9d48-730a12fc6f8e.png)

SQL                

    CREATE TABLE IF NOT EXISTS `allowlist` (
      `hex` varchar(50) DEFAULT NULL,
      `nickname` varchar(50) DEFAULT NULL,
      `adminname` varchar(50) DEFAULT NULL,
      `lastonline` varchar(50) DEFAULT 'Unknown'
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;


    CREATE TABLE IF NOT EXISTS `allowlist_admin` (
      `username` varchar(50) DEFAULT NULL,
      `password` varchar(50) DEFAULT NULL,
      `admin_name` varchar(50) DEFAULT NULL,
      `auth` enum('added','remove','all') DEFAULT 'added'
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;


    INSERT INTO `allowlist_admin` (`username`, `password`, `admin_name`, `auth`) VALUES
      ('owner', 'owner', 'Owner', 'all'),
      ('admin', 'admin', 'Admin', 'added');
    

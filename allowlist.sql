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
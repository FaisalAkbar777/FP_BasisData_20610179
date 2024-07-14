-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 14, 2024 at 09:02 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dataperkuliahan`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilkan_dosen` ()   BEGIN
    SELECT * FROM dosen;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilkan_mahasiswa_ps_mk` (`id_ps` INT, `id_mk` INT)   BEGIN
    IF id_ps IS NULL OR id_mk IS NULL THEN
        SELECT 'parameter tidak boleh kosong' AS pesan;
    ELSE
        SELECT mh.nama, mh.nim
        FROM mahasiswa AS mh
        JOIN mengambil AS m ON mh.id_mahasiswa = m.id_mahasiswa
        WHERE mh.id_program_studi = id_ps AND m.id_mata_kuliah = id_mk;
    END IF;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `jumlah_mahasiswa_mk` (`id_mk` INT, `id_ps` INT) RETURNS INT(11)  BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total 
    FROM mengambil AS m
    JOIN mahasiswa AS mh ON m.id_mahasiswa = mh.id_mahasiswa
    WHERE m.id_mata_kuliah = id_mk AND mh.id_program_studi = id_ps;
    RETURN total;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `total_dosen` () RETURNS INT(11)  BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM dosen;
    RETURN total;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `dosen`
--

CREATE TABLE `dosen` (
  `id_dosen` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `jenis_kelamin` enum('Laki-laki','Perempuan') DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dosen`
--

INSERT INTO `dosen` (`id_dosen`, `nama`, `jenis_kelamin`, `tanggal_lahir`) VALUES
(1, 'Ahmad Luffy', 'Laki-laki', '1980-01-01'),
(2, 'Cindy Oktaviani Dewi', 'Perempuan', '1990-02-02'),
(3, 'Cindy Putri', 'Perempuan', '1989-03-03'),
(4, 'Wahyu Basudara', 'Laki-laki', '1985-04-04'),
(5, 'Veronica Bunga', 'Perempuan', '1995-05-05');

-- --------------------------------------------------------

--
-- Stand-in structure for view `horizontal_view`
-- (See below for the actual view)
--
CREATE TABLE `horizontal_view` (
`id_mahasiswa` int(11)
,`nama_mahasiswa` varchar(100)
,`nim` varchar(20)
,`tanggal_lahir_mahasiswa` date
,`nama_program` varchar(100)
);

-- --------------------------------------------------------

--
-- Table structure for table `kelas`
--

CREATE TABLE `kelas` (
  `id_kelas` int(11) NOT NULL,
  `id_dosen` int(11) DEFAULT NULL,
  `id_mata_kuliah` int(11) DEFAULT NULL,
  `ruangan` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `log_mahasiswa`
--

CREATE TABLE `log_mahasiswa` (
  `id` int(11) NOT NULL,
  `id_mahasiswa` int(11) DEFAULT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `nim` varchar(20) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `id_program_studi` int(11) DEFAULT NULL,
  `aksi` varchar(20) DEFAULT NULL,
  `tanggal` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `log_mahasiswa`
--

INSERT INTO `log_mahasiswa` (`id`, `id_mahasiswa`, `nama`, `nim`, `tanggal_lahir`, `id_program_studi`, `aksi`, `tanggal`) VALUES
(1, 6, 'Alexander Wahyu', '20610002', '2001-02-03', 1, 'AFTER INSERT', '2024-07-14 06:22:50'),
(2, 6, 'Alexander Wahyu', '20610002', '2001-02-03', 1, 'BEFORE UPDATE', '2024-07-14 06:26:42'),
(3, 6, 'Cindy Cantika', '20610002', '2001-02-03', 1, 'AFTER UPDATE', '2024-07-14 06:26:42'),
(4, 6, 'Cindy Cantika', '20610002', '2001-02-03', 1, 'BEFORE DELETE', '2024-07-14 06:27:34'),
(5, 6, 'Cindy Cantika', '20610002', '2001-02-03', 1, 'AFTER DELETE', '2024-07-14 06:27:34'),
(6, 2, 'Asep Suresep', '20110101', '2002-01-01', 1, 'BEFORE UPDATE', '2024-07-14 06:46:56'),
(7, 2, 'Dadang Padang', '20110101', '2002-01-01', 1, 'AFTER UPDATE', '2024-07-14 06:46:56'),
(8, 7, 'Cecep', '20202020', NULL, NULL, 'AFTER INSERT', '2024-07-14 06:48:32');

-- --------------------------------------------------------

--
-- Table structure for table `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `id_mahasiswa` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `nim` varchar(20) DEFAULT NULL,
  `id_program_studi` int(11) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mahasiswa`
--

INSERT INTO `mahasiswa` (`id_mahasiswa`, `nama`, `nim`, `id_program_studi`, `tanggal_lahir`) VALUES
(1, 'Windah Basudara', '20610001', 2, '2002-08-17'),
(2, 'Dadang Padang', '20110101', 1, '2002-01-01'),
(3, 'Agus Suragus', '20542020', 3, '2001-02-02'),
(4, 'Slamet Wahyu', '20445011', 3, '2002-11-11'),
(5, 'Slamet Ulang Tahun', '20330303', 4, '2001-03-30'),
(7, 'Cecep', '20202020', NULL, NULL);

--
-- Triggers `mahasiswa`
--
DELIMITER $$
CREATE TRIGGER `after_delete_mahasiswa` AFTER DELETE ON `mahasiswa` FOR EACH ROW BEGIN
    INSERT INTO log_mahasiswa (id_mahasiswa, nama, nim, tanggal_lahir, id_program_studi, aksi)
    VALUES (OLD.id_mahasiswa, OLD.nama, OLD.nim, OLD.tanggal_lahir, OLD.id_program_studi, 'AFTER DELETE');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_mahasiswa` AFTER INSERT ON `mahasiswa` FOR EACH ROW BEGIN
    INSERT INTO log_mahasiswa (id_mahasiswa, nama, nim, tanggal_lahir, id_program_studi, aksi)
    VALUES (NEW.id_mahasiswa, NEW.nama, NEW.nim, NEW.tanggal_lahir, NEW.id_program_studi, 'AFTER INSERT');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_mahasiswa` AFTER UPDATE ON `mahasiswa` FOR EACH ROW BEGIN
    INSERT INTO log_mahasiswa (id_mahasiswa, nama, nim, tanggal_lahir, id_program_studi, aksi)
    VALUES (NEW.id_mahasiswa, NEW.nama, NEW.nim, NEW.tanggal_lahir, NEW.id_program_studi, 'AFTER UPDATE');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_delete_mahasiswa` BEFORE DELETE ON `mahasiswa` FOR EACH ROW BEGIN
    INSERT INTO log_mahasiswa (id_mahasiswa, nama, nim, tanggal_lahir, id_program_studi, aksi)
    VALUES (OLD.id_mahasiswa, OLD.nama, OLD.nim, OLD.tanggal_lahir, OLD.id_program_studi, 'BEFORE DELETE');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_insert_mahasiswa` BEFORE INSERT ON `mahasiswa` FOR EACH ROW BEGIN
    DECLARE nim_count INT;
    SELECT COUNT(*) INTO nim_count FROM mahasiswa WHERE nim = NEW.nim;
    IF nim_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'NIM sudah ada.';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_update_mahasiswa` BEFORE UPDATE ON `mahasiswa` FOR EACH ROW BEGIN
    INSERT INTO log_mahasiswa (id_mahasiswa, nama, nim, tanggal_lahir, id_program_studi, aksi)
    VALUES (OLD.id_mahasiswa, OLD.nama, OLD.nim, OLD.tanggal_lahir, OLD.id_program_studi, 'BEFORE UPDATE');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `mahasiswa_program_studi`
-- (See below for the actual view)
--
CREATE TABLE `mahasiswa_program_studi` (
`id_mahasiswa` int(11)
,`nama` varchar(100)
,`id_program_studi` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `mahasiswa_program_studi_check`
-- (See below for the actual view)
--
CREATE TABLE `mahasiswa_program_studi_check` (
`id_mahasiswa` int(11)
,`nama` varchar(100)
,`id_program_studi` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `mata_kuliah`
--

CREATE TABLE `mata_kuliah` (
  `id_mata_kuliah` int(11) NOT NULL,
  `nama_mata_kuliah` varchar(100) DEFAULT NULL,
  `sks` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mata_kuliah`
--

INSERT INTO `mata_kuliah` (`id_mata_kuliah`, `nama_mata_kuliah`, `sks`) VALUES
(1, 'Pemrograman Basis Data', 4),
(2, 'Manajemen Strategik', 2),
(3, 'IoT', 4),
(4, 'Bahasa Inggris', 2),
(5, 'Matematika Terapan', 4);

-- --------------------------------------------------------

--
-- Table structure for table `mengambil`
--

CREATE TABLE `mengambil` (
  `id_mahasiswa` int(11) NOT NULL,
  `id_mata_kuliah` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mengambil`
--

INSERT INTO `mengambil` (`id_mahasiswa`, `id_mata_kuliah`) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 3),
(5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `program_studi`
--

CREATE TABLE `program_studi` (
  `id_program_studi` int(11) NOT NULL,
  `nama_program` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `program_studi`
--

INSERT INTO `program_studi` (`id_program_studi`, `nama_program`) VALUES
(1, 'Teknik Informatika'),
(2, 'Sistem Informasi'),
(3, 'Ekonomi'),
(4, 'Hukum'),
(5, 'Teknik Sipil');

-- --------------------------------------------------------

--
-- Stand-in structure for view `vertical_view`
-- (See below for the actual view)
--
CREATE TABLE `vertical_view` (
`nama` varchar(100)
,`nim` varchar(20)
);

-- --------------------------------------------------------

--
-- Structure for view `horizontal_view`
--
DROP TABLE IF EXISTS `horizontal_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `horizontal_view`  AS SELECT `m`.`id_mahasiswa` AS `id_mahasiswa`, `m`.`nama` AS `nama_mahasiswa`, `m`.`nim` AS `nim`, `m`.`tanggal_lahir` AS `tanggal_lahir_mahasiswa`, `ps`.`nama_program` AS `nama_program` FROM (((`mahasiswa` `m` join `program_studi` `ps` on(`m`.`id_program_studi` = `ps`.`id_program_studi`)) join `mengambil` `mg` on(`m`.`id_mahasiswa` = `mg`.`id_mahasiswa`)) join `mata_kuliah` `mk` on(`mg`.`id_mata_kuliah` = `mk`.`id_mata_kuliah`)) ;

-- --------------------------------------------------------

--
-- Structure for view `mahasiswa_program_studi`
--
DROP TABLE IF EXISTS `mahasiswa_program_studi`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mahasiswa_program_studi`  AS SELECT `mahasiswa`.`id_mahasiswa` AS `id_mahasiswa`, `mahasiswa`.`nama` AS `nama`, `mahasiswa`.`id_program_studi` AS `id_program_studi` FROM `mahasiswa` WHERE `mahasiswa`.`id_program_studi` = 1 ;

-- --------------------------------------------------------

--
-- Structure for view `mahasiswa_program_studi_check`
--
DROP TABLE IF EXISTS `mahasiswa_program_studi_check`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mahasiswa_program_studi_check`  AS SELECT `mahasiswa_program_studi`.`id_mahasiswa` AS `id_mahasiswa`, `mahasiswa_program_studi`.`nama` AS `nama`, `mahasiswa_program_studi`.`id_program_studi` AS `id_program_studi` FROM `mahasiswa_program_studi`WITH CASCADED CHECK OPTION  ;

-- --------------------------------------------------------

--
-- Structure for view `vertical_view`
--
DROP TABLE IF EXISTS `vertical_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vertical_view`  AS SELECT `mahasiswa`.`nama` AS `nama`, `mahasiswa`.`nim` AS `nim` FROM `mahasiswa` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dosen`
--
ALTER TABLE `dosen`
  ADD PRIMARY KEY (`id_dosen`);

--
-- Indexes for table `kelas`
--
ALTER TABLE `kelas`
  ADD PRIMARY KEY (`id_kelas`),
  ADD KEY `idx_dosen_mk` (`id_dosen`,`id_mata_kuliah`);

--
-- Indexes for table `log_mahasiswa`
--
ALTER TABLE `log_mahasiswa`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`id_mahasiswa`),
  ADD KEY `id_program_studi` (`id_program_studi`),
  ADD KEY `idx_nama_program` (`nama`,`id_program_studi`);

--
-- Indexes for table `mata_kuliah`
--
ALTER TABLE `mata_kuliah`
  ADD PRIMARY KEY (`id_mata_kuliah`);

--
-- Indexes for table `mengambil`
--
ALTER TABLE `mengambil`
  ADD PRIMARY KEY (`id_mahasiswa`,`id_mata_kuliah`),
  ADD KEY `id_mata_kuliah` (`id_mata_kuliah`),
  ADD KEY `idx_mhs_mk` (`id_mahasiswa`,`id_mata_kuliah`);

--
-- Indexes for table `program_studi`
--
ALTER TABLE `program_studi`
  ADD PRIMARY KEY (`id_program_studi`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dosen`
--
ALTER TABLE `dosen`
  MODIFY `id_dosen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `kelas`
--
ALTER TABLE `kelas`
  MODIFY `id_kelas` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `log_mahasiswa`
--
ALTER TABLE `log_mahasiswa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  MODIFY `id_mahasiswa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `mata_kuliah`
--
ALTER TABLE `mata_kuliah`
  MODIFY `id_mata_kuliah` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `program_studi`
--
ALTER TABLE `program_studi`
  MODIFY `id_program_studi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD CONSTRAINT `mahasiswa_ibfk_1` FOREIGN KEY (`id_program_studi`) REFERENCES `program_studi` (`id_program_studi`);

--
-- Constraints for table `mengambil`
--
ALTER TABLE `mengambil`
  ADD CONSTRAINT `mengambil_ibfk_1` FOREIGN KEY (`id_mahasiswa`) REFERENCES `mahasiswa` (`id_mahasiswa`),
  ADD CONSTRAINT `mengambil_ibfk_2` FOREIGN KEY (`id_mata_kuliah`) REFERENCES `mata_kuliah` (`id_mata_kuliah`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

--
-- Prosedur
--
CREATE DEFINER=`root`@`%` PROCEDURE `trx_check_point` ()   BEGIN

START TRANSACTION;

INSERT INTO pasien (nama_pasien, jenis_kelamin, alamat_pasien) VALUES ("Kiki", "L", "Subang");
SAVEPOINT POINT1;

INSERT INTO pasien (nama_pasien, jenis_kelamin, alamat_pasien) VALUES ("Galih", "L", "Simpar");
ROLLBACK TO POINT1;

INSERT INTO pasien (nama_pasien, jenis_kelamin, alamat_pasien) VALUES ("Rudi", "L", "Jakarta");
COMMIT;


SELECT * FROM pasien;


END$$

CREATE DEFINER=`root`@`%` PROCEDURE `trx_commit` ()   BEGIN

START TRANSACTION;

INSERT INTO pasien (nama_pasien, jenis_kelamin, alamat_pasien) VALUES ("Jono", "L", "Subang");


SELECT * FROM pasien;
COMMIT;


END$$

CREATE DEFINER=`root`@`%` PROCEDURE `trx_rollback` ()   BEGIN
START TRANSACTION;

UPDATE pasien SET nama_pasien = "Kudin" WHERE id_pasien = 10;
ROLLBACK;

COMMIT;
SELECT * FROM pasien;

END$$

DELIMITER ;

--
-- Struktur dari tabel `obat`
--

CREATE TABLE `obat` (
  `id_obat` int(11) NOT NULL,
  `kode_obat` varchar(5) NOT NULL,
  `nama_obat` varchar(30) NOT NULL,
  `harga` int(10) NOT NULL,
  `stok` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi_obat`
--

CREATE TABLE `transaksi_obat` (
  `id_transaksi` int(11) NOT NULL,
  `id_pasien` int(11) NOT NULL,
  `id_obat` int(11) NOT NULL,
  `jumlah` int(10) NOT NULL,
  `total_harga` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Trigger `transaksi_obat`
--
DELIMITER $$
CREATE TRIGGER `tg_jual` BEFORE INSERT ON `transaksi_obat` FOR EACH ROW UPDATE obat SET stok = stok - new.jumlah WHERE id_obat = new.id_obat
$$
DELIMITER ;

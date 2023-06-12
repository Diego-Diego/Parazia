CREATE TABLE `avaible_aeronef` (
  `id` int(11) NOT NULL,
  `model` varchar(255) NOT NULL,
  `label` varchar(50) NOT NULL,
  `price` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `avaible_aeronef`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `avaible_aeronef`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

-- Part 2

CREATE TABLE `owned_aeronef` (
  `id` int(11) NOT NULL,
  `license` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `props` text NOT NULL,
  `outside` int(11) NOT NULL DEFAULT '0',
  `ownedAt` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `owned_aeronef`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `owned_aeronef`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

INSERT INTO `avaible_aeronef` (`id`, `model`, `label`, `price`) VALUES
(1, 'alphaz1', 'Alpha Z1', 500000),
(2, 'Frogger', 'Frogger', 750000),
(3, 'Maverick', 'Maverick', 740000),
(4, 'Supervolito2', 'Supervolito', 760000),
(5, 'Swift2', 'Swift', 800000),
(6, 'Volatus', 'Volatus', 815000),
(7, 'Cuban800', 'Cuban', 400000),
(8, 'Dodo', 'Dodo', 700000),
(9, 'Duster', 'Duster', 320000),
(10, 'Luxor2', 'Luxor', 2500000),
(11, 'Velum', 'Velum', 500000),
(12, 'Vestra', 'Vestra', 450000);
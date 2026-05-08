-- Tabla: vendedores
-- Origen: Sistema de RRHH (simulación SQL Server)
-- Curso Herramientas de Visualización de Datos · Central Perk Global

CREATE TABLE vendedores (
    id_vendedor   INT NOT NULL PRIMARY KEY,
    nombre        NVARCHAR(120) NOT NULL,
    equipo        NVARCHAR(50) NOT NULL,
    supervisor    NVARCHAR(120) NOT NULL,
    pais          NVARCHAR(50) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    activo        BIT NOT NULL
);

INSERT INTO vendedores VALUES (5000, N'Alberto Andrés Bolívar', N'Mañana', N'Adalberto Luis Hinojosa', N'Estados Unidos', '2024-04-07', 1);
INSERT INTO vendedores VALUES (5001, N'María Beatriz Hurtado', N'Noche', N'Eduar Pérez', N'Estados Unidos', '2019-03-31', 1);
INSERT INTO vendedores VALUES (5002, N'Heather Cruz', N'Noche', N'Eduar Pérez', N'Estados Unidos', '2022-07-31', 1);
INSERT INTO vendedores VALUES (5003, N'Ciriaco Andrade Puente', N'Noche', N'Adalberto Luis Hinojosa', N'Estados Unidos', '2020-04-03', 1);
INSERT INTO vendedores VALUES (5004, N'Adán Lloret Tejero', N'Fin de semana', N'Adalberto Luis Hinojosa', N'Estados Unidos', '2021-03-30', 1);
INSERT INTO vendedores VALUES (5005, N'Zeferino Silvano Burgos Duarte', N'Noche', N'Adalberto Luis Hinojosa', N'Estados Unidos', '2024-07-13', 1);
INSERT INTO vendedores VALUES (5006, N'Salma Solís Matías', N'Tarde', N'Adalberto Luis Hinojosa', N'Estados Unidos', '2024-08-05', 1);
INSERT INTO vendedores VALUES (5007, N'Leidy Dolly Duarte Prieto', N'Fin de semana', N'Adalberto Luis Hinojosa', N'Estados Unidos', '2025-01-06', 1);
INSERT INTO vendedores VALUES (5008, N'Rolando Leal', N'Mañana', N'Adalberto Luis Hinojosa', N'Estados Unidos', '2020-09-16', 1);
INSERT INTO vendedores VALUES (5009, N'María Cristina Reyna Ulibarri', N'Mañana', N'Eduar Pérez', N'Estados Unidos', '2024-09-23', 1);
INSERT INTO vendedores VALUES (5010, N'Eloy Partida', N'Tarde', N'Eduar Pérez', N'Estados Unidos', '2023-02-15', 1);
INSERT INTO vendedores VALUES (5011, N'Eliecer Gerardo Narváez', N'Mañana', N'Adalberto Luis Hinojosa', N'Estados Unidos', '2024-06-08', 1);
INSERT INTO vendedores VALUES (5012, N'Eutimio Peralta Landa', N'Noche', N'Adalberto Luis Hinojosa', N'Estados Unidos', '2025-01-29', 1);
INSERT INTO vendedores VALUES (5013, N'Mónica Gaitán', N'Tarde', N'Eduar Pérez', N'Estados Unidos', '2023-11-15', 1);
INSERT INTO vendedores VALUES (5014, N'Eduardo Corredor Delgado', N'Noche', N'Eduar Pérez', N'Estados Unidos', '2023-04-30', 1);
INSERT INTO vendedores VALUES (5015, N'Patricia Elena Vásquez', N'Noche', N'Eduar Pérez', N'Estados Unidos', '2019-05-10', 1);
INSERT INTO vendedores VALUES (5016, N'Vinicio Marco Marquez', N'Mañana', N'Adalberto Luis Hinojosa', N'Estados Unidos', '2022-01-14', 1);
INSERT INTO vendedores VALUES (5017, N'Cecilia Agustí Tenorio', N'Tarde', N'Adalberto Luis Hinojosa', N'Estados Unidos', '2022-01-09', 1);
INSERT INTO vendedores VALUES (5018, N'Ale Escobar', N'Noche', N'Eduar Pérez', N'Estados Unidos', '2023-08-02', 1);
INSERT INTO vendedores VALUES (5019, N'Alberto Carnero Villa', N'Mañana', N'Adalberto Luis Hinojosa', N'Estados Unidos', '2022-03-09', 0);
INSERT INTO vendedores VALUES (5020, N'Jesús Sebastián Carvajal', N'Mañana', N'Bernardo Rolando Velázquez', N'México', '2020-01-29', 1);
INSERT INTO vendedores VALUES (5021, N'Jairo Ramón Bonilla', N'Tarde', N'Amy Young', N'México', '2021-03-26', 1);
INSERT INTO vendedores VALUES (5022, N'Jos Nicolás Samaniego', N'Mañana', N'Bernardo Rolando Velázquez', N'México', '2023-09-23', 1);
INSERT INTO vendedores VALUES (5023, N'Nilda Sarmiento Ochoa', N'Tarde', N'Amy Young', N'México', '2019-08-03', 1);
INSERT INTO vendedores VALUES (5024, N'Alexis Fernando Durán Pérez', N'Noche', N'Bernardo Rolando Velázquez', N'México', '2023-04-22', 1);
INSERT INTO vendedores VALUES (5025, N'Zoé Salcido Padrón', N'Mañana', N'Bernardo Rolando Velázquez', N'México', '2020-07-03', 1);
INSERT INTO vendedores VALUES (5026, N'Constanza Olivé Ordóñez', N'Noche', N'Amy Young', N'México', '2024-01-07', 1);
INSERT INTO vendedores VALUES (5027, N'Jeremy Knight', N'Noche', N'Bernardo Rolando Velázquez', N'México', '2022-09-01', 1);
INSERT INTO vendedores VALUES (5028, N'Bianca Maya Jáquez', N'Mañana', N'Amy Young', N'México', '2021-03-30', 1);
INSERT INTO vendedores VALUES (5029, N'Maura del Guillén', N'Fin de semana', N'Bernardo Rolando Velázquez', N'México', '2020-03-21', 0);
INSERT INTO vendedores VALUES (5030, N'Jorge Cruz', N'Fin de semana', N'Amy Young', N'México', '2022-05-26', 1);
INSERT INTO vendedores VALUES (5031, N'Fredy Enrique Duarte', N'Mañana', N'Amy Young', N'México', '2024-10-08', 1);
INSERT INTO vendedores VALUES (5032, N'Feliciana Murillo Barreda', N'Tarde', N'Amy Young', N'México', '2025-02-28', 1);
INSERT INTO vendedores VALUES (5033, N'Eliseo Iniesta Castrillo', N'Noche', N'Amy Young', N'México', '2023-12-04', 1);
INSERT INTO vendedores VALUES (5034, N'Rebekah York', N'Mañana', N'Bernardo Rolando Velázquez', N'México', '2021-11-18', 0);
INSERT INTO vendedores VALUES (5035, N'Myriam Acevedo', N'Noche', N'Bernardo Rolando Velázquez', N'México', '2021-10-11', 1);
INSERT INTO vendedores VALUES (5036, N'Dary Rocío Trujillo Arias', N'Mañana', N'Bernardo Rolando Velázquez', N'México', '2023-08-02', 1);
INSERT INTO vendedores VALUES (5037, N'Ana Yury Valderrama', N'Noche', N'Amy Young', N'México', '2024-02-27', 1);
INSERT INTO vendedores VALUES (5038, N'Aristides Loreto Rincón Vélez', N'Fin de semana', N'Bernardo Rolando Velázquez', N'México', '2019-12-02', 1);
INSERT INTO vendedores VALUES (5039, N'Saúl Gómez', N'Mañana', N'Bernardo Rolando Velázquez', N'México', '2023-01-02', 1);
INSERT INTO vendedores VALUES (5040, N'Inés Matías Zepeda', N'Noche', N'Daniel Ford', N'Colombia', '2021-03-04', 1);
INSERT INTO vendedores VALUES (5041, N'Sara Johnson', N'Noche', N'Daniel Ford', N'Colombia', '2020-02-18', 1);
INSERT INTO vendedores VALUES (5042, N'Anderson Antonio Tovar Ramírez', N'Mañana', N'Daniel Ford', N'Colombia', '2023-05-11', 1);
INSERT INTO vendedores VALUES (5043, N'Kevin Briggs', N'Mañana', N'Daniel Ford', N'Colombia', '2025-03-05', 1);
INSERT INTO vendedores VALUES (5044, N'Rocío Arcelia Saucedo Solorio', N'Noche', N'Daniel Ford', N'Colombia', '2023-02-28', 1);
INSERT INTO vendedores VALUES (5045, N'Isabela Durán Bernal', N'Mañana', N'Daniel Ford', N'Colombia', '2021-03-10', 1);
INSERT INTO vendedores VALUES (5046, N'Tammy Petty', N'Fin de semana', N'Daniel Ford', N'Colombia', '2022-12-12', 1);
INSERT INTO vendedores VALUES (5047, N'Iker Verdejo', N'Mañana', N'Daniel Ford', N'Colombia', '2023-05-15', 1);
INSERT INTO vendedores VALUES (5048, N'Román Torres-Cerezo', N'Tarde', N'María Zepeda Archuleta', N'Colombia', '2022-02-04', 1);
INSERT INTO vendedores VALUES (5049, N'Molly Lopez', N'Mañana', N'María Zepeda Archuleta', N'Colombia', '2025-03-14', 1);
INSERT INTO vendedores VALUES (5050, N'Sabas Barriga Aramburu', N'Mañana', N'María Zepeda Archuleta', N'Colombia', '2021-07-19', 1);
INSERT INTO vendedores VALUES (5051, N'Eliseo Palacios Castellanos', N'Mañana', N'María Zepeda Archuleta', N'Colombia', '2020-06-06', 1);
INSERT INTO vendedores VALUES (5052, N'Remigio Estevez Correa', N'Noche', N'Daniel Ford', N'Colombia', '2024-06-15', 1);
INSERT INTO vendedores VALUES (5053, N'Tina Turner', N'Mañana', N'Daniel Ford', N'Colombia', '2023-08-14', 1);
INSERT INTO vendedores VALUES (5054, N'Pedro Diego Maldonado Sánchez', N'Tarde', N'Daniel Ford', N'Colombia', '2023-01-02', 1);
INSERT INTO vendedores VALUES (5055, N'Luz Orozco', N'Fin de semana', N'Daniel Ford', N'Colombia', '2021-10-18', 1);
INSERT INTO vendedores VALUES (5056, N'Tatiana Salas López', N'Fin de semana', N'María Zepeda Archuleta', N'Colombia', '2020-09-11', 1);
INSERT INTO vendedores VALUES (5057, N'Daniel del Garcia', N'Fin de semana', N'María Zepeda Archuleta', N'Colombia', '2020-05-07', 1);
INSERT INTO vendedores VALUES (5058, N'Julia Cox', N'Tarde', N'María Zepeda Archuleta', N'Colombia', '2021-08-17', 1);
INSERT INTO vendedores VALUES (5059, N'Kristin Olson', N'Mañana', N'Daniel Ford', N'Colombia', '2025-04-15', 1);
INSERT INTO vendedores VALUES (5060, N'Reyes Bermúdez Otero', N'Noche', N'Ramiro Héctor Salgado', N'España', '2019-12-24', 1);
INSERT INTO vendedores VALUES (5061, N'Miguel Ángel Rosselló', N'Tarde', N'Ramiro Héctor Salgado', N'España', '2022-08-22', 1);
INSERT INTO vendedores VALUES (5062, N'Camila Caro Angulo', N'Mañana', N'Robert Brown', N'España', '2025-04-15', 1);
INSERT INTO vendedores VALUES (5063, N'Adela María Luisa Soliz', N'Fin de semana', N'Robert Brown', N'España', '2021-04-28', 1);
INSERT INTO vendedores VALUES (5064, N'Carlota Barbara Colón Valencia', N'Noche', N'Robert Brown', N'España', '2022-01-20', 1);
INSERT INTO vendedores VALUES (5065, N'Mark Williams', N'Tarde', N'Ramiro Héctor Salgado', N'España', '2021-03-02', 1);
INSERT INTO vendedores VALUES (5066, N'Felipe Iván Bautista Pinto', N'Tarde', N'Ramiro Héctor Salgado', N'España', '2021-05-07', 1);
INSERT INTO vendedores VALUES (5067, N'Aurelio Villanueva Arguello', N'Noche', N'Robert Brown', N'España', '2023-06-28', 1);
INSERT INTO vendedores VALUES (5068, N'Jasmine Brewer', N'Noche', N'Ramiro Héctor Salgado', N'España', '2024-03-20', 1);
INSERT INTO vendedores VALUES (5069, N'Brittany Flores', N'Mañana', N'Ramiro Héctor Salgado', N'España', '2019-11-23', 1);
INSERT INTO vendedores VALUES (5070, N'Joseph Scott', N'Fin de semana', N'Ramiro Héctor Salgado', N'España', '2025-05-15', 1);
INSERT INTO vendedores VALUES (5071, N'Victoria Elisa Quintero', N'Tarde', N'Ramiro Héctor Salgado', N'España', '2021-08-11', 1);
INSERT INTO vendedores VALUES (5072, N'Mitchell Harrison', N'Fin de semana', N'Robert Brown', N'España', '2022-05-27', 1);
INSERT INTO vendedores VALUES (5073, N'Teodora Milla', N'Tarde', N'Robert Brown', N'España', '2019-05-09', 1);
INSERT INTO vendedores VALUES (5074, N'Cody Lopez', N'Noche', N'Ramiro Héctor Salgado', N'España', '2024-01-03', 1);
INSERT INTO vendedores VALUES (5075, N'Karen Smith', N'Noche', N'Robert Brown', N'España', '2022-04-10', 1);
INSERT INTO vendedores VALUES (5076, N'Stiven Jorge Estrada Álvarez', N'Fin de semana', N'Robert Brown', N'España', '2025-04-03', 1);
INSERT INTO vendedores VALUES (5077, N'Francisco Rafael Posada', N'Fin de semana', N'Robert Brown', N'España', '2023-10-15', 1);
INSERT INTO vendedores VALUES (5078, N'Sergio Benítez', N'Tarde', N'Ramiro Héctor Salgado', N'España', '2022-11-21', 1);
INSERT INTO vendedores VALUES (5079, N'Rebecca Trujillo', N'Fin de semana', N'Ramiro Héctor Salgado', N'España', '2022-05-30', 1);
INSERT INTO vendedores VALUES (5080, N'Diana Marcela Meneses Silva', N'Fin de semana', N'Diana Rivera', N'Argentina', '2019-09-20', 1);
INSERT INTO vendedores VALUES (5081, N'Alfonso Flavio Valenzuela Carrillo', N'Noche', N'Brayan Ruiz', N'Argentina', '2023-09-04', 1);
INSERT INTO vendedores VALUES (5082, N'Edilson Farid Vélez', N'Mañana', N'Diana Rivera', N'Argentina', '2020-08-13', 1);
INSERT INTO vendedores VALUES (5083, N'Brandon Pearson', N'Mañana', N'Brayan Ruiz', N'Argentina', '2020-09-27', 0);
INSERT INTO vendedores VALUES (5084, N'Edwin Gómez', N'Noche', N'Brayan Ruiz', N'Argentina', '2019-08-10', 1);
INSERT INTO vendedores VALUES (5085, N'Mercedes de Valbuena', N'Tarde', N'Diana Rivera', N'Argentina', '2023-08-10', 1);
INSERT INTO vendedores VALUES (5086, N'René Orozco', N'Mañana', N'Diana Rivera', N'Argentina', '2019-09-29', 1);
INSERT INTO vendedores VALUES (5087, N'Adrián Reyes Polo', N'Noche', N'Diana Rivera', N'Argentina', '2022-10-02', 1);
INSERT INTO vendedores VALUES (5088, N'Diego Cózar Flores', N'Fin de semana', N'Brayan Ruiz', N'Argentina', '2022-05-27', 1);
INSERT INTO vendedores VALUES (5089, N'Miguel Ángel Bernabé Almaraz Montañez', N'Tarde', N'Diana Rivera', N'Argentina', '2025-05-12', 1);
INSERT INTO vendedores VALUES (5090, N'Tere Villanueva-Hervia', N'Mañana', N'Diana Rivera', N'Argentina', '2024-11-24', 1);
INSERT INTO vendedores VALUES (5091, N'Carmelita Uría Carlos', N'Fin de semana', N'Brayan Ruiz', N'Argentina', '2019-01-05', 1);
INSERT INTO vendedores VALUES (5092, N'Michael Soto', N'Noche', N'Brayan Ruiz', N'Argentina', '2023-05-11', 1);
INSERT INTO vendedores VALUES (5093, N'Silvano Agustín Hernádez', N'Mañana', N'Diana Rivera', N'Argentina', '2019-12-26', 0);
INSERT INTO vendedores VALUES (5094, N'Terri Wheeler', N'Tarde', N'Brayan Ruiz', N'Argentina', '2021-08-11', 1);
INSERT INTO vendedores VALUES (5095, N'Carolina Galvis', N'Noche', N'Brayan Ruiz', N'Argentina', '2024-01-07', 1);
INSERT INTO vendedores VALUES (5096, N'Vanessa Janeth Pérez Pedraza', N'Noche', N'Diana Rivera', N'Argentina', '2019-12-18', 1);
INSERT INTO vendedores VALUES (5097, N'María Silva Sánchez', N'Fin de semana', N'Diana Rivera', N'Argentina', '2019-03-05', 1);
INSERT INTO vendedores VALUES (5098, N'Tiffany James', N'Mañana', N'Brayan Ruiz', N'Argentina', '2022-10-11', 1);
INSERT INTO vendedores VALUES (5099, N'Martha Cecilia Montes', N'Fin de semana', N'Brayan Ruiz', N'Argentina', '2021-04-30', 0);
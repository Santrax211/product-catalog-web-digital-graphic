-- Script para insertar los productos reales del importador
-- Ejecutar después de 001-create-products-table.sql

-- Limpiar datos de ejemplo
DELETE FROM products;
DELETE FROM categories;

-- Usar columnas correctas: id, nombre (sin slug ni description)
INSERT INTO categories (id, nombre) VALUES
  (1, 'Cabezales, Adaptadores y Descifrado'),
  (2, 'Amortiguadores'),
  (3, 'Estaciones de Sellado'),
  (4, 'Filtros'),
  (5, 'Encoders'),
  (6, 'Bombas');

-- Reset sequence
SELECT setval('categories_id_seq', 6);

-- Usar columnas correctas: nombre, codigo_modelo, categoria_id, descripcion, imagen_url
-- CATEGORÍA 1: CABEZALES, ADAPTADORES Y DESCIFRADO
INSERT INTO products (nombre, codigo_modelo, categoria_id, descripcion, imagen_url) VALUES
-- Cabezales EPSON
('Cabezal de Impresión EPSON I1600-A1', 'A01', 1, 'Base agua', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión EPSON I1600-E1', 'A02', 1, 'Eco-solvente', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión EPSON I1600-U1', 'A03', 1, 'UV', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión EPSON I3200-A1', 'A04', 1, 'Base agua', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión EPSON I3200-E1', 'A05', 1, 'Eco-solvente', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión EPSON I3200-U1', 'A06', 1, 'UV', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión EPSON S3200', 'A07', 1, 'Industrial alta velocidad', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión EPSON T3200-U3', 'A08', 1, '4 colores / UV', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión EPSON XP600', 'A09', 1, 'Original / Económico', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión I3200(8)-A1HD', 'A10', 1, 'Alta definición (HD)', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión I3200(8)-U1HD', 'A11', 1, 'Alta definición (HD) UV', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión EPSON F186', 'A12', 1, 'Original', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión EPSON F191110', 'A13', 1, '10 colores', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión EPSON FA06090', 'A14', 1, 'Original', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión EPSON FA12110', 'A15', 1, 'Original', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión EPSON F189000', 'A16', 1, 'Original', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión EPSON F196000', 'A17', 1, 'Original', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión EPSON 3620 F13003', 'A18', 1, 'Original', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión EPSON 4720', 'A19', 1, 'Para sublimación / textil', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión EPSON XP600 Reacondicionado', 'A21', 1, 'Segunda mano / Reacondicionado', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión EPSON 1390', 'A22', 1, 'F173090', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión EPSON TX800', 'A23', 1, 'Original', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión EPSON 5113', 'A24', 1, 'Original', '/placeholder.svg?height=300&width=300'),
-- Cabezales ROLAND
('Cabezal de Impresión ROLAND DX4', 'A25', 1, 'Eco-solvente / Solvente', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión ROLAND VS640 DX7', 'A26', 1, 'Original', '/placeholder.svg?height=300&width=300'),
-- Cabezales KONICA
('Cabezal de Impresión KONICA 512 14PL', 'A27', 1, 'MH (Medium)', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión KONICA 512 42PL', 'A28', 1, 'LH (Low)', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión KONICA 512i 14PL', 'A29', 1, 'MAB-C', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión KONICA HS1000', 'A30', 1, 'Original', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión KONICA REVO-E SHB', 'A31', 1, 'Original', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión KONICA REVO-H', 'A32', 1, 'Original', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión KONICA 512 14PL MN', 'A33', 1, 'MN (Manual)', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión KONICA 512 42PL LN', 'A34', 1, 'LN (Manual)', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión KONICA 512i 30PL', 'A35', 1, 'LNB', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión KONICA 1024 14PL', 'A36', 1, 'MHB', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión KONICA 1024a', 'A37', 1, 'SHE', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión KONICA 1024i', 'A38', 1, '13PL (6988H)', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión KONICA HS2000', 'A39', 1, 'Original', '/placeholder.svg?height=300&width=300'),
-- Cabezales MIMAKI
('Cabezal de Impresión MIMAKI JV5 JV33', 'A40', 1, 'Original', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión MIMAKI TS34', 'A41', 1, 'M010792', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión MIMAKI TX300/TS300', 'A42', 1, 'M015885', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión MIMAKI JV150/JV300', 'A43', 1, 'M015372', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión MIMAKI M010010', 'A44', 1, 'Original', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión MIMAKI GEN5', 'A45', 1, 'MP-M022650 / M012639', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión MIMAKI M018821', 'A46', 1, 'Original', '/placeholder.svg?height=300&width=300'),
-- Cabezales MUTOH
('Cabezal de Impresión MUTOH 1638', 'A47', 1, 'DX7', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión MUTOH 1604', 'A48', 1, 'Green head original', '/placeholder.svg?height=300&width=300'),
-- Cabezales SEIKO
('Cabezal de Impresión SEIKO 510 35PL', 'A49', 1, 'Original', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión SEIKO 510 50PL', 'A50', 1, 'Original', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión SEIKO 508GS', 'A51', 1, 'Original', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión SEIKO 1020', 'A52', 1, 'Original', '/placeholder.svg?height=300&width=300'),
-- Cabezales XAAR
('Cabezal de Impresión XAAR 128 80W', 'A53', 1, 'Púrpura', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión XAAR 128 40L', 'A54', 1, 'Gris oscuro', '/placeholder.svg?height=300&width=300'),
-- Cabezales STARFIRE
('Cabezal de Impresión STARFIRE SG1024-SA', 'A55', 1, '10PL', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión STARFIRE SG1024-SA2C', 'A56', 1, '10PL', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión STARFIRE SG1024-XSA', 'A57', 1, '7PL', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión STARFIRE SG1024-MA', 'A58', 1, '25PL', '/placeholder.svg?height=300&width=300'),
-- Cabezales RICOH
('Cabezal de Impresión RICOH GH2220', 'A61', 1, 'Original', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión RICOH GN4', 'A62', 1, 'Original', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión RICOH GN5', 'A63', 1, 'Original', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión RICOH GN6', 'A64', 1, 'Original', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión RICOH G5i', 'A65', 1, 'Original', '/placeholder.svg?height=300&width=300'),
-- Cabezales KYOCERA
('Cabezal de Impresión KYOCERA KJ4B-0300', 'A66', 1, 'Original', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión KYOCERA KJ4B-QA', 'A67', 1, 'Original', '/placeholder.svg?height=300&width=300'),
-- Cabezales SPECTRA
('Cabezal de Impresión SPECTRA PQ15 512', 'A73', 1, '15PL', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión SPECTRA PQ35 512', 'A74', 1, '35PL', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión SPECTRA SM128', 'A75', 1, 'Original', '/placeholder.svg?height=300&width=300'),
-- Cabezales TOSHIBA, BROTHER
('Cabezal de Impresión TOSHIBA CE4M', 'A76', 1, 'Original', '/placeholder.svg?height=300&width=300'),
('Cabezal de Impresión BROTHER GZA', 'A77', 1, 'Original', '/placeholder.svg?height=300&width=300'),
-- Tarjetas de descifrado
('Tarjeta Descifrado 4720 Single Decoder', 'A79', 1, 'Decodificador simple', '/placeholder.svg?height=300&width=300'),
('Tarjeta Descifrado 4720 2nd Decoder', 'A80', 1, 'Decodificador 2da gen', '/placeholder.svg?height=300&width=300'),
('Tarjeta Descifrado 5113 Decoder', 'A84', 1, 'Original', '/placeholder.svg?height=300&width=300'),
('Tarjeta Transferencia Hoson 4720 to I3200', 'A88', 1, 'Tarjeta de conversión', '/placeholder.svg?height=300&width=300'),
-- Tapas de cabezal
('Tapa de Cabezal Original I3200-A1', 'A91', 1, 'Mainfolder', '/placeholder.svg?height=300&width=300'),
('Tapa de Cabezal DX5 Waterbased', 'A92', 1, 'Mainfolder (Base agua)', '/placeholder.svg?height=300&width=300'),
('Tapa de Cabezal DX5 Solvent', 'A93', 1, 'Mainfolder (Solvente)', '/placeholder.svg?height=300&width=300');

-- CATEGORÍA 2: AMORTIGUADORES (DAMPERS)
INSERT INTO products (nombre, codigo_modelo, categoria_id, descripcion, imagen_url) VALUES
('Damper I3200 Original', 'B01', 2, 'Para cabezal I3200 base agua', '/placeholder.svg?height=300&width=300'),
('Damper I3200 Original UV', 'B02', 2, 'Para cabezal I3200 tintas UV', '/placeholder.svg?height=300&width=300'),
('Damper JV33', 'B03', 2, 'Inserción directa', '/placeholder.svg?height=300&width=300'),
('Damper JV33 UV', 'B04', 2, 'Negro (UV)', '/placeholder.svg?height=300&width=300'),
('Damper JV33 Screw', 'B05', 2, 'Con rosca', '/placeholder.svg?height=300&width=300'),
('Damper TX800', 'B06', 2, 'Original', '/placeholder.svg?height=300&width=300'),
('Damper JV33 Pointy', 'B07', 2, 'Punta larga', '/placeholder.svg?height=300&width=300'),
('Damper DX5 Big Square', 'B10', 2, 'Transparente', '/placeholder.svg?height=300&width=300'),
('Damper DX5 Big White', 'B11', 2, 'Blanco', '/placeholder.svg?height=300&width=300'),
('Damper DX5 Big Round', 'B13', 2, 'Conector redondo', '/placeholder.svg?height=300&width=300'),
('Damper DX5 Small Square', 'B15', 2, 'Formato pequeño', '/placeholder.svg?height=300&width=300'),
('Damper 7910', 'B19', 2, 'Presión negativa tornillo', '/placeholder.svg?height=300&width=300'),
('Damper DX7 Big', 'B23', 2, 'Presión negativa', '/placeholder.svg?height=300&width=300'),
('Damper DX7 Small', 'B25', 2, 'Formato pequeño', '/placeholder.svg?height=300&width=300'),
('Damper 4880 / 7880', 'B29', 2, 'Inserción directa', '/placeholder.svg?height=300&width=300'),
('Damper Ricoh GH2220', 'B35', 2, 'Original', '/placeholder.svg?height=300&width=300'),
('Damper Mimaki JV300/JV150', 'B37', 2, 'Original', '/placeholder.svg?height=300&width=300');

-- CATEGORÍA 3: ESTACIONES DE SELLADO (CAPTOPS)
INSERT INTO products (nombre, codigo_modelo, categoria_id, descripcion, imagen_url) VALUES
('Captop DX5 Vertical', 'C01', 3, 'Original', '/placeholder.svg?height=300&width=300'),
('Captop DX5 Allwin', 'C02', 3, 'Original', '/placeholder.svg?height=300&width=300'),
('Captop DX5 Middle Hole', 'C05', 3, 'Orificio central', '/placeholder.svg?height=300&width=300'),
('Captop Cyber DX5/DX7', 'C08', 3, 'Sistema elevación', '/placeholder.svg?height=300&width=300'),
('Captop Galaxy DX5', 'C13', 3, 'Original', '/placeholder.svg?height=300&width=300'),
('Captop Thunderjet DX5', 'C16', 3, 'Original', '/placeholder.svg?height=300&width=300'),
('Captop I3200 Horizontal', 'C18', 3, 'Para serie I3200', '/placeholder.svg?height=300&width=300'),
('Captop I3200 Vertical', 'C20', 3, 'Para serie I3200', '/placeholder.svg?height=300&width=300'),
('Captop I3200 Cap-top', 'C25', 3, 'Original', '/placeholder.svg?height=300&width=300'),
('Captop XP600 Horizontal', 'C28', 3, 'Para serie XP600', '/placeholder.svg?height=300&width=300'),
('Captop XP600 Lift', 'C29', 3, 'Sistema elevación', '/placeholder.svg?height=300&width=300'),
('Captop TX800/XP600', 'C34', 3, 'Crash captop', '/placeholder.svg?height=300&width=300'),
('Captop Roland DX4 Black', 'C39', 3, 'Tubo negro', '/placeholder.svg?height=300&width=300'),
('Captop Roland DX4 White', 'C40', 3, 'Tubo blanco', '/placeholder.svg?height=300&width=300'),
('Captop Mimaki DX4', 'C43', 3, 'Original', '/placeholder.svg?height=300&width=300');

-- CATEGORÍA 4: FILTROS
INSERT INTO products (nombre, codigo_modelo, categoria_id, descripcion, imagen_url) VALUES
('Filtro de disco PALL LCF-11100', 'D01', 4, '6um de precisión', '/placeholder.svg?height=300&width=300'),
('Filtro de disco PALL LCF-12100', 'D02', 4, '10um de precisión', '/placeholder.svg?height=300&width=300'),
('Filtro de disco PALL LCF-13100', 'D03', 4, '20um de precisión', '/placeholder.svg?height=300&width=300'),
('Filtro de disco PALL 4225', 'D04', 4, '0.2um de precisión', '/placeholder.svg?height=300&width=300'),
('Filtro de disco PALL LCF-59400', 'D05', 4, 'Filtro de alta capacidad', '/placeholder.svg?height=300&width=300'),
('Filtro de disco PALL LCF-22110', 'D06', 4, '10um de precisión', '/placeholder.svg?height=300&width=300'),
('Filtro de disco PALL LCF-23110', 'D07', 4, '20um de precisión', '/placeholder.svg?height=300&width=300'),
('Módulo de desgasificación UDM-41110PT1', 'D08', 4, 'PALL original (Degas Module)', '/placeholder.svg?height=300&width=300'),
('Columna de desgasificación UDM-21110', 'D09', 4, 'PALL original (Degas Module)', '/placeholder.svg?height=300&width=300'),
('Filtro de cápsula PALL Blanco Codo', 'D10', 4, 'Blanco con codo (Bent)', '/placeholder.svg?height=300&width=300'),
('Filtro de cápsula PALL MACA0507', 'D11', 4, '5um de precisión (Cápsula)', '/placeholder.svg?height=300&width=300'),
('Filtro de cápsula PALL Negro Codo', 'D12', 4, 'Negro con codo (Bent)', '/placeholder.svg?height=300&width=300'),
('Filtro de cápsula PALL Negro Recto', 'D13', 4, 'Negro con punta recta (Straight)', '/placeholder.svg?height=300&width=300'),
('Filtro PALL SCDF-2112-JCH', 'D14', 4, 'Especial para sistemas solventes', '/placeholder.svg?height=300&width=300'),
('Filtro de disco PALL Mariposa', 'D15', 4, 'Forma de mariposa (Butterfly) 10um', '/placeholder.svg?height=300&width=300'),
('Filtro original ASSY MP-M022219', 'D16', 4, 'Color negro (ASSY Black)', '/placeholder.svg?height=300&width=300'),
('Filtro de cápsula Corbett', 'D17', 4, 'Alta resistencia', '/placeholder.svg?height=300&width=300'),
('Filtro de disco UV', 'D18', 4, '4.5cm de diámetro (Para UV)', '/placeholder.svg?height=300&width=300'),
('Filtro de disco blanco', 'D19', 4, '4.5cm de diámetro', '/placeholder.svg?height=300&width=300'),
('Filtro de disco UV negro', 'D20', 4, '4.5cm de diámetro (Para UV)', '/placeholder.svg?height=300&width=300'),
('Filtro de cápsula PALL Blanco Recto', 'D21', 4, 'Blanco con punta recta', '/placeholder.svg?height=300&width=300'),
('Filtro Starfire', 'D22', 4, 'Para cabezales Starfire', '/placeholder.svg?height=300&width=300'),
('Filtro cilíndrico largo', 'D23', 4, 'Cuerpo transparente', '/placeholder.svg?height=300&width=300'),
('Filtro cilíndrico largo UV', 'D24', 4, 'Cuerpo negro (Especial UV)', '/placeholder.svg?height=300&width=300');

-- CATEGORÍA 5: ENCODERS
INSERT INTO products (nombre, codigo_modelo, categoria_id, descripcion, imagen_url) VALUES
('Lector de encoder H9730/H9740/9720', 'E01', 5, 'Sensor óptico estándar', '/placeholder.svg?height=300&width=300'),
('Lector de encoder Allwin H9730', 'E02', 5, 'Sensor para máquinas Allwin', '/placeholder.svg?height=300&width=300'),
('Lector de encoder Aifa H9730', 'E03', 5, 'Sensor óptico compatible Aifa', '/placeholder.svg?height=300&width=300'),
('Lector Roland VS640', 'E04', 5, 'Sensor original Roland', '/placeholder.svg?height=300&width=300'),
('Sensor con cable H9730', 'E05', 5, 'Con cable de datos incluido', '/placeholder.svg?height=300&width=300'),
('Sensor con cable H9731', 'E06', 5, 'Con cable de datos incluido', '/placeholder.svg?height=300&width=300'),
('Sensor Challenger H9730', 'E07', 5, 'Para máquinas Challenger', '/placeholder.svg?height=300&width=300'),
('Soporte de encoder', 'E08', 5, 'Soporte físico para la cinta', '/placeholder.svg?height=300&width=300'),
('Cinta Encoder 150 LPI', 'X1', 5, 'Longitudes: 2500mm a 7000mm', '/placeholder.svg?height=300&width=300'),
('Cinta Encoder 180 LPI', 'X2', 5, 'Longitudes: 2500mm a 7000mm', '/placeholder.svg?height=300&width=300'),
('Cinta Encoder 360 LPI', 'X3', 5, 'Longitudes: 2500mm a 7000mm', '/placeholder.svg?height=300&width=300'),
('Cinta Encoder 200 LPI', 'X4', 5, 'Longitud: 7000mm', '/placeholder.svg?height=300&width=300');

-- CATEGORÍA 6: BOMBAS
INSERT INTO products (nombre, codigo_modelo, categoria_id, descripcion, imagen_url) VALUES
('Bomba de tinta JNF 3W', 'F01', 6, 'Potencia 3 vatios', '/placeholder.svg?height=300&width=300'),
('Bomba de tinta JNF 7W', 'F02', 6, 'Potencia 7 vatios', '/placeholder.svg?height=300&width=300'),
('Bomba de tinta JYY 7W', 'F03', 6, 'Caudal 300-400ml/min', '/placeholder.svg?height=300&width=300'),
('Bomba de tinta JYY 3W', 'F04', 6, 'Caudal 100-200ml/min', '/placeholder.svg?height=300&width=300'),
('Bomba de tinta UV JYY Big', 'F05', 6, 'Bomba grande para tintas UV', '/placeholder.svg?height=300&width=300'),
('Bomba de aire JYY', 'F06', 6, 'Bomba de aire', '/placeholder.svg?height=300&width=300'),
('Bomba de tinta SYPDA 3W/7W', 'F07', 6, 'Opciones de 3W o 7W', '/placeholder.svg?height=300&width=300'),
('Bomba UV SYPDA', 'F09', 6, 'Especial para sistemas UV', '/placeholder.svg?height=300&width=300'),
('Bomba de tinta KHF 3W/7W', 'F09B', 6, 'Alta resistencia química', '/placeholder.svg?height=300&width=300'),
('Bomba peristáltica electrónica', 'F10', 6, 'Control electrónico de flujo', '/placeholder.svg?height=300&width=300'),
('Bomba para solventes HHJDKJ', 'F11', 6, 'Peristáltica para solventes', '/placeholder.svg?height=300&width=300'),
('Válvula solenoide JNF', 'F12', 6, 'Control de paso de tinta', '/placeholder.svg?height=300&width=300'),
('Válvula solenoide Modelo 1', 'F13', 6, 'Modelo genérico 1', '/placeholder.svg?height=300&width=300'),
('Válvula solenoide Modelo 2', 'F14', 6, 'Modelo genérico 2', '/placeholder.svg?height=300&width=300'),
('Válvula solenoide Modelo 3', 'F15', 6, 'Modelo genérico 3', '/placeholder.svg?height=300&width=300'),
('Válvula solenoide Modelo 4', 'F16', 6, 'Modelo genérico 4', '/placeholder.svg?height=300&width=300'),
('Estación de bombeo Epson L1800', 'F17', 6, 'Kit completo de bomba', '/placeholder.svg?height=300&width=300'),
('Estación de bombeo Epson 4880/7880', 'F18', 6, 'Kit completo de bomba', '/placeholder.svg?height=300&width=300'),
('Estación de bombeo Epson L7188/L7180', 'F19', 6, 'Kit completo de bomba', '/placeholder.svg?height=300&width=300'),
('Estación de bombeo Epson T5050/T6080', 'F20', 6, 'Kit completo de bomba', '/placeholder.svg?height=300&width=300'),
('Estación de bombeo Epson 1390', 'F21', 6, 'Kit completo de bomba', '/placeholder.svg?height=300&width=300'),
('Estación de bombeo Mimaki JV33/JV5', 'F22', 6, 'Kit completo de bomba', '/placeholder.svg?height=300&width=300'),
('Estación de bombeo Mutoh 1604', 'F23', 6, 'Kit completo de bomba', '/placeholder.svg?height=300&width=300'),
('Bomba de tinta en U', 'F24', 6, 'Diseño ergonómico en forma de U', '/placeholder.svg?height=300&width=300');

-- Habilitar RLS
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;

-- Políticas de lectura pública
CREATE POLICY "Permitir lectura pública de productos" ON products FOR SELECT USING (true);
CREATE POLICY "Permitir lectura pública de categorías" ON categories FOR SELECT USING (true);

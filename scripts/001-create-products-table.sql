-- Create categories table
CREATE TABLE IF NOT EXISTS categories (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create products table
CREATE TABLE IF NOT EXISTS products (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  codigo_modelo VARCHAR(100) NOT NULL,
  categoria_id INTEGER REFERENCES categories(id) ON DELETE SET NULL,
  descripcion TEXT,
  imagen_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insert sample categories
INSERT INTO categories (nombre) VALUES 
  ('Maquinaria Industrial'),
  ('Equipos de Construcción'),
  ('Herramientas Eléctricas'),
  ('Equipos de Soldadura');

-- Insert sample products
INSERT INTO products (nombre, codigo_modelo, categoria_id, descripcion, imagen_url) VALUES 
  ('Torno CNC Industrial', 'TCN-500X', 1, 'Torno CNC de alta precisión con control numérico avanzado. Ideal para trabajos de mecanizado de piezas metálicas con tolerancias mínimas.', '/placeholder.svg?height=400&width=400'),
  ('Fresadora Vertical', 'FRV-300', 1, 'Fresadora vertical con mesa de trabajo de 300x400mm. Motor de 3HP con velocidad variable.', '/placeholder.svg?height=400&width=400'),
  ('Excavadora Hidráulica', 'EXH-200', 2, 'Excavadora hidráulica de 20 toneladas con brazo extensible. Capacidad de excavación de hasta 6 metros.', '/placeholder.svg?height=400&width=400'),
  ('Retroexcavadora Compacta', 'REC-150', 2, 'Retroexcavadora compacta ideal para espacios reducidos. Motor diésel de alta eficiencia.', '/placeholder.svg?height=400&width=400'),
  ('Taladro de Columna', 'TDC-25', 3, 'Taladro de columna con mesa ajustable y motor de 1.5HP. Velocidad variable de 150 a 3000 RPM.', '/placeholder.svg?height=400&width=400'),
  ('Esmeriladora Angular', 'ESM-180', 3, 'Esmeriladora angular profesional de 180mm. Potencia de 2000W con sistema anti-vibración.', '/placeholder.svg?height=400&width=400'),
  ('Soldadora MIG/MAG', 'SMM-400', 4, 'Equipo de soldadura MIG/MAG con alimentador de alambre automático. Corriente de 50 a 400A.', '/placeholder.svg?height=400&width=400'),
  ('Soldadora Inverter TIG', 'SIT-250', 4, 'Soldadora inverter TIG/MMA con tecnología IGBT. Portátil y de alto rendimiento.', '/placeholder.svg?height=400&width=400');

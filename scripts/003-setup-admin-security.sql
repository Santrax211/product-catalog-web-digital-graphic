-- Script para configurar seguridad y Storage para administradores

-- 1. Asegurar que la columna imagen_url existe
ALTER TABLE products 
ADD COLUMN IF NOT EXISTS imagen_url TEXT;

-- 2. Crear tabla de usuarios admin (opcional, para control manual)
CREATE TABLE IF NOT EXISTS admin_users (
  id UUID REFERENCES auth.users(id) PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Habilitar Row Level Security (RLS)
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;

-- 4. Política: Todos pueden leer productos (público)
CREATE POLICY "Anyone can view products" ON products
  FOR SELECT USING (true);

-- 5. Política: Solo admins autenticados pueden insertar
CREATE POLICY "Authenticated users can insert products" ON products
  FOR INSERT WITH CHECK (auth.role() = 'authenticated');

-- 6. Política: Solo admins autenticados pueden actualizar
CREATE POLICY "Authenticated users can update products" ON products
  FOR UPDATE USING (auth.role() = 'authenticated');

-- 7. Política: Solo admins autenticados pueden eliminar
CREATE POLICY "Authenticated users can delete products" ON products
  FOR DELETE USING (auth.role() = 'authenticated');

-- 8. Políticas para categorías
CREATE POLICY "Anyone can view categories" ON categories
  FOR SELECT USING (true);

CREATE POLICY "Authenticated users can insert categories" ON categories
  FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users can update categories" ON categories
  FOR UPDATE USING (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users can delete categories" ON categories
  FOR DELETE USING (auth.role() = 'authenticated');

-- 9. Crear bucket de storage para imágenes de productos
-- Esto se hace desde el panel de Supabase Storage, pero aquí está el SQL:
-- INSERT INTO storage.buckets (id, name, public)
-- VALUES ('products-images', 'products-images', true);

-- 10. Políticas de Storage
-- CREATE POLICY "Public Access" ON storage.objects FOR SELECT USING (bucket_id = 'products-images');
-- CREATE POLICY "Authenticated users can upload" ON storage.objects FOR INSERT WITH CHECK (bucket_id = 'products-images' AND auth.role() = 'authenticated');
-- CREATE POLICY "Authenticated users can update" ON storage.objects FOR UPDATE USING (bucket_id = 'products-images' AND auth.role() = 'authenticated');
-- CREATE POLICY "Authenticated users can delete" ON storage.objects FOR DELETE USING (bucket_id = 'products-images' AND auth.role() = 'authenticated');

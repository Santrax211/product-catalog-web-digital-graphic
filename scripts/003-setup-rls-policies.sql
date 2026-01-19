-- Eliminar políticas existentes si existen
DROP POLICY IF EXISTS "Permitir lectura pública de productos" ON products;
DROP POLICY IF EXISTS "Permitir todo a usuarios autenticados en productos" ON products;
DROP POLICY IF EXISTS "Permitir lectura pública de categorías" ON categories;
DROP POLICY IF EXISTS "Permitir todo a usuarios autenticados en categorías" ON categories;

-- POLÍTICAS PARA PRODUCTS
-- Permitir lectura pública (para el catálogo web)
CREATE POLICY "Permitir lectura pública de productos"
ON products FOR SELECT
USING (true);

-- Permitir INSERT a usuarios autenticados
CREATE POLICY "Permitir inserción a usuarios autenticados"
ON products FOR INSERT
TO authenticated
WITH CHECK (true);

-- Permitir UPDATE a usuarios autenticados
CREATE POLICY "Permitir actualización a usuarios autenticados"
ON products FOR UPDATE
TO authenticated
USING (true)
WITH CHECK (true);

-- Permitir DELETE a usuarios autenticados
CREATE POLICY "Permitir eliminación a usuarios autenticados"
ON products FOR DELETE
TO authenticated
USING (true);

-- POLÍTICAS PARA CATEGORIES
-- Permitir lectura pública
CREATE POLICY "Permitir lectura pública de categorías"
ON categories FOR SELECT
USING (true);

-- Permitir INSERT a usuarios autenticados
CREATE POLICY "Permitir inserción de categorías a usuarios autenticados"
ON categories FOR INSERT
TO authenticated
WITH CHECK (true);

-- Permitir UPDATE a usuarios autenticados
CREATE POLICY "Permitir actualización de categorías a usuarios autenticados"
ON categories FOR UPDATE
TO authenticated
USING (true)
WITH CHECK (true);

-- Permitir DELETE a usuarios autenticados
CREATE POLICY "Permitir eliminación de categorías a usuarios autenticados"
ON categories FOR DELETE
TO authenticated
USING (true);

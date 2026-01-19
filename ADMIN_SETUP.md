# Sistema de Administración - Guía de Configuración

## ✅ Implementación Completada

Se ha implementado un sistema completo de administración con las siguientes características:

### 🔐 **Autenticación**
- Login de administrador en `/admin/login`
- Protección de rutas con middleware
- Gestión de sesiones con Supabase Auth

### 📊 **Panel de Administración**
- Dashboard con estadísticas en `/admin`
- Tabla de productos con búsqueda
- CRUD completo de productos

### 🖼️ **Gestión de Imágenes**
- Upload de imágenes a Supabase Storage
- Preview de imágenes en el formulario
- Eliminación automática de imágenes al borrar productos

---

## 🚀 Pasos para Activar el Sistema

### 1. Configurar Supabase Storage

Ve a tu proyecto en [Supabase Dashboard](https://supabase.com/dashboard):

#### a) Crear el Bucket
1. Ve a **Storage** en el menú lateral
2. Haz clic en **Create a new bucket**
3. Nombre: `products-images`
4. ✅ Marcar como **Public bucket**
5. Crear

#### b) Configurar Políticas de Seguridad
En el bucket `products-images`, ve a **Policies** y crea:

**Política 1 - Lectura Pública:**
```sql
CREATE POLICY "Public Access"
ON storage.objects FOR SELECT
USING (bucket_id = 'products-images');
```

**Política 2 - Upload Autenticados:**
```sql
CREATE POLICY "Authenticated Upload"
ON storage.objects FOR INSERT
WITH CHECK (bucket_id = 'products-images' AND auth.role() = 'authenticated');
```

**Política 3 - Update Autenticados:**
```sql
CREATE POLICY "Authenticated Update"
ON storage.objects FOR UPDATE
USING (bucket_id = 'products-images' AND auth.role() = 'authenticated');
```

**Política 4 - Delete Autenticados:**
```sql
CREATE POLICY "Authenticated Delete"
ON storage.objects FOR DELETE
USING (bucket_id = 'products-images' AND auth.role() = 'authenticated');
```

### 2. Configurar Base de Datos

Ve a **SQL Editor** y ejecuta:

```sql
-- Habilitar RLS en las tablas
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;

-- Políticas para products
CREATE POLICY "Anyone can view products" ON products
  FOR SELECT USING (true);

CREATE POLICY "Authenticated users can insert products" ON products
  FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users can update products" ON products
  FOR UPDATE USING (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users can delete products" ON products
  FOR DELETE USING (auth.role() = 'authenticated');

-- Políticas para categories
CREATE POLICY "Anyone can view categories" ON categories
  FOR SELECT USING (true);

CREATE POLICY "Authenticated users can insert categories" ON categories
  FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users can update categories" ON categories
  FOR UPDATE USING (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users can delete categories" ON categories
  FOR DELETE USING (auth.role() = 'authenticated');
```

### 3. Crear Usuario Administrador

Ve a **Authentication** > **Users**:

1. Haz clic en **Add user**
2. Email: `admin@digitalgraphic.com` (o tu email)
3. Password: (crea una contraseña segura)
4. ✅ Marcar **Auto Confirm User**
5. Crear usuario

### 4. Probar el Sistema

1. Inicia el servidor: `npm run dev`
2. Ve a: `http://localhost:3000/admin/login`
3. Inicia sesión con las credenciales creadas
4. ¡Deberías ver el panel de administración!

---

## 📁 Archivos Creados

### Páginas
- `/app/admin/login/page.tsx` - Login de administrador
- `/app/admin/page.tsx` - Dashboard principal
- `/app/admin/products/new/page.tsx` - Crear producto
- `/app/admin/products/[id]/page.tsx` - Editar producto
- `/app/admin/layout.tsx` - Layout del panel admin

### Componentes
- `/components/admin/products-table.tsx` - Tabla de productos
- `/components/admin/product-form.tsx` - Formulario de producto

### Lógica
- `/app/actions/products.ts` - Server actions para CRUD
- `/middleware.ts` - Protección de rutas

### Scripts
- `/scripts/003-setup-admin-security.sql` - Configuración de seguridad

---

## 🎯 Funcionalidades

### ✅ Implementadas
- [x] Login/Logout de administrador
- [x] Protección de rutas admin
- [x] Dashboard con estadísticas
- [x] Listar productos con búsqueda
- [x] Crear producto con imagen
- [x] Editar producto
- [x] Eliminar producto
- [x] Upload de imágenes a Storage
- [x] Preview de imágenes
- [x] Eliminación automática de imágenes

### 📊 Estadísticas del Dashboard
- Total de productos
- Número de categorías
- Productos con imagen

---

## 🔒 Seguridad

- ✅ Row Level Security (RLS) habilitado
- ✅ Solo usuarios autenticados pueden modificar datos
- ✅ Middleware protege rutas `/admin/*`
- ✅ Validación de sesión en cada request
- ✅ Storage público solo para lectura

---

## 💡 Uso

### Crear un Producto
1. Ve al dashboard admin
2. Clic en **Nuevo Producto**
3. Completa el formulario:
   - Nombre (obligatorio)
   - Código/Modelo
   - Categoría
   - Descripción
   - Imagen
4. Guarda

### Editar un Producto
1. En la tabla, clic en **Editar**
2. Modifica los campos necesarios
3. Cambia la imagen si lo deseas
4. Guarda cambios

### Eliminar un Producto
1. En la tabla, clic en **Eliminar**
2. Confirma la eliminación
3. El producto y su imagen se eliminan automáticamente

---

## ⚠️ Importante

1. **Copia de seguridad**: Haz backups regulares de tu base de datos
2. **Contraseñas seguras**: Usa contraseñas fuertes para admin
3. **Usuarios limitados**: Solo crea cuentas admin necesarias
4. **Monitoreo**: Revisa logs en Supabase Dashboard

---

## 🆘 Solución de Problemas

### No puedo iniciar sesión
- Verifica que el usuario existe en Authentication
- Verifica que las variables de entorno están configuradas
- Revisa la consola del navegador

### Las imágenes no se suben
- Verifica que el bucket `products-images` existe
- Verifica que el bucket es público
- Revisa las políticas de Storage

### Error "Supabase client not initialized"
- Verifica el archivo `.env.local`
- Asegúrate de tener `NEXT_PUBLIC_SUPABASE_URL` y `NEXT_PUBLIC_SUPABASE_ANON_KEY`

---

## 📞 Contacto

Para soporte adicional, contacta al desarrollador.

**DIGITAL GRAPHIC CORPORATION**
Reyven Jonathan Collantes Saldaña
+51 930 545 985

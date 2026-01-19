# Configuración de Supabase Storage para Imágenes de Productos

Sigue estos pasos en el panel de Supabase para configurar el almacenamiento de imágenes:

## 1. Crear el Bucket de Storage

1. Ve a tu proyecto en https://supabase.com
2. En el menú lateral, haz clic en **Storage**
3. Haz clic en **Create a new bucket**
4. Configura el bucket:
   - **Name**: `products-images`
   - **Public bucket**: ✅ Activar (para que las imágenes sean públicas)
5. Haz clic en **Create bucket**

## 2. Configurar Políticas de Seguridad (RLS)

1. En Storage, selecciona el bucket `products-images`
2. Ve a la pestaña **Policies**
3. Crea las siguientes políticas:

### Política 1: Lectura Pública
- **Policy name**: Public Access
- **Allowed operation**: SELECT
- **Policy definition**:
```sql
bucket_id = 'products-images'
```

### Política 2: Upload para Usuarios Autenticados
- **Policy name**: Authenticated Upload
- **Allowed operation**: INSERT
- **Policy definition**:
```sql
bucket_id = 'products-images' AND auth.role() = 'authenticated'
```

### Política 3: Update para Usuarios Autenticados
- **Policy name**: Authenticated Update
- **Allowed operation**: UPDATE
- **Policy definition**:
```sql
bucket_id = 'products-images' AND auth.role() = 'authenticated'
```

### Política 4: Delete para Usuarios Autenticados
- **Policy name**: Authenticated Delete
- **Allowed operation**: DELETE
- **Policy definition**:
```sql
bucket_id = 'products-images' AND auth.role() = 'authenticated'
```

## 3. Ejecutar el Script de Seguridad

1. Ve a **SQL Editor** en el panel de Supabase
2. Abre el archivo `scripts/003-setup-admin-security.sql`
3. Copia y pega el contenido en el editor
4. Ejecuta el script

## 4. Crear Usuario Admin

Para crear tu primer usuario administrador:

1. Ve a **Authentication** > **Users**
2. Haz clic en **Add user**
3. Ingresa:
   - Email: tu email de administrador
   - Password: una contraseña segura
4. Haz clic en **Create user**

O usa el código de registro que se incluye en la siguiente sección.

## 5. (Opcional) Página de Registro Admin

Si necesitas crear múltiples administradores, puedes usar esta página temporal:

**IMPORTANTE**: Elimina esta página después de crear tus usuarios admin.

## ✅ Verificación

Después de configurar todo:

1. Inicia sesión en `/admin/login`
2. Intenta crear un producto con imagen
3. Verifica que la imagen se sube correctamente
4. Verifica que puedes ver la imagen en el catálogo público

## 📝 Notas

- Las imágenes se optimizan automáticamente
- El formato recomendado es WebP para mejor rendimiento
- Tamaño máximo recomendado: 2MB por imagen
- Resolución recomendada: 800x800px

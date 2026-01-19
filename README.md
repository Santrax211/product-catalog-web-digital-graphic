# 🏢 Digital Graphic Corporation - Catálogo Web

Catálogo de productos web moderno y responsive con panel de administración completo para gestionar productos, categorías e imágenes.

## ✨ Características

### Catálogo Público
- 🎨 Diseño moderno y responsive (móvil, tablet, desktop)
- 🔍 Búsqueda de productos en tiempo real
- 📂 Filtrado por categorías
- 🖼️ Visualización de imágenes de productos
- 📱 WhatsApp flotante para contacto directo
- 🌙 Soporte para modo claro/oscuro

### Panel de Administración
- 🔐 Autenticación segura con Supabase Auth
- ➕ Crear, editar y eliminar productos
- 📸 Subida de imágenes con vista previa
- 📊 Dashboard con estadísticas en tiempo real
- 📱 Interfaz completamente responsive
- 🔒 Protección de rutas con middleware
- 🎯 Vista de tabla en desktop, cards en móvil

## 🛠️ Stack Tecnológico

- **Framework**: [Next.js 15](https://nextjs.org/) (App Router)
- **Lenguaje**: [TypeScript](https://www.typescriptlang.org/)
- **Estilos**: [Tailwind CSS](https://tailwindcss.com/)
- **Componentes UI**: [Shadcn/ui](https://ui.shadcn.com/)
- **Base de Datos**: [Supabase](https://supabase.com/) (PostgreSQL)
- **Autenticación**: Supabase Auth
- **Almacenamiento**: Supabase Storage
- **Gestor de Paquetes**: pnpm

## 📋 Requisitos Previos

- Node.js 18+ instalado
- pnpm instalado (`npm install -g pnpm`)
- Cuenta de Supabase (gratuita)

## 🚀 Instalación

### 1. Clonar el repositorio

```bash
git clone <url-del-repositorio>
cd product-catalog-web
```

### 2. Instalar dependencias

```bash
pnpm install
```

### 3. Configurar Supabase

#### a) Crear proyecto en Supabase
1. Ve a [Supabase](https://supabase.com)
2. Crea un nuevo proyecto
3. Espera a que se complete la configuración

#### b) Ejecutar scripts SQL
En el SQL Editor de Supabase, ejecuta los siguientes scripts en orden:

**1. Crear tablas** (`scripts/001-create-products-table.sql`):
```sql
-- Crear tabla de categorías
CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL UNIQUE,
  descripcion TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- Crear tabla de productos
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  codigo_modelo VARCHAR(100),
  categoria_id INTEGER REFERENCES categories(id) ON DELETE SET NULL,
  descripcion TEXT,
  imagen_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- Habilitar Row Level Security
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
```

**2. Insertar datos iniciales** (`scripts/002-insert-real-products.sql`)
- Ejecuta el script completo para cargar las categorías y productos

**3. Configurar políticas RLS** (`scripts/003-setup-rls-policies.sql`):
```sql
-- Permitir lectura pública
CREATE POLICY "Permitir lectura pública de productos"
ON products FOR SELECT USING (true);

-- Permitir operaciones a usuarios autenticados
CREATE POLICY "Permitir inserción a usuarios autenticados"
ON products FOR INSERT TO authenticated WITH CHECK (true);

CREATE POLICY "Permitir actualización a usuarios autenticados"
ON products FOR UPDATE TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Permitir eliminación a usuarios autenticados"
ON products FOR DELETE TO authenticated USING (true);

-- Políticas similares para categories
-- (ver archivo completo)
```

#### c) Configurar Storage
1. Ve a **Storage** en tu proyecto Supabase
2. Crea un bucket llamado `products-images`
3. Configúralo como **público**
4. Añade estas políticas:

**Policy for SELECT (public)**:
```sql
CREATE POLICY "Permitir lectura pública de imágenes"
ON storage.objects FOR SELECT
USING (bucket_id = 'products-images');
```

**Policy for INSERT (authenticated)**:
```sql
CREATE POLICY "Permitir subida a usuarios autenticados"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (bucket_id = 'products-images');
```

**Policy for DELETE (authenticated)**:
```sql
CREATE POLICY "Permitir eliminación a usuarios autenticados"
ON storage.objects FOR DELETE
TO authenticated
USING (bucket_id = 'products-images');
```

### 4. Configurar Variables de Entorno

Crea un archivo `.env.local` en la raíz del proyecto:

```env
# Supabase
NEXT_PUBLIC_SUPABASE_URL=https://tu-proyecto.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=tu-anon-key-aqui
SUPABASE_SERVICE_ROLE_KEY=tu-service-role-key-aqui
```

**Para obtener las claves:**
1. Ve a tu proyecto en Supabase
2. Settings → API
3. Copia `Project URL` → `NEXT_PUBLIC_SUPABASE_URL`
4. Copia `anon public` → `NEXT_PUBLIC_SUPABASE_ANON_KEY`
5. Copia `service_role` → `SUPABASE_SERVICE_ROLE_KEY`

⚠️ **IMPORTANTE**: Nunca compartas el `service_role` key públicamente.

### 5. Ejecutar el proyecto

```bash
pnpm dev
```

Abre [http://localhost:3000](http://localhost:3000) en tu navegador.

## 👤 Crear Usuario Admin

### Opción 1: Página de Setup (Primera vez)
1. Ve a `http://localhost:3000/admin/setup`
2. Ingresa tu email y contraseña
3. Haz clic en "Crear Cuenta de Admin"

### Opción 2: Desde Supabase Dashboard
1. Ve a **Authentication** → **Users** en Supabase
2. Click en "Add user" → "Create new user"
3. Ingresa email y contraseña

## 📱 Uso del Sistema

### Acceso Público
- **Catálogo**: `http://localhost:3000`
  - Buscar productos
  - Filtrar por categoría
  - Ver detalles de productos
  - Contactar vía WhatsApp

### Panel de Administración
- **Login**: `http://localhost:3000/admin/login`
- **Dashboard**: `http://localhost:3000/admin`

#### Funciones del Admin:
1. **Ver Dashboard**: Estadísticas de productos y categorías
2. **Listar Productos**: Tabla responsive con búsqueda y filtros
3. **Crear Producto**: 
   - Click en "Nuevo Producto"
   - Llenar formulario
   - Subir imagen (opcional)
   - Guardar
4. **Editar Producto**: Click en "Editar" en cualquier producto
5. **Eliminar Producto**: Click en "Eliminar" → Confirmar

## 📁 Estructura del Proyecto

```
product-catalog-web/
├── app/
│   ├── admin/              # Panel de administración
│   │   ├── login/          # Página de login
│   │   ├── setup/          # Página de setup inicial
│   │   ├── products/       # Gestión de productos
│   │   │   ├── new/        # Crear producto
│   │   │   └── [id]/       # Editar producto
│   │   ├── layout.tsx      # Layout del admin
│   │   └── page.tsx        # Dashboard
│   ├── actions/            # Server Actions
│   │   └── products.ts     # CRUD de productos
│   ├── layout.tsx          # Layout principal
│   ├── page.tsx            # Página de inicio (catálogo)
│   └── globals.css         # Estilos globales
├── components/
│   ├── admin/              # Componentes del admin
│   │   ├── admin-header.tsx
│   │   ├── product-form.tsx
│   │   └── products-table.tsx
│   ├── ui/                 # Componentes Shadcn/ui
│   ├── category-filter.tsx
│   ├── floating-whatsapp.tsx
│   ├── footer.tsx
│   ├── header.tsx
│   ├── product-card.tsx
│   └── product-catalog.tsx
├── lib/
│   ├── supabase/
│   │   ├── client.ts       # Cliente para componentes
│   │   ├── server.ts       # Cliente para server components
│   │   └── admin.ts        # Cliente admin (service role)
│   ├── types.ts            # Tipos TypeScript
│   └── utils.ts            # Utilidades
├── scripts/
│   ├── 001-create-products-table.sql
│   ├── 002-insert-real-products.sql
│   └── 003-setup-rls-policies.sql
├── public/                 # Archivos estáticos
├── .env.local             # Variables de entorno (no incluir en git)
├── middleware.ts          # Protección de rutas
├── next.config.mjs        # Configuración de Next.js
├── tailwind.config.ts     # Configuración de Tailwind
└── package.json           # Dependencias
```

## 🔒 Seguridad

- ✅ Row Level Security (RLS) habilitado en todas las tablas
- ✅ Autenticación requerida para operaciones de administración
- ✅ Service Role Key solo en servidor (nunca expuesta al cliente)
- ✅ Middleware protege rutas `/admin/*`
- ✅ Validación de usuario autenticado en Server Actions

## 📝 Scripts Disponibles

```bash
# Desarrollo
pnpm dev          # Ejecutar en modo desarrollo

# Construcción
pnpm build        # Compilar para producción

# Producción
pnpm start        # Ejecutar en producción

# Linting
pnpm lint         # Ejecutar ESLint
```

## 🎨 Personalización

### Cambiar Logo
Reemplaza los archivos en `public/`:
- `placeholder-logo.png` - Logo principal
- Actualiza las referencias en `components/header.tsx` y `components/footer.tsx`

### Modificar Información de Contacto
Edita `components/footer.tsx`:
- Nombre de la empresa
- Teléfono WhatsApp
- Email
- Dirección
- Redes sociales

### Agregar Categorías
Desde el SQL Editor de Supabase:
```sql
INSERT INTO categories (nombre, descripcion) 
VALUES ('Nueva Categoría', 'Descripción');
```

## 🐛 Solución de Problemas

### Error: "new row violates row-level security policy"
- Verifica que ejecutaste el script `003-setup-rls-policies.sql`
- Asegúrate de tener `SUPABASE_SERVICE_ROLE_KEY` configurado

### Error: "Failed to send confirmation email"
- Normal si no configuraste el proveedor de email en Supabase
- Los usuarios aún se crean correctamente

### Imágenes no se muestran
- Verifica que el bucket `products-images` sea público
- Revisa las políticas de Storage en Supabase

### Puerto 3000 en uso
```bash
# Windows PowerShell
Get-Process -Id (Get-NetTCPConnection -LocalPort 3000).OwningProcess | Stop-Process -Force
```

## 📞 Información de Contacto

**Digital Graphic Corporation**
- 👤 Reyven Jonathan Collantes Saldaña
- 📱 +51 930 545 985
- 📧 vega10815@gmail.com

## 📄 Licencia

Este proyecto es privado y confidencial.

---

Desarrollado con ❤️ usando Next.js y Supabase

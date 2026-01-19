export interface Category {
  id: number
  nombre: string
  created_at: string
}

export interface Product {
  id: number
  nombre: string
  codigo_modelo: string
  categoria_id: number | null
  descripcion: string | null
  imagen_url: string | null
  created_at: string
  updated_at: string
  categories?: Category
}

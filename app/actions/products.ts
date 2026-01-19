"use server"

import { createClient } from "@/lib/supabase/server"
import { createAdminClient } from "@/lib/supabase/admin"
import { revalidatePath } from "next/cache"

interface ProductData {
  nombre: string
  codigo_modelo: string | null
  categoria_id: number | null
  descripcion: string | null
  imagen_url: string | null
}

export async function createProduct(data: ProductData) {
  // Verificar autenticación
  const authClient = await createClient()
  if (!authClient) throw new Error("Supabase client not initialized")
  
  const { data: { user } } = await authClient.auth.getUser()
  if (!user) throw new Error("Unauthorized")

  // Usar cliente admin para operaciones
  const supabase = createAdminClient()

  const { data: product, error } = await supabase
    .from("products")
    .insert([data])
    .select()
    .single()

  if (error) {
    throw new Error(error.message)
  }

  revalidatePath("/admin")
  revalidatePath("/")
  return product
}

export async function updateProduct(id: number, data: ProductData) {
  // Verificar autenticación
  const authClient = await createClient()
  if (!authClient) throw new Error("Supabase client not initialized")
  
  const { data: { user } } = await authClient.auth.getUser()
  if (!user) throw new Error("Unauthorized")

  // Usar cliente admin para operaciones
  const supabase = createAdminClient()

  const { data: product, error } = await supabase
    .from("products")
    .update(data)
    .eq("id", id)
    .select()
    .single()

  if (error) {
    throw new Error(error.message)
  }

  revalidatePath("/admin")
  revalidatePath("/")
  return product
}

export async function deleteProduct(id: number) {
  // Verificar autenticación
  const authClient = await createClient()
  if (!authClient) throw new Error("Supabase client not initialized")
  
  const { data: { user } } = await authClient.auth.getUser()
  if (!user) throw new Error("Unauthorized")

  // Usar cliente admin para operaciones
  const supabase = createAdminClient()

  // Primero obtener la imagen para eliminarla del storage
  const { data: product } = await supabase
    .from("products")
    .select("imagen_url")
    .eq("id", id)
    .single()

  // Eliminar el producto
  const { error } = await supabase.from("products").delete().eq("id", id)

  if (error) {
    throw new Error(error.message)
  }

  // Si tenía imagen, eliminarla del storage
  if (product?.imagen_url) {
    try {
      const fileName = product.imagen_url.split("/").pop()
      if (fileName) {
        await supabase.storage.from("products-images").remove([fileName])
      }
    } catch (err) {
      console.error("Error al eliminar imagen:", err)
    }
  }

  revalidatePath("/admin")
  revalidatePath("/")
}

export async function uploadProductImage(file: File) {
  // Verificar autenticación
  const authClient = await createClient()
  if (!authClient) return { error: "Supabase client not initialized", url: null }
  
  const { data: { user } } = await authClient.auth.getUser()
  if (!user) return { error: "Unauthorized", url: null }

  // Usar cliente admin para operaciones
  const supabase = createAdminClient()

  // Generar nombre único para el archivo
  const fileExt = file.name.split(".").pop()
  const fileName = `${Math.random().toString(36).substring(2)}-${Date.now()}.${fileExt}`

  // Subir archivo
  const { data, error } = await supabase.storage
    .from("products-images")
    .upload(fileName, file, {
      cacheControl: "3600",
      upsert: false,
    })

  if (error) {
    return { error: error.message, url: null }
  }

  // Obtener URL pública
  const {
    data: { publicUrl },
  } = supabase.storage.from("products-images").getPublicUrl(data.path)

  return { error: null, url: publicUrl }
}

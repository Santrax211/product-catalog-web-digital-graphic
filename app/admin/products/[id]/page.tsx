import { createClient } from "@/lib/supabase/server"
import { ProductForm } from "@/components/admin/product-form"
import { Button } from "@/components/ui/button"
import Link from "next/link"
import type { Product, Category } from "@/lib/types"
import { notFound } from "next/navigation"

export default async function EditProductPage({ params }: { params: Promise<{ id: string }> }) {
  const supabase = await createClient()
  const { id } = await params

  const { data: product } = await supabase
    .from("products")
    .select("*")
    .eq("id", id)
    .single()

  if (!product) {
    notFound()
  }

  const { data: categories } = await supabase.from("categories").select("*").order("nombre")

  return (
    <div className="space-y-4 sm:space-y-6">
      <div className="flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h1 className="text-2xl font-bold tracking-tight sm:text-3xl">Editar Producto</h1>
          <p className="text-sm text-muted-foreground sm:text-base">Actualiza la información del producto</p>
        </div>
        <Link href="/admin">
          <Button variant="outline" size="sm">
            ← Volver
          </Button>
        </Link>
      </div>

      <ProductForm product={product as Product} categories={(categories as Category[]) || []} />
    </div>
  )
}

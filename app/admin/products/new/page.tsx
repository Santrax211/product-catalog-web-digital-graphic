import { createClient } from "@/lib/supabase/server"
import { ProductForm } from "@/components/admin/product-form"
import { Button } from "@/components/ui/button"
import Link from "next/link"
import type { Category } from "@/lib/types"

export const runtime = 'edge'

export default async function NewProductPage() {
  const supabase = await createClient()
  const { data: categories } = await supabase.from("categories").select("*").order("nombre")

  return (
    <div className="space-y-4 sm:space-y-6">
      <div className="flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h1 className="text-2xl font-bold tracking-tight sm:text-3xl">Nuevo Producto</h1>
          <p className="text-sm text-muted-foreground sm:text-base">Agrega un nuevo producto al catálogo</p>
        </div>
        <Link href="/admin">
          <Button variant="outline" size="sm">
            ← Volver
          </Button>
        </Link>
      </div>

      <ProductForm categories={(categories as Category[]) || []} />
    </div>
  )
}

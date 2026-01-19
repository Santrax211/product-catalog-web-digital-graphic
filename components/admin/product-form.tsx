"use client"

import { useState, useEffect } from "react"
import { useRouter } from "next/navigation"
import type { Product, Category } from "@/lib/types"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Textarea } from "@/components/ui/textarea"
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Alert, AlertDescription } from "@/components/ui/alert"
import Image from "next/image"
import { createProduct, updateProduct, uploadProductImage } from "@/app/actions/products"

interface ProductFormProps {
  product?: Product
  categories: Category[]
}

export function ProductForm({ product, categories }: ProductFormProps) {
  const router = useRouter()
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState("")
  const [imageFile, setImageFile] = useState<File | null>(null)
  const [imagePreview, setImagePreview] = useState<string | null>(product?.imagen_url || null)

  const [formData, setFormData] = useState({
    nombre: product?.nombre || "",
    codigo_modelo: product?.codigo_modelo || "",
    categoria_id: product?.categoria_id?.toString() || "",
    descripcion: product?.descripcion || "",
  })

  const handleImageChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0]
    if (file) {
      setImageFile(file)
      const reader = new FileReader()
      reader.onloadend = () => {
        setImagePreview(reader.result as string)
      }
      reader.readAsDataURL(file)
    }
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)
    setError("")

    try {
      let imageUrl = product?.imagen_url || null

      // Si hay una nueva imagen, subirla primero
      if (imageFile) {
        const uploadResult = await uploadProductImage(imageFile)
        if (uploadResult.error) {
          throw new Error(uploadResult.error)
        }
        imageUrl = uploadResult.url!
      }

      const productData = {
        nombre: formData.nombre,
        codigo_modelo: formData.codigo_modelo || null,
        categoria_id: formData.categoria_id ? parseInt(formData.categoria_id) : null,
        descripcion: formData.descripcion || null,
        imagen_url: imageUrl,
      }

      if (product) {
        await updateProduct(product.id, productData)
      } else {
        await createProduct(productData)
      }

      router.push("/admin")
      router.refresh()
    } catch (err: any) {
      setError(err.message || "Error al guardar el producto")
    } finally {
      setLoading(false)
    }
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle>{product ? "Editar Producto" : "Nuevo Producto"}</CardTitle>
        <CardDescription>
          {product ? "Actualiza la información del producto" : "Agrega un nuevo producto al catálogo"}
        </CardDescription>
      </CardHeader>
      <CardContent>
        <form onSubmit={handleSubmit} className="space-y-6">
          {error && (
            <Alert variant="destructive">
              <AlertDescription>{error}</AlertDescription>
            </Alert>
          )}

          <div className="grid gap-6 md:grid-cols-2">
            {/* Columna izquierda */}
            <div className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="nombre">
                  Nombre del Producto <span className="text-destructive">*</span>
                </Label>
                <Input
                  id="nombre"
                  value={formData.nombre}
                  onChange={(e) => setFormData({ ...formData, nombre: e.target.value })}
                  required
                  disabled={loading}
                  placeholder="Ej: Cortadora Láser Industrial"
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="codigo_modelo">Código/Modelo</Label>
                <Input
                  id="codigo_modelo"
                  value={formData.codigo_modelo}
                  onChange={(e) => setFormData({ ...formData, codigo_modelo: e.target.value })}
                  disabled={loading}
                  placeholder="Ej: CL-3000X"
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="categoria_id">Categoría</Label>
                <Select
                  value={formData.categoria_id}
                  onValueChange={(value) => setFormData({ ...formData, categoria_id: value })}
                  disabled={loading}
                >
                  <SelectTrigger id="categoria_id">
                    <SelectValue placeholder="Selecciona una categoría" />
                  </SelectTrigger>
                  <SelectContent>
                    {categories.map((category) => (
                      <SelectItem key={category.id} value={category.id.toString()}>
                        {category.nombre}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>

              <div className="space-y-2">
                <Label htmlFor="descripcion">Descripción</Label>
                <Textarea
                  id="descripcion"
                  value={formData.descripcion}
                  onChange={(e) => setFormData({ ...formData, descripcion: e.target.value })}
                  disabled={loading}
                  placeholder="Describe las características del producto..."
                  rows={6}
                />
              </div>
            </div>

            {/* Columna derecha - Imagen */}
            <div className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="image">Imagen del Producto</Label>
                <Input
                  id="image"
                  type="file"
                  accept="image/*"
                  onChange={handleImageChange}
                  disabled={loading}
                />
                <p className="text-xs text-muted-foreground">
                  Formatos: JPG, PNG, WebP. Tamaño recomendado: 800x800px
                </p>
              </div>

              {imagePreview && (
                <div className="space-y-2">
                  <Label>Vista Previa</Label>
                  <div className="relative aspect-square w-full overflow-hidden rounded-lg border">
                    <Image
                      src={imagePreview}
                      alt="Preview"
                      fill
                      className="object-contain"
                    />
                  </div>
                </div>
              )}
            </div>
          </div>

          <div className="flex gap-4">
            <Button type="submit" disabled={loading}>
              {loading ? "Guardando..." : product ? "Actualizar Producto" : "Crear Producto"}
            </Button>
            <Button type="button" variant="outline" onClick={() => router.back()} disabled={loading}>
              Cancelar
            </Button>
          </div>
        </form>
      </CardContent>
    </Card>
  )
}

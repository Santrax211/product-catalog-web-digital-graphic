"use client"

import { useState } from "react"
import type { Product, Category } from "@/lib/types"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table"
import { Badge } from "@/components/ui/badge"
import { Card, CardContent } from "@/components/ui/card"
import Image from "next/image"
import Link from "next/link"
import { deleteProduct } from "@/app/actions/products"
import { useRouter } from "next/navigation"
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
  AlertDialogTrigger,
} from "@/components/ui/alert-dialog"
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select"

interface ProductsTableProps {
  products: Product[]
  categories: Category[]
}

export function ProductsTable({ products, categories }: ProductsTableProps) {
  const [search, setSearch] = useState("")
  const [categoryFilter, setCategoryFilter] = useState<string>("all")
  const [deleting, setDeleting] = useState<number | null>(null)
  const router = useRouter()

  const filteredProducts = products.filter((product) => {
    const matchesSearch =
      product.nombre.toLowerCase().includes(search.toLowerCase()) ||
      product.codigo_modelo?.toLowerCase().includes(search.toLowerCase())
    
    const matchesCategory = 
      categoryFilter === "all" || 
      product.categoria_id?.toString() === categoryFilter

    return matchesSearch && matchesCategory
  })

  const handleDelete = async (id: number) => {
    setDeleting(id)
    try {
      await deleteProduct(id)
      router.refresh()
    } catch (error) {
      console.error("Error al eliminar:", error)
    } finally {
      setDeleting(null)
    }
  }

  return (
    <div className="space-y-4">
      {/* Filtros */}
      <div className="flex flex-col gap-4 sm:flex-row sm:items-center">
        <Input
          placeholder="Buscar por nombre o código..."
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          className="w-full sm:max-w-sm"
        />
        <Select value={categoryFilter} onValueChange={setCategoryFilter}>
          <SelectTrigger className="w-full sm:w-[200px]">
            <SelectValue placeholder="Filtrar por categoría" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">Todas las categorías</SelectItem>
            {categories.map((category) => (
              <SelectItem key={category.id} value={category.id.toString()}>
                {category.nombre}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>
        <div className="text-sm text-muted-foreground sm:ml-auto">
          {filteredProducts.length} producto(s)
        </div>
      </div>

      {/* Vista Desktop - Tabla */}
      <div className="hidden rounded-md border md:block">
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead className="w-[80px]">Imagen</TableHead>
              <TableHead>Nombre</TableHead>
              <TableHead>Código</TableHead>
              <TableHead>Categoría</TableHead>
              <TableHead className="text-right">Acciones</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {filteredProducts.length === 0 ? (
              <TableRow>
                <TableCell colSpan={5} className="text-center text-muted-foreground">
                  No se encontraron productos
                </TableCell>
              </TableRow>
            ) : (
              filteredProducts.map((product) => (
                <TableRow key={product.id}>
                  <TableCell>
                    <div className="relative h-12 w-12 overflow-hidden rounded border">
                      {product.imagen_url ? (
                        <Image
                          src={product.imagen_url}
                          alt={product.nombre}
                          fill
                          className="object-cover"
                        />
                      ) : (
                        <div className="flex h-full w-full items-center justify-center bg-muted text-xs text-muted-foreground">
                          Sin imagen
                        </div>
                      )}
                    </div>
                  </TableCell>
                  <TableCell className="font-medium">{product.nombre}</TableCell>
                  <TableCell className="font-mono text-sm">{product.codigo_modelo || "—"}</TableCell>
                  <TableCell>
                    {product.categories ? (
                      <Badge variant="secondary">{product.categories.nombre}</Badge>
                    ) : (
                      <span className="text-muted-foreground">Sin categoría</span>
                    )}
                  </TableCell>
                  <TableCell className="text-right">
                    <div className="flex justify-end gap-2">
                      <Link href={`/admin/products/${product.id}`}>
                        <Button variant="outline" size="sm">
                          Editar
                        </Button>
                      </Link>
                      <AlertDialog>
                        <AlertDialogTrigger asChild>
                          <Button variant="destructive" size="sm" disabled={deleting === product.id}>
                            {deleting === product.id ? "..." : "Eliminar"}
                          </Button>
                        </AlertDialogTrigger>
                        <AlertDialogContent>
                          <AlertDialogHeader>
                            <AlertDialogTitle>¿Estás seguro?</AlertDialogTitle>
                            <AlertDialogDescription>
                              Esta acción no se puede deshacer. El producto &quot;{product.nombre}&quot; será
                              eliminado permanentemente.
                            </AlertDialogDescription>
                          </AlertDialogHeader>
                          <AlertDialogFooter>
                            <AlertDialogCancel>Cancelar</AlertDialogCancel>
                            <AlertDialogAction onClick={() => handleDelete(product.id)}>
                              Eliminar
                            </AlertDialogAction>
                          </AlertDialogFooter>
                        </AlertDialogContent>
                      </AlertDialog>
                    </div>
                  </TableCell>
                </TableRow>
              ))
            )}
          </TableBody>
        </Table>
      </div>

      {/* Vista Mobile - Cards */}
      <div className="grid gap-4 md:hidden">
        {filteredProducts.length === 0 ? (
          <Card>
            <CardContent className="flex items-center justify-center py-8 text-muted-foreground">
              No se encontraron productos
            </CardContent>
          </Card>
        ) : (
          filteredProducts.map((product) => (
            <Card key={product.id}>
              <CardContent className="p-4">
                <div className="flex gap-4">
                  {/* Imagen */}
                  <div className="relative h-20 w-20 flex-shrink-0 overflow-hidden rounded border">
                    {product.imagen_url ? (
                      <Image
                        src={product.imagen_url}
                        alt={product.nombre}
                        fill
                        className="object-cover"
                      />
                    ) : (
                      <div className="flex h-full w-full items-center justify-center bg-muted text-xs text-muted-foreground">
                        Sin imagen
                      </div>
                    )}
                  </div>

                  {/* Info */}
                  <div className="flex-1 space-y-1">
                    <h3 className="font-semibold leading-tight">{product.nombre}</h3>
                    <p className="text-sm text-muted-foreground font-mono">
                      {product.codigo_modelo || "Sin código"}
                    </p>
                    {product.categories && (
                      <Badge variant="secondary" className="text-xs">
                        {product.categories.nombre}
                      </Badge>
                    )}
                  </div>
                </div>

                {/* Acciones */}
                <div className="mt-4 flex gap-2">
                  <Link href={`/admin/products/${product.id}`} className="flex-1">
                    <Button variant="outline" size="sm" className="w-full">
                      Editar
                    </Button>
                  </Link>
                  <AlertDialog>
                    <AlertDialogTrigger asChild>
                      <Button
                        variant="destructive"
                        size="sm"
                        className="flex-1"
                        disabled={deleting === product.id}
                      >
                        {deleting === product.id ? "..." : "Eliminar"}
                      </Button>
                    </AlertDialogTrigger>
                    <AlertDialogContent>
                      <AlertDialogHeader>
                        <AlertDialogTitle>¿Estás seguro?</AlertDialogTitle>
                        <AlertDialogDescription>
                          El producto &quot;{product.nombre}&quot; será eliminado permanentemente.
                        </AlertDialogDescription>
                      </AlertDialogHeader>
                      <AlertDialogFooter>
                        <AlertDialogCancel>Cancelar</AlertDialogCancel>
                        <AlertDialogAction onClick={() => handleDelete(product.id)}>
                          Eliminar
                        </AlertDialogAction>
                      </AlertDialogFooter>
                    </AlertDialogContent>
                  </AlertDialog>
                </div>
              </CardContent>
            </Card>
          ))
        )}
      </div>
    </div>
  )
}

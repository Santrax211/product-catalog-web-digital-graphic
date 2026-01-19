"use client"

import { useState, useMemo } from "react"
import type { Product, Category } from "@/lib/types"
import { CategoryFilter } from "./category-filter"
import { ProductCard } from "./product-card"
import { ProductDetailModal } from "./product-detail-modal"

interface ProductCatalogProps {
  products: Product[]
  categories: Category[]
  whatsappNumber: string
}

export function ProductCatalog({ products, categories, whatsappNumber }: ProductCatalogProps) {
  const [selectedCategory, setSelectedCategory] = useState<number | null>(null)
  const [selectedProduct, setSelectedProduct] = useState<Product | null>(null)

  const filteredProducts = useMemo(() => {
    if (selectedCategory === null) return products
    return products.filter((product) => product.categoria_id === selectedCategory)
  }, [products, selectedCategory])

  return (
    <>
      <div className="mb-8">
        <CategoryFilter
          categories={categories}
          selectedCategory={selectedCategory}
          onSelectCategory={setSelectedCategory}
        />
      </div>
      {filteredProducts.length === 0 ? (
        <div className="flex flex-col items-center justify-center py-16 text-center">
          <p className="text-lg font-medium text-muted-foreground">No hay productos en esta categoría</p>
          <button
            onClick={() => setSelectedCategory(null)}
            className="mt-4 text-sm font-medium text-primary underline-offset-4 hover:underline"
          >
            Ver todos los productos
          </button>
        </div>
      ) : (
        <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
          {filteredProducts.map((product) => (
            <ProductCard
              key={product.id}
              product={product}
              onOpenDetail={setSelectedProduct}
              whatsappNumber={whatsappNumber}
            />
          ))}
        </div>
      )}
      <ProductDetailModal
        product={selectedProduct}
        isOpen={selectedProduct !== null}
        onClose={() => setSelectedProduct(null)}
        whatsappNumber={whatsappNumber}
      />
    </>
  )
}

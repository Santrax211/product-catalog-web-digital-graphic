"use client"

import { cn } from "@/lib/utils"
import type { Category } from "@/lib/types"

interface CategoryFilterProps {
  categories: Category[]
  selectedCategory: number | null
  onSelectCategory: (categoryId: number | null) => void
}

export function CategoryFilter({ categories, selectedCategory, onSelectCategory }: CategoryFilterProps) {
  return (
    <div id="categorias" className="flex flex-wrap gap-2">
      <button
        onClick={() => onSelectCategory(null)}
        className={cn(
          "rounded-full border px-4 py-2 text-sm font-medium transition-colors",
          selectedCategory === null
            ? "border-primary bg-primary text-primary-foreground"
            : "border-border bg-background text-foreground hover:bg-secondary",
        )}
      >
        Todos
      </button>
      {categories.map((category) => (
        <button
          key={category.id}
          onClick={() => onSelectCategory(category.id)}
          className={cn(
            "rounded-full border px-4 py-2 text-sm font-medium transition-colors",
            selectedCategory === category.id
              ? "border-primary bg-primary text-primary-foreground"
              : "border-border bg-background text-foreground hover:bg-secondary",
          )}
        >
          {category.nombre}
        </button>
      ))}
    </div>
  )
}

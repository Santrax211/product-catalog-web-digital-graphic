import { createClient } from "@/lib/supabase/server"
import { Header } from "@/components/header"
import { Footer } from "@/components/footer"
import { ProductCatalog } from "@/components/product-catalog"
import { FloatingWhatsApp } from "@/components/floating-whatsapp"
import type { Product, Category } from "@/lib/types"

// Change this to your actual WhatsApp number (with country code, no + or spaces)
const WHATSAPP_NUMBER = "51930545985"

export const runtime = 'edge'

export default async function HomePage() {
  const supabase = await createClient()
  if (!supabase) throw new Error("Supabase client not initialized")

  const { data: products } = await supabase
    .from("products")
    .select("*, categories(id, nombre)")
    .order("created_at", { ascending: false })

  const { data: categories } = await supabase.from("categories").select("*").order("nombre")

  return (
    <div className="flex min-h-screen flex-col">
      <Header />
      <main className="flex-1">
        <section className="bg-primary py-16 text-primary-foreground md:py-24">
          <div className="mx-auto max-w-7xl px-4 text-center sm:px-6 lg:px-8">
            <h1 className="text-balance text-3xl font-bold tracking-tight md:text-5xl">
              Catálogo de Maquinaria Industrial
            </h1>
            <p className="mx-auto mt-4 max-w-2xl text-pretty text-base text-primary-foreground/80 md:text-lg">
              Explore nuestra selección de equipos y maquinaria importada de China. Solicite cotización directamente por
              WhatsApp.
            </p>
          </div>
        </section>
        <section className="py-12 md:py-16">
          <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
            <ProductCatalog
              products={(products as Product[]) || []}
              categories={(categories as Category[]) || []}
              whatsappNumber={WHATSAPP_NUMBER}
            />
          </div>
        </section>
      </main>
      <Footer />
      <FloatingWhatsApp phoneNumber={WHATSAPP_NUMBER} />
    </div>
  )
}

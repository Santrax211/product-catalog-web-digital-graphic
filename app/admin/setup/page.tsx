import { createClient } from "@/lib/supabase/server"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { redirect } from "next/navigation"

export default async function AdminSetupPage() {
  const supabase = await createClient()
  if (!supabase) throw new Error("Supabase client not initialized")

  const {
    data: { user },
  } = await supabase.auth.getUser()

  // Solo permitir acceso si NO hay sesión (para seguridad)
  if (user) {
    redirect("/admin")
  }

  const handleCreateAdmin = async (formData: FormData) => {
    "use server"
    const supabase = await createClient()
    if (!supabase) return

    const email = formData.get("email") as string
    const password = formData.get("password") as string

    const { error } = await supabase.auth.signUp({
      email,
      password,
    })

    if (error) {
      console.error("Error creating admin:", error)
    } else {
      redirect("/admin/login")
    }
  }

  return (
    <div className="flex min-h-screen items-center justify-center bg-muted/50 p-4">
      <Card className="w-full max-w-md">
        <CardHeader>
          <CardTitle className="text-2xl">Crear Usuario Administrador</CardTitle>
          <CardDescription>
            ⚠️ Esta página debe eliminarse después de crear tu primer usuario admin
          </CardDescription>
        </CardHeader>
        <CardContent>
          <form action={handleCreateAdmin} className="space-y-4">
            <div className="space-y-2">
              <label htmlFor="email" className="text-sm font-medium">
                Email
              </label>
              <input
                id="email"
                name="email"
                type="email"
                required
                className="w-full rounded-md border px-3 py-2"
                placeholder="admin@digitalgraphic.com"
              />
            </div>
            <div className="space-y-2">
              <label htmlFor="password" className="text-sm font-medium">
                Contraseña
              </label>
              <input
                id="password"
                name="password"
                type="password"
                required
                minLength={6}
                className="w-full rounded-md border px-3 py-2"
              />
            </div>
            <Button type="submit" className="w-full">
              Crear Administrador
            </Button>
          </form>
          <p className="mt-4 text-xs text-destructive">
            IMPORTANTE: Elimina esta página (app/admin/setup/page.tsx) después de crear tu usuario admin.
          </p>
        </CardContent>
      </Card>
    </div>
  )
}

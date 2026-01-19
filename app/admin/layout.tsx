import { createClient } from "@/lib/supabase/server"
import { Button } from "@/components/ui/button"
import Link from "next/link"
import Image from "next/image"
import { redirect } from "next/navigation"
import { AdminHeader } from "@/components/admin/admin-header"

export default async function AdminLayout({
  children,
}: {
  children: React.ReactNode
}) {
  const supabase = await createClient()
  if (!supabase) {
    return <>{children}</>
  }
  
  const {
    data: { user },
  } = await supabase.auth.getUser()

  if (!user) {
    return <>{children}</>
  }

  const handleSignOut = async () => {
    "use server"
    const supabase = await createClient()
    if (!supabase) return
    await supabase.auth.signOut()
    redirect("/admin/login")
  }

  return (
    <div className="min-h-screen bg-muted/50">
      <AdminHeader user={user} handleSignOut={handleSignOut} />
      <main className="mx-auto max-w-7xl p-4 sm:p-6">{children}</main>
    </div>
  )
}

"use client"

export default function AuthLayout({
  children,
}: {
  children: React.ReactNode
}) {
  // Layout simple para páginas de autenticación
  // No renderiza el layout del admin
  return <div className="min-h-screen">{children}</div>
}

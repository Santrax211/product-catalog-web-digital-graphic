"use client"

import { useState } from "react"
import { Button } from "@/components/ui/button"
import Link from "next/link"
import Image from "next/image"
import type { User } from "@supabase/supabase-js"

interface AdminHeaderProps {
  user: User
  handleSignOut: () => Promise<void>
}

export function AdminHeader({ user, handleSignOut }: AdminHeaderProps) {
  const [menuOpen, setMenuOpen] = useState(false)

  return (
    <header className="sticky top-0 z-50 border-b bg-background">
      <div className="flex h-16 items-center justify-between px-4 sm:px-6">
        <Link href="/admin" className="flex items-center">
          <div className="relative h-8 w-24 sm:h-10 sm:w-32">
            <Image
              src="/placeholder-logo.png"
              alt="Digital Graphic Corporation"
              fill
              className="object-contain"
            />
          </div>
        </Link>

        <nav className="hidden items-center gap-6 md:flex">
          <Link href="/admin" className="text-sm font-medium hover:text-primary">
            Dashboard
          </Link>
          <Link href="/" className="text-sm font-medium text-muted-foreground hover:text-primary">
            Ver Sitio
          </Link>
          <span className="text-sm text-muted-foreground">{user.email}</span>
          <form action={handleSignOut}>
            <Button variant="outline" size="sm" type="submit">
              Cerrar Sesión
            </Button>
          </form>
        </nav>

        <button
          className="flex h-9 w-9 items-center justify-center rounded-md border border-input bg-background hover:bg-accent md:hidden"
          onClick={() => setMenuOpen(!menuOpen)}
          aria-label="Toggle menu"
        >
          {menuOpen ? (
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              strokeWidth="2"
              strokeLinecap="round"
              strokeLinejoin="round"
            >
              <line x1="18" y1="6" x2="6" y2="18" />
              <line x1="6" y1="6" x2="18" y2="18" />
            </svg>
          ) : (
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              strokeWidth="2"
              strokeLinecap="round"
              strokeLinejoin="round"
            >
              <line x1="3" y1="12" x2="21" y2="12" />
              <line x1="3" y1="6" x2="21" y2="6" />
              <line x1="3" y1="18" x2="21" y2="18" />
            </svg>
          )}
        </button>
      </div>

      {menuOpen && (
        <div className="border-t md:hidden">
          <nav className="flex flex-col gap-2 p-4">
            <Link
              href="/admin"
              className="rounded-md px-3 py-2 text-sm font-medium hover:bg-accent"
              onClick={() => setMenuOpen(false)}
            >
              Dashboard
            </Link>
            <Link
              href="/"
              className="rounded-md px-3 py-2 text-sm font-medium text-muted-foreground hover:bg-accent"
              onClick={() => setMenuOpen(false)}
            >
              Ver Sitio
            </Link>
            <div className="border-t pt-2">
              <p className="px-3 py-2 text-sm text-muted-foreground">{user.email}</p>
              <form action={handleSignOut} className="px-3">
                <Button variant="outline" size="sm" className="w-full" type="submit">
                  Cerrar Sesión
                </Button>
              </form>
            </div>
          </nav>
        </div>
      )}
    </header>
  )
}

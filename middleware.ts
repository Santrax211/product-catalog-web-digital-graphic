import { type NextRequest, NextResponse } from "next/server"

export async function middleware(request: NextRequest) {
  // Temporalmente desactivado para debugging
  return NextResponse.next()
}

export const config = {
  matcher: ["/admin/:path*"],
}

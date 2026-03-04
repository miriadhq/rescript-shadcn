@@directive("'use client'")

@react.component
let make = () =>
  <div className="flex items-center gap-4" dir="rtl">
    <Skeleton className="h-12 w-12 rounded-full" />
    <div className="space-y-2">
      <Skeleton className="h-4 w-[250px]" />
      <Skeleton className="h-4 w-[200px]" />
    </div>
  </div>

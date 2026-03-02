export default function DashboardLoading() {
  return (
    <div className="space-y-6">
      {/* Page title skeleton */}
      <div className="space-y-2">
        <div className="h-8 w-48 animate-pulse rounded-md bg-gray-200" />
        <div className="h-4 w-72 animate-pulse rounded-md bg-gray-200" />
      </div>

      {/* Stats cards skeleton */}
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        {Array.from({ length: 4 }).map((_, i) => (
          <div
            key={i}
            className="rounded-xl border bg-white p-6 shadow-sm space-y-3"
          >
            <div className="flex items-center justify-between">
              <div className="h-4 w-24 animate-pulse rounded bg-gray-200" />
              <div className="h-8 w-8 animate-pulse rounded bg-gray-200" />
            </div>
            <div className="h-7 w-20 animate-pulse rounded bg-gray-200" />
            <div className="h-3 w-32 animate-pulse rounded bg-gray-200" />
          </div>
        ))}
      </div>

      {/* Table skeleton */}
      <div className="rounded-xl border bg-white shadow-sm">
        <div className="border-b p-4">
          <div className="h-6 w-36 animate-pulse rounded bg-gray-200" />
        </div>
        <div className="p-4 space-y-3">
          {Array.from({ length: 5 }).map((_, i) => (
            <div key={i} className="flex items-center gap-4">
              <div className="h-4 w-full animate-pulse rounded bg-gray-200" />
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}

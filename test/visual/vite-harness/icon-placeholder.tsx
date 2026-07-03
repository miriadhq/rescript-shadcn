import type * as React from "react"
import * as LucideIcons from "lucide-react"

type IconPlaceholderProps = React.ComponentProps<"svg"> & {
  lucide?: string
  tabler?: string
  hugeicons?: string
  phosphor?: string
  remixicon?: string
}

export function IconPlaceholder({
  lucide: _lucide,
  tabler: _tabler,
  hugeicons: _hugeicons,
  phosphor: _phosphor,
  remixicon: _remixicon,
  ...props
}: IconPlaceholderProps) {
  const Icon = (_lucide ? LucideIcons[_lucide as keyof typeof LucideIcons] : null) as
    | React.ComponentType<React.ComponentProps<"svg">>
    | null

  return Icon ? <Icon {...props} /> : <LucideIcons.SquareIcon {...props} />
}

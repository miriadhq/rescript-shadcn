import type { MDXComponents } from "mdx/types";

function Placeholder({ children }: any) {
  return <div >{children}</div>;
}

export function useMDXComponents(): MDXComponents {
  return {
    ComponentPreview: Placeholder,
    ComponentSource: Placeholder,
    TabsList: Placeholder,
    TabsTrigger: Placeholder,
    TabsContent: Placeholder,
    CodeTabs: Placeholder,
    Steps: Placeholder,
    Step: Placeholder,
  };
}

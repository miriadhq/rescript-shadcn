let slugify = (text: string) =>
  text
  ->String.replaceAll(" ", "-")
  ->String.replaceAll("'", "")
  ->String.replaceAll("?", "")
  ->String.toLowerCase

module Placeholder = {
  @react.component
  let make = (~children=React.null) => {
    <div> {children} </div>
  }
}

// --- Styled HTML element overrides ---

module H1 = {
  @react.component
  let make = (~className=?, ~children, ~id=?) => {
    <h1
      ?id
      className={Commons.cn(
        "font-heading mt-2 scroll-m-28 text-3xl font-bold tracking-tight",
        className,
      )}
    >
      {children}
    </h1>
  }
}

module H2 = {
  @react.component
  let make = (~className=?, ~children, ~id=?) => {
    let autoId = switch id {
    | Some(_) => id
    | None =>
      switch children->Type.Classify.classify {
      | String(value) => Some(slugify(value))
      | _ => None
      }
    }
    <h2
      id=?autoId
      className={Commons.cn(
        "font-heading [&+]*:[code]:text-xl mt-10 scroll-m-28 text-xl font-medium tracking-tight first:mt-0 lg:mt-12 [&+.steps]:mt-0! [&+.steps>h3]:mt-4! [&+h3]:mt-6! [&+p]:mt-4!",
        className,
      )}
    >
      {children}
    </h2>
  }
}

module H3 = {
  @react.component
  let make = (~className=?, ~children, ~id=?) => {
    <h3
      ?id
      className={Commons.cn(
        "font-heading mt-12 scroll-m-28 text-lg font-medium tracking-tight [&+p]:mt-4! *:[code]:text-xl",
        className,
      )}
    >
      {children}
    </h3>
  }
}

module H4 = {
  @react.component
  let make = (~className=?, ~children, ~id=?) => {
    <h4
      ?id
      className={Commons.cn(
        "font-heading mt-8 scroll-m-28 text-base font-medium tracking-tight",
        className,
      )}
    >
      {children}
    </h4>
  }
}

module H5 = {
  @react.component
  let make = (~className=?, ~children, ~id=?) => {
    <h5
      ?id className={Commons.cn("mt-8 scroll-m-28 text-base font-medium tracking-tight", className)}
    >
      {children}
    </h5>
  }
}

module H6 = {
  @react.component
  let make = (~className=?, ~children, ~id=?) => {
    <h6
      ?id className={Commons.cn("mt-8 scroll-m-28 text-base font-medium tracking-tight", className)}
    >
      {children}
    </h6>
  }
}

module Anchor = {
  @react.component
  let make = (~className=?, ~children, ~href=?, ~target=?, ~rel=?) => {
    <a
      ?href
      ?target
      ?rel
      className={Commons.cn("font-medium underline underline-offset-4", className)}
    >
      {children}
    </a>
  }
}

module P = {
  @react.component
  let make = (~className=?, ~children) => {
    <p className={Commons.cn("leading-relaxed [&:not(:first-child)]:mt-6", className)}>
      {children}
    </p>
  }
}

module Strong = {
  @react.component
  let make = (~className=?, ~children) => {
    <strong className={Commons.cn("font-medium", className)}> {children} </strong>
  }
}

module Ul = {
  @react.component
  let make = (~className=?, ~children) => {
    <ul className={Commons.cn("my-6 ml-6 list-disc", className)}> {children} </ul>
  }
}

module Ol = {
  @react.component
  let make = (~className=?, ~children) => {
    <ol className={Commons.cn("my-6 ml-6 list-decimal", className)}> {children} </ol>
  }
}

module Li = {
  @react.component
  let make = (~className=?, ~children) => {
    <li className={Commons.cn("mt-2", className)}> {children} </li>
  }
}

module Blockquote = {
  @react.component
  let make = (~className=?, ~children) => {
    <blockquote className={Commons.cn("mt-6 border-l-2 pl-6 italic", className)}>
      {children}
    </blockquote>
  }
}

module Img = {
  @react.component
  let make = (~className=?, ~alt=?, ~src=?, ~width=?, ~height=?) => {
    <img ?src ?alt ?width ?height className={Commons.cn("rounded-md", className)} />
  }
}

module Image = {
  @react.component
  let make = (~className=?, ~alt="", ~src="", ~width=?, ~height=?) => {
    <Next.Image
      src alt ?width ?height className={Commons.cn("mt-6 rounded-md border", className)}
    />
  }
}

module Hr = {
  @react.component
  let make = () => {
    <hr className="my-4 md:my-8" />
  }
}

module MdxTable = {
  @react.component
  let make = (~className=?, ~children) => {
    <div className="my-6 no-scrollbar w-full overflow-y-auto rounded-xl border">
      <table
        className={Commons.cn(
          "relative w-full overflow-hidden border-none text-sm [&_tbody_tr:last-child]:border-b-0",
          className,
        )}
      >
        {children}
      </table>
    </div>
  }
}

module Tr = {
  @react.component
  let make = (~className=?, ~children) => {
    <tr className={Commons.cn("m-0 border-b", className)}> {children} </tr>
  }
}

module Th = {
  @react.component
  let make = (~className=?, ~children) => {
    <th
      className={Commons.cn(
        "px-4 py-2 text-left font-bold [&[align=center]]:text-center [&[align=right]]:text-right",
        className,
      )}
    >
      {children}
    </th>
  }
}

module Td = {
  @react.component
  let make = (~className=?, ~children) => {
    <td
      className={Commons.cn(
        "px-4 py-2 text-left whitespace-nowrap [&[align=center]]:text-center [&[align=right]]:text-right",
        className,
      )}
    >
      {children}
    </td>
  }
}

module Pre = {
  @react.component
  let make = (~className=?, ~children) => {
    <pre
      className={Commons.cn(
        "no-scrollbar min-w-0 overflow-x-auto overflow-y-auto overscroll-x-contain overscroll-y-auto px-4 py-3.5 outline-none has-[[data-highlighted-line]]:px-0 has-[[data-line-numbers]]:px-0 has-[[data-slot=tabs]]:p-0",
        className,
      )}
    >
      {children}
    </pre>
  }
}

module Figure = {
  @react.component
  let make = (~className=?, ~children) => {
    <figure className={Commons.cn("", className)}> {children} </figure>
  }
}

module Figcaption = {
  @react.component
  let make = (~className=?, ~children) => {
    <figcaption
      className={Commons.cn(
        "flex items-center gap-2 text-code-foreground [&_svg]:size-4 [&_svg]:text-code-foreground [&_svg]:opacity-70",
        className,
      )}
    >
      {children}
    </figcaption>
  }
}

// --- Code component with special handling ---

module Code = {
  type props = {
    className?: string,
    children: React.element,
    style?: JsxDOM.style,
    @as("__raw__") raw?: string,
    @as("__src__") src?: string,
    @as("__npm__") npm?: string,
    @as("__yarn__") yarn?: string,
    @as("__pnpm__") pnpm?: string,
    @as("__bun__") bun?: string,
  }

  @react.componentWithProps(props)
  let make = ({?className, children, ?raw, ?npm, ?yarn, ?pnpm, ?bun, ?style}: props) => {
    // Inline code
    switch children->Type.Classify.classify {
    | String(_) =>
      <code
        className={Commons.cn(
          "relative rounded-md bg-muted px-[0.3rem] py-[0.2rem] font-mono text-[0.8rem] break-words outline-none",
          className,
        )}
      >
        {children}
      </code>
    | _ =>
      // npm command
      switch (npm, yarn, pnpm, bun) {
      | (Some(npm), Some(yarn), Some(pnpm), Some(bun)) => <CodeBlockCommand npm yarn pnpm bun />
      | _ =>
        // Default code block
        <>
          {switch raw {
          | Some(value) => <CopyButton value />
          | None => React.null
          }}
          <code ?className ?style> {children} </code>
        </>
      }
    }
  }
}

// --- Custom MDX components ---

module Step = {
  @react.component
  let make = (~className=?, ~children) => {
    <h3
      className={Commons.cn(
        "font-heading mt-8 scroll-m-32 text-lg font-medium tracking-tight",
        className,
      )}
    >
      {children}
    </h3>
  }
}

module Steps = {
  @react.component
  let make = (~className=?, ~children) => {
    <div
      className={Commons.cn(
        "steps mb-12 [counter-reset:step] md:ml-4 md:border-l md:pl-8 [&>h3]:step",
        className,
      )}
    >
      {children}
    </div>
  }
}

module Tab = {
  @react.component
  let make = (~className=?, ~children) => {
    <div className={Commons.cn("", className)}> {children} </div>
  }
}

module MdxLink = {
  @react.component
  let make = (~className=?, ~children, ~href="") => {
    <Next.Link href className={Commons.cn("font-medium underline underline-offset-4", className)}>
      {children}
    </Next.Link>
  }
}

module LinkedCard = {
  @react.component
  let make = (~className=?, ~children, ~href="") => {
    <Next.Link
      href
      className={Commons.cn(
        "flex w-full flex-col items-center rounded-xl bg-surface p-6 text-surface-foreground transition-colors hover:bg-surface/80 sm:p-10",
        className,
      )}
    >
      {children}
    </Next.Link>
  }
}

// --- Components export ---

@unboxed
type rec t = Components({..}): t

let default = Components({
  // HTML element overrides
  "h1": H1.make,
  "h2": H2.make,
  "h3": H3.make,
  "h4": H4.make,
  "h5": H5.make,
  "h6": H6.make,
  "a": Anchor.make,
  "p": P.make,
  "strong": Strong.make,
  "ul": Ul.make,
  "ol": Ol.make,
  "li": Li.make,
  "blockquote": Blockquote.make,
  "img": Img.make,
  "hr": Hr.make,
  "table": MdxTable.make,
  "tr": Tr.make,
  "th": Th.make,
  "td": Td.make,
  "pre": Pre.make,
  "figure": Figure.make,
  "figcaption": Figcaption.make,
  "code": Code.make,
  // Custom MDX components
  "Image": Image.make,
  "Step": Step.make,
  "Steps": Steps.make,
  "Tabs": MdxTabs.make,
  "TabsList": MdxTabsList.make,
  "TabsTrigger": MdxTabsTrigger.make,
  "TabsContent": MdxTabsContent.make,
  "Tab": Tab.make,
  "Button": Button.make,
  "Callout": Callout.make,
  "Accordion": Accordion.make,
  "Accordion.Content": MdxAccordionContent.make,
  "Accordion.Item": MdxAccordionItem.make,
  "Accordion.Trigger": MdxAccordionTrigger.make,
  "Alert": Alert.make,
  "Alert.Title": Alert.Title.make,
  "Alert.Description": Alert.Description.make,
  "AspectRatio": AspectRatio.make,
  "CodeTabs": CodeTabs.make,
  "ComponentPreview": ComponentPreview.make,
  "ComponentSource": ComponentSource.make,
  "CodeCollapsibleWrapper": CodeCollapsibleWrapper.make,
  "ComponentsList": ComponentsList.make,
  "CopyButton": CopyButton.make,
  "DirectoryList": DirectoryList.make,
  "Link": MdxLink.make,
  "LinkedCard": LinkedCard.make,
  "Kbd": Kbd.make,
})

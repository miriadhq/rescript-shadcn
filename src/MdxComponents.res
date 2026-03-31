@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

module Image = {
  @react.component
  let make = (~className=?, ~alt="", ~src="", ~width=?, ~height=?) => {
    <Next.Image
      src alt ?width ?height className={Commons.cn("mt-6 rounded-md border", className)}
    />
  }
}

module Code = {
  type props = {
    className?: string,
    children: React.element,
    @as("__raw__") raw?: string,
    @as("__src__") src?: string,
    @as("__npm__") npm?: string,
    @as("__yarn__") yarn?: string,
    @as("__pnpm__") pnpm?: string,
    @as("__bun__") bun?: string,
  }

  let toDomProps: props => BaseUi.Types.DomProps.t = %raw(`({className, children, __raw__, __npm__, __yarn__, __pnpm__, __bun__,...rest}) => rest`)

  @react.componentWithProps(props)
  let make = ({?className, children, ?raw, ?npm, ?yarn, ?pnpm, ?bun} as props: props) => {
    let props = toDomProps(props)
    // Inline code
    switch children->Type.Classify.classify {
    | String(_) =>
      <code
        {...props}
        className={Commons.cn(
          "relative rounded-md bg-muted px-[0.3rem] py-[0.2rem] font-mono text-[0.8rem] wrap-break-word outline-none",
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
          <code {...props} ?className> {children} </code>
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
  "h1": ({BaseUi.Types.DomProps.className: ?className} as props) =>
    <h1
      {...props}
      className={Commons.cn(
        "font-heading mt-2 scroll-m-28 text-3xl font-bold tracking-tight",
        className,
      )}
    />,
  "h2": ({BaseUi.Types.DomProps.className: ?className} as props) =>
    <h2
      {...props}
      className={Commons.cn(
        "font-heading [&+]*:[code]:text-xl mt-10 scroll-m-28 text-xl font-medium tracking-tight first:mt-0 lg:mt-12 [&+.steps]:mt-0! [&+.steps>h3]:mt-4! [&+h3]:mt-6! [&+p]:mt-4!",
        className,
      )}
    />,
  "h3": ({BaseUi.Types.DomProps.className: ?className} as props) =>
    <h3
      {...props}
      className={Commons.cn(
        "font-heading mt-12 scroll-m-28 text-lg font-medium tracking-tight [&+p]:mt-4! *:[code]:text-xl",
        className,
      )}
    />,
  "h4": ({BaseUi.Types.DomProps.className: ?className} as props) =>
    <h4
      {...props}
      className={Commons.cn(
        "font-heading mt-8 scroll-m-28 text-base font-medium tracking-tight",
        className,
      )}
    />,
  "h5": ({BaseUi.Types.DomProps.className: ?className} as props) =>
    <h5
      {...props}
      className={Commons.cn("mt-8 scroll-m-28 text-base font-medium tracking-tight", className)}
    />,
  "h6": ({BaseUi.Types.DomProps.className: ?className} as props) =>
    <h6
      {...props}
      className={Commons.cn("mt-8 scroll-m-28 text-base font-medium tracking-tight", className)}
    />,
  "a": ({BaseUi.Types.DomProps.className: ?className} as props) =>
    <a {...props} className={Commons.cn("font-medium underline underline-offset-4", className)} />,
  "p": ({BaseUi.Types.DomProps.className: ?className} as props) =>
    <p {...props} className={Commons.cn("leading-relaxed not-first:mt-6", className)} />,
  "strong": ({BaseUi.Types.DomProps.className: ?className} as props) =>
    <strong {...props} className={Commons.cn("font-medium", className)} />,
  "ul": ({BaseUi.Types.DomProps.className: ?className} as props) =>
    <ul {...props} className={Commons.cn("my-6 ml-6 list-disc", className)} />,
  "ol": ({BaseUi.Types.DomProps.className: ?className} as props) =>
    <ol {...props} className={Commons.cn("my-6 ml-6 list-decimal", className)} />,
  "li": ({BaseUi.Types.DomProps.className: ?className} as props) =>
    <li {...props} className={Commons.cn("mt-2", className)} />,
  "blockquote": ({BaseUi.Types.DomProps.className: ?className} as props) =>
    <blockquote {...props} className={Commons.cn("mt-6 border-l-2 pl-6 italic", className)} />,
  "img": ({BaseUi.Types.DomProps.className: ?className} as props) =>
    <img {...props} className={Commons.cn("rounded-md", className)} />,
  "hr": ({BaseUi.Types.DomProps.className: ?className} as props) =>
    <hr {...props} className={Commons.cn("my-4 md:my-8", className)} />,
  "table": ({BaseUi.Types.DomProps.className: ?className} as props) =>
    <div className="my-6 no-scrollbar w-full overflow-y-auto rounded-xl border">
      <table
        {...props}
        className={Commons.cn(
          "relative w-full overflow-hidden border-none text-sm [&_tbody_tr:last-child]:border-b-0",
          className,
        )}
      />
    </div>,
  "tr": ({BaseUi.Types.DomProps.className: ?className} as props) =>
    <tr {...props} className={Commons.cn("m-0 border-b", className)} />,
  "th": ({BaseUi.Types.DomProps.className: ?className} as props) =>
    <th
      {...props}
      className={Commons.cn(
        "px-4 py-2 text-left font-bold [[align=center]]:text-center [[align=right]]:text-right",
        className,
      )}
    />,
  "td": ({BaseUi.Types.DomProps.className: ?className} as props) =>
    <td
      {...props}
      className={Commons.cn(
        "px-4 py-2 text-left whitespace-nowrap [[align=center]]:text-center [[align=right]]:text-right",
        className,
      )}
    />,
  "pre": ({BaseUi.Types.DomProps.className: ?className} as props) =>
    <pre
      {...props}
      className={Commons.cn(
        "no-scrollbar min-w-0 overflow-x-auto overflow-y-auto overscroll-x-contain overscroll-y-auto px-4 py-3.5 outline-none has-data-highlighted-line:px-0 has-data-line-numbers:px-0 has-data-[slot=tabs]:p-0",
        className,
      )}
    />,
  "figure": ({BaseUi.Types.DomProps.className: ?className} as props) =>
    <figure {...props} className={Commons.cn("", className)} />,
  "figcaption": (
    {BaseUi.Types.DomProps.className: ?className, ?children, ?dataLanguage} as props,
  ) =>
    <figcaption
      {...props}
      className={Commons.cn(
        "flex items-center gap-2 text-code-foreground [&_svg]:size-4 [&_svg]:text-code-foreground [&_svg]:opacity-70",
        className,
      )}
    >
      {switch dataLanguage {
      | Some(language) => BrandIcons.getIconForLanguageExtension(language)
      | None => React.null
      }}
      {children->Option.getOr(React.null)}
    </figcaption>,
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

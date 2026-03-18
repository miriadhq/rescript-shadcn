@@directive("'use client'")

let darkModeForwardType = "dark-mode-forward"

module DarkModeScript = {
  @react.component
  let make = () => {
    <Next.Script
      id="dark-mode-listener"
      strategy="beforeInteractive"
      dangerouslySetInnerHTML={{
        __html: `
            (function() {
              // Forward D key
              document.addEventListener('keydown', function(e) {
                if ((e.key === 'd' || e.key === 'D') && !e.metaKey && !e.ctrlKey && !e.altKey) {
                  if (
                    (e.target instanceof HTMLElement && e.target.isContentEditable) ||
                    e.target instanceof HTMLInputElement ||
                    e.target instanceof HTMLTextAreaElement ||
                    e.target instanceof HTMLSelectElement
                  ) {
                    return;
                  }
                  e.preventDefault();
                  if (window.parent && window.parent !== window) {
                    window.parent.postMessage({
                      type: '${darkModeForwardType}',
                      key: e.key
                    }, '*');
                  }
                }
              });

            })();
          `,
      }}
    />
  }
}

let isTargetEditable: WebAPI.UIEventsAPI.keyboardEvent => bool = %raw(`
function(e){
  return (e.target instanceof HTMLElement && e.target.isContentEditable) ||
          e.target instanceof HTMLInputElement ||
          e.target instanceof HTMLTextAreaElement ||
          e.target instanceof HTMLSelectElement;
}
`)

@react.component
let make = () => {
  let {setTheme, resolvedTheme} = Next.Themes.use()
  let {setMetaColor, metaColor} = MetaColor.use()

  React.useEffect(() => {
    setMetaColor(metaColor)
    None
  }, (metaColor, setMetaColor))

  let toggleTheme = React.useCallback(() => {
    setTheme(
      switch resolvedTheme {
      | Dark => Light
      | Light => Dark
      },
    )
  }, (resolvedTheme, setTheme))

  React.useEffect(() => {
    let down = (e: WebAPI.UIEventsAPI.keyboardEvent) => {
      switch e.key {
      | "d" | "D" if !e.metaKey && !e.ctrlKey && !e.altKey && !isTargetEditable(e) =>
        e->WebAPI.KeyboardEvent.preventDefault
        toggleTheme()
      | _ => ()
      }
    }

    document->WebAPI.Document.addEventListener(Keydown, down)
    Some(() => document->WebAPI.Document.removeEventListener(Keydown, down))
  }, [toggleTheme])

  <Tooltip>
    <Tooltip.Trigger
      render={<Button
        variant=Ghost
        size=Icon
        className="group/toggle extend-touch-target size-8"
        onClick={_ => toggleTheme()}
      />}
    >
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
        className="size-4.5"
      >
        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
        <path d="M12 12m-9 0a9 9 0 1 0 18 0a9 9 0 1 0 -18 0" />
        <path d="M12 3l0 18" />
        <path d="M12 9l4.65 -4.65" />
        <path d="M12 14.3l7.37 -7.37" />
        <path d="M12 19.6l8.85 -8.85" />
      </svg>
      <span className="sr-only"> {"Toggle theme"->React.string} </span>
    </Tooltip.Trigger>
    <Tooltip.Content className="flex items-center gap-2 pr-1">
      {"Toggle theme"->React.string}
      <Kbd> {"D"->React.string} </Kbd>
    </Tooltip.Content>
  </Tooltip>
}

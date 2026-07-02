# Base UI bindgen notes

Bindings were checked against `@base-ui/react@1.6.0` with the workspace dev dependency `@juspay/rescript-bindgen@1.2.4`.

## Commands Used

I first ran bindgen against the installed package root:

```sh
yarn workspace rescript-base-ui exec rescript-bindgen --dir ../../node_modules/@base-ui/react --from @base-ui/react --out /private/tmp/base-ui-bindgen --report --json-summary /private/tmp/base-ui-bindgen-summary.json --clean
```

That wrote:

- `/private/tmp/base-ui-bindgen/*.res`
- `/private/tmp/base-ui-bindgen/_REPORT.md`
- `/private/tmp/base-ui-bindgen/.bindgen-manifest.json`
- `/private/tmp/base-ui-bindgen-summary.json`

Then I ran bindgen against Base UI subpackage entrypoints to see which namespace exports could be discovered from their local `index.d.ts` files:

```sh
for d in accordion alert-dialog autocomplete avatar button checkbox checkbox-group collapsible combobox context-menu csp-provider dialog direction-provider drawer field fieldset form input menu menubar meter navigation-menu number-field otp-field popover preview-card progress radio radio-group scroll-area select separator slider switch tabs toast toggle toggle-group toolbar tooltip unstable-use-media-query use-render; do
  mkdir -p /private/tmp/base-ui-bindgen-parts/$d
  yarn workspace rescript-base-ui exec rescript-bindgen --dir ../../node_modules/@base-ui/react/$d --from @base-ui/react/$d --out /private/tmp/base-ui-bindgen-parts/$d --report --json-summary /private/tmp/base-ui-bindgen-parts/$d-summary.json --clean
done
```

That wrote per-entrypoint reports and generated files under `/private/tmp/base-ui-bindgen-parts/<entrypoint>/`.

For a spot check, I also tried a direct component declaration file:

```sh
yarn workspace rescript-base-ui exec rescript-bindgen --file ../../node_modules/@base-ui/react/button/Button.d.ts --from @base-ui/react/button --stdout --report
```

## Outcome

The package-level entrypoint generated 15 component bindings, 23 function bindings, 29 namespace alias modules, and a report. Compared with `1.0.3`, bindgen `1.2.4` models the detected root components much more cleanly: the generated report has no defects, no review items, and only a few loose props for complex value/item shapes.

Nested component support is improved for namespace aliases, but Base UI leaf parts are still not emitted as full component bindings in most cases. Many parts are still reported as `no-props` or `ns-name-collision` when run through the package or subpackage `index.d.ts` files. The hand-normalized modules in `src` still carry the broader nested component surface.

The committed bindings keep this package's existing public shape:

- modules mirror Base UI entrypoints, such as `Drawer.Root` and `Toolbar.Button`
- broad `Types.BaseUIComponentProps.t` props are used for component parts
- simple value props and callbacks are typed where bindgen and the TypeScript declarations expose stable shapes
- raw bindgen placeholder props were not copied into public modules

For the 1.5.0 update, bindgen and the changelog highlighted these changes:

- `Drawer` is no longer preview-only; bindings now scope to `Drawer` instead of `DrawerPreview`
- `OTPFieldPreview` was added and is bound as `OTPField`
- `Autocomplete.InputGroup`, `Combobox.Label`, `Combobox.InputGroup`, `Select.Label`, `Slider.Label`, and `Drawer.SwipeArea` were added
- `Tooltip.Trigger.closeOnClick` was added
- `Select.Root.items` now accepts grouped items and record maps in TypeScript; the binding still keeps the existing array shape to avoid breaking current examples
- Several roots now accept nullable values in TypeScript; those remain a known fidelity gap in the ergonomic bindings

For the 1.6.0 update, bindgen and the changelog highlighted these changes:

- `OTPField` is no longer preview-only; bindings now scope to `OTPField` instead of `OTPFieldPreview`
- `Drawer.VirtualKeyboardProvider` was added
- the old `@base-ui/react/labelable-provider` subpath no longer exists, so the stale `LabelableProvider` binding was removed

For the `@juspay/rescript-bindgen@1.2.4` retry, bindgen additionally surfaced these non-breaking prop gaps, which were added to the hand bindings:

- `Autocomplete.Root`: `grid`, `filteredItems`, `virtualized`, `inline`, `limit`, and `locale`
- `Combobox.Root`: `inputValue`, `defaultInputValue`, `openOnInputClick`, `grid`, `filteredItems`, `virtualized`, `inline`, `limit`, and `locale`
- `Slider.Root`: `locale`

The generated `filter` prop for autocomplete/combobox was not added because this package's broad shared DOM prop record already has a `filter` field for SVG/CSS usage, and ReScript disallows duplicate record fields.

Re-run bindgen when updating Base UI to find new entrypoints and compare the report against the hand-normalized bindings in `src`.

# Base UI bindgen notes

Bindings were checked against `@base-ui/react@1.2.0` with the workspace dev dependency `@juspay/rescript-bindgen@1.0.3`.

## Commands Used

I first ran bindgen against the installed package root:

```sh
yarn workspace rescript-base-ui exec rescript-bindgen --dir ./node_modules/@base-ui/react --from @base-ui/react --out /private/tmp/base-ui-bindgen --report --clean
```

That wrote:

- `/private/tmp/base-ui-bindgen/*.res`
- `/private/tmp/base-ui-bindgen/_REPORT.md`
- `/private/tmp/base-ui-bindgen/.bindgen-manifest.json`

Then I ran bindgen against Base UI subpackage entrypoints to see which namespace exports could be discovered from their local `index.d.ts` files:

```sh
for d in accordion alert-dialog autocomplete avatar button checkbox checkbox-group collapsible combobox context-menu csp-provider dialog direction-provider drawer field fieldset form input labelable-provider menu menubar meter navigation-menu number-field popover preview-card progress radio radio-group scroll-area select separator slider switch tabs toast toggle toggle-group toolbar tooltip unstable-use-media-query use-button use-render; do
  mkdir -p /private/tmp/base-ui-bindgen-parts/$d
  yarn workspace rescript-base-ui exec rescript-bindgen --dir ./node_modules/@base-ui/react/$d --from @base-ui/react/$d --out /private/tmp/base-ui-bindgen-parts/$d --report --clean
done
```

That wrote per-entrypoint reports and generated files under `/private/tmp/base-ui-bindgen-parts/<entrypoint>/`.

For a spot check, I also tried a direct component declaration file:

```sh
yarn workspace rescript-base-ui exec rescript-bindgen --file ./node_modules/@base-ui/react/button/Button.d.ts --from @base-ui/react/button --stdout --report
```

## Outcome

The package-level entrypoint generated 12 raw bindings and a report, but Base UI exports many components through namespace objects and re-exported `index.d.ts` files. In those cases bindgen currently reports many parts as `not-a-component` or `no-props`, and several raw props are emitted as placeholder `string` values because Base UI uses generic `any`/`unknown` surfaces for render props, refs, and collection values.

The committed bindings keep this package's existing public shape:

- modules mirror Base UI entrypoints, such as `Drawer.Root` and `Toolbar.Button`
- broad `Types.BaseUIComponentProps.t` props are used for component parts
- simple value props and callbacks are typed where bindgen and the TypeScript declarations expose stable shapes
- raw bindgen placeholder props were not copied into public modules

Re-run bindgen when updating Base UI to find new entrypoints and compare the report against the hand-normalized bindings in `src`.

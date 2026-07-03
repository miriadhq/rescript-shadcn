# @shadcn/react bindgen notes

Bindings were checked against `@shadcn/react@0.2.0` with the workspace dev dependency `@juspay/rescript-bindgen@1.2.4`.

## Commands Used

The package only exports `./message-scroller`, so bindgen could not resolve useful declarations from the package root:

```sh
yarn workspace rescript-shadcn-react exec rescript-bindgen --pkg @shadcn/react@0.2.0 --out /private/tmp/shadcn-react-bindgen --from @shadcn/react/message-scroller --report --json-summary /private/tmp/shadcn-react-bindgen-summary.json --clean --yes
```

That failed with:

```text
Could not resolve types for package "@shadcn/react@0.2.0". It may ship no .d.ts and have no @types package.
```

I then unpacked the published tarball and ran bindgen against the subpath declarations:

```sh
npm pack @shadcn/react@0.2.0 --pack-destination /private/tmp
mkdir -p /private/tmp/shadcn-react-0.2.0
tar -xzf /private/tmp/shadcn-react-0.2.0.tgz -C /private/tmp/shadcn-react-0.2.0 --strip-components=1
yarn workspace rescript-shadcn-react exec rescript-bindgen --dir /private/tmp/shadcn-react-0.2.0/dist/message-scroller --from @shadcn/react/message-scroller --out /private/tmp/shadcn-react-bindgen-message-scroller --report --json-summary /private/tmp/shadcn-react-bindgen-message-scroller-summary.json --clean
```

I also checked the nested object export directly:

```sh
yarn workspace rescript-shadcn-react exec rescript-bindgen --dir /private/tmp/shadcn-react-0.2.0/dist/message-scroller --from @shadcn/react/message-scroller --only MessageScroller --out /private/tmp/shadcn-react-bindgen-message-scroller-only --report --json-summary /private/tmp/shadcn-react-bindgen-message-scroller-only-summary.json --clean
```

## Outcome

Bindgen emitted the three hook bindings and shared types:

- `useMessageScroller`
- `useMessageScrollerScrollable`
- `useMessageScrollerVisibility`

It did not emit the nested `MessageScroller.Provider`, `Root`, `Viewport`, `Content`, `Item`, or `Button` components because the published declaration exports them as properties on a `MessageScroller` object instead of direct component exports. The committed bindings keep the hook types from bindgen and hand-normalize the small nested component surface using `@scope("MessageScroller")`.

Re-run bindgen when `@shadcn/react` changes, especially if the package starts exporting the component parts directly or bindgen gains support for this object-export declaration shape.

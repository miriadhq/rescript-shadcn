# React Aria Components bindings for ReScript

ReScript bindings for [React Aria Components](https://react-spectrum.adobe.com/react-aria/components.html).

The modules mirror the React Aria Components 1.19 API and provide typed props for the primitives used by the React Aria shadcn registry in this repository. The package contains declarations only: component adapters and shadcn-compatible prop conversions live in `registry/aria/ui`.

The bindings are audited against the exact upstream TypeScript declarations with `rescript-bindgen`. Generated output is used as an API report rather than checked in because generic React component declarations currently degrade to untyped component signatures; the maintained bindings keep those props typed and tests verify every bound runtime export exists upstream.

```sh
yarn add react-aria-components rescript-react-aria
```

Add `rescript-react-aria` to the `dependencies` array in `rescript.json`.

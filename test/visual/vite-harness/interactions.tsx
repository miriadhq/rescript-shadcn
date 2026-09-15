import React from "react";
import { createRoot } from "react-dom/client";

const { file, props, form } = JSON.parse(new URLSearchParams(location.search).get("fixture")!);
const { make: Component } = await import(/* @vite-ignore */ `/${file}`);
const element = file === "registry/base/ui/Button.res.mjs"
  ? <Component render={<a href="#" />} nativeButton={false} onClick={event => {
      event.preventDefault();
      document.body.dataset.activated = "true";
    }}>Action</Component>
  : <Component {...props} />;

createRoot(document.getElementById("root")!).render(
  form ? <form onSubmit={event => {
    event.preventDefault();
    document.body.dataset.submitted = "true";
  }}>{element}</form> : element
);

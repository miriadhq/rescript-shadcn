type props = {
  children?: React.element,
  nonce?: string,
  disableStyleElements?: bool,
}
@module("@base-ui/react/csp-provider")
external make: React.component<props> = "CSPProvider"

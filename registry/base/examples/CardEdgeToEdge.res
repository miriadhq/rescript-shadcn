@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Card className="mx-auto w-full max-w-sm">
    <Card.Header>
      <Card.Title> {"Terms of Service"->React.string} </Card.Title>
      <Card.Description>
        {"Review the terms before accepting the agreement."->React.string}
      </Card.Description>
    </Card.Header>
    <Card.Content className="-mb-(--card-spacing)">
      <div
        className="-mx-(--card-spacing) max-h-48 space-y-4 overflow-y-scroll border-t bg-muted/50 px-(--card-spacing) py-4 text-sm leading-relaxed"
      >
        <p>
          {"These terms govern your use of the workspace, including access to shared documents, project files, and collaboration tools."->React.string}
        </p>
        <p>
          {"You are responsible for the content you upload and for ensuring that your team has the appropriate permissions to view or edit it."->React.string}
        </p>
        <p>
          {"We may update features or limits as the service evolves. When those changes materially affect your workflow, we will notify your workspace administrators."->React.string}
        </p>
        <p>
          {"By continuing, you agree to keep your account credentials secure and to follow your organization's acceptable use policies."->React.string}
        </p>
      </div>
    </Card.Content>
    <Card.Footer className="justify-end gap-2">
      <Button variant=Outline> {"Decline"->React.string} </Button>
      <Button> {"Accept"->React.string} </Button>
    </Card.Footer>
  </Card>

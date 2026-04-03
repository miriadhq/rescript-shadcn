@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex flex-col items-start gap-8 sm:flex-row">
    <div className="flex items-start gap-2">
      <Button size=Xs variant=Outline> {"Extra Small"->React.string} </Button>
      <Button size=IconXs ariaLabel="Submit" variant=Outline>
        <Icons.ArrowUpRight />
      </Button>
    </div>
    <div className="flex items-start gap-2">
      <Button size=Sm variant=Outline> {"Small"->React.string} </Button>
      <Button size=IconSm ariaLabel="Submit" variant=Outline>
        <Icons.ArrowUpRight />
      </Button>
    </div>
    <div className="flex items-start gap-2">
      <Button variant=Outline> {"Default"->React.string} </Button>
      <Button size=Icon ariaLabel="Submit" variant=Outline>
        <Icons.ArrowUpRight />
      </Button>
    </div>
    <div className="flex items-start gap-2">
      <Button variant=Outline size=Lg> {"Large"->React.string} </Button>
      <Button size=IconLg ariaLabel="Submit" variant=Outline>
        <Icons.ArrowUpRight />
      </Button>
    </div>
  </div>

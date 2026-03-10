@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Resizable
    orientation=BaseUi.Types.Orientation.Horizontal className="max-w-sm rounded-lg border" dir="rtl"
  >
    <Resizable.Panel defaultSize="50%">
      <div className="flex h-[200px] items-center justify-center p-6">
        <span className="font-semibold"> {"واحد"->React.string} </span>
      </div>
    </Resizable.Panel>
    <Resizable.Handle withHandle={true} />
    <Resizable.Panel defaultSize="50%">
      <Resizable orientation=BaseUi.Types.Orientation.Vertical dir="rtl">
        <Resizable.Panel defaultSize="25%">
          <div className="flex h-full items-center justify-center p-6">
            <span className="font-semibold"> {"اثنان"->React.string} </span>
          </div>
        </Resizable.Panel>
        <Resizable.Handle withHandle={true} />
        <Resizable.Panel defaultSize="75%">
          <div className="flex h-full items-center justify-center p-6">
            <span className="font-semibold"> {"ثلاثة"->React.string} </span>
          </div>
        </Resizable.Panel>
      </Resizable>
    </Resizable.Panel>
  </Resizable>

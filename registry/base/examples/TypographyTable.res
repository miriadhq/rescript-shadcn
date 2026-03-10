@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="my-6 w-full overflow-y-auto">
    <table className="w-full">
      <thead>
        <tr className="even:bg-muted m-0 border-t p-0">
          <th
            className="border px-4 py-2 text-left font-bold [&[align=center]]:text-center [&[align=right]]:text-right"
          >
            {"King's Treasury"->React.string}
          </th>
          <th
            className="border px-4 py-2 text-left font-bold [&[align=center]]:text-center [&[align=right]]:text-right"
          >
            {"People's happiness"->React.string}
          </th>
        </tr>
      </thead>
      <tbody>
        <tr className="even:bg-muted m-0 border-t p-0">
          <td
            className="border px-4 py-2 text-left [&[align=center]]:text-center [&[align=right]]:text-right"
          >
            {"Empty"->React.string}
          </td>
          <td
            className="border px-4 py-2 text-left [&[align=center]]:text-center [&[align=right]]:text-right"
          >
            {"Overflowing"->React.string}
          </td>
        </tr>
        <tr className="even:bg-muted m-0 border-t p-0">
          <td
            className="border px-4 py-2 text-left [&[align=center]]:text-center [&[align=right]]:text-right"
          >
            {"Modest"->React.string}
          </td>
          <td
            className="border px-4 py-2 text-left [&[align=center]]:text-center [&[align=right]]:text-right"
          >
            {"Satisfied"->React.string}
          </td>
        </tr>
        <tr className="even:bg-muted m-0 border-t p-0">
          <td
            className="border px-4 py-2 text-left [&[align=center]]:text-center [&[align=right]]:text-right"
          >
            {"Full"->React.string}
          </td>
          <td
            className="border px-4 py-2 text-left [&[align=center]]:text-center [&[align=right]]:text-right"
          >
            {"Ecstatic"->React.string}
          </td>
        </tr>
      </tbody>
    </table>
  </div>

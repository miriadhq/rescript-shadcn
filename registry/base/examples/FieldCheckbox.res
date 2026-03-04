@react.component
let make = () =>
  <Field.Group className="w-full max-w-xs">
    <Field.Set>
      <Field.Legend variant=Label> {"Show these items on the desktop"->React.string} </Field.Legend>
      <Field.Description>
        {"Select the items you want to show on the desktop."->React.string}
      </Field.Description>
      <Field.Group className="gap-3">
        <Field orientation=BaseUi.Types.Orientation.Horizontal>
          <Checkbox id="finder-pref-9k2-hard-disks-ljj" />
          <Field.Label htmlFor="finder-pref-9k2-hard-disks-ljj" className="font-normal">
            {"Hard disks"->React.string}
          </Field.Label>
        </Field>
        <Field orientation=BaseUi.Types.Orientation.Horizontal>
          <Checkbox id="finder-pref-9k2-external-disks-1yg" />
          <Field.Label htmlFor="finder-pref-9k2-external-disks-1yg" className="font-normal">
            {"External disks"->React.string}
          </Field.Label>
        </Field>
        <Field orientation=BaseUi.Types.Orientation.Horizontal>
          <Checkbox id="finder-pref-9k2-cds-dvds-fzt" />
          <Field.Label htmlFor="finder-pref-9k2-cds-dvds-fzt" className="font-normal">
            {"CDs, DVDs, and iPods"->React.string}
          </Field.Label>
        </Field>
        <Field orientation=BaseUi.Types.Orientation.Horizontal>
          <Checkbox id="finder-pref-9k2-connected-servers-6l2" />
          <Field.Label htmlFor="finder-pref-9k2-connected-servers-6l2" className="font-normal">
            {"Connected servers"->React.string}
          </Field.Label>
        </Field>
      </Field.Group>
    </Field.Set>
    <Field.Separator />
    <Field orientation=BaseUi.Types.Orientation.Horizontal>
      <Checkbox id="finder-pref-9k2-sync-folders-nep" defaultChecked={true} />
      <Field.Content>
        <Field.Label htmlFor="finder-pref-9k2-sync-folders-nep">
          {"Sync Desktop & Documents folders"->React.string}
        </Field.Label>
        <Field.Description>
          {"Your Desktop & Documents folders are being synced with iCloud Drive. You can access them from other devices."->React.string}
        </Field.Description>
      </Field.Content>
    </Field>
  </Field.Group>

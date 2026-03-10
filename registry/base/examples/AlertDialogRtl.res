@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

let rtlOutlineTriggerClass = "[&_svg:not([class*='size-'])]:size-4 [&_svg]:pointer-events-none [&_svg]:shrink-0 aria-expanded:bg-muted aria-expanded:text-foreground aria-invalid:border-destructive aria-invalid:ring-3 aria-invalid:ring-destructive/20 bg-background bg-clip-padding border border-border dark:aria-invalid:border-destructive/50 dark:aria-invalid:ring-destructive/40 dark:bg-input/30 dark:border-input dark:hover:bg-input/50 disabled:opacity-50 disabled:pointer-events-none focus-visible:border-ring focus-visible:ring-3 focus-visible:ring-ring/50 font-medium gap-1.5 group/button h-8 has-data-[icon=inline-end]:pe-2 has-data-[icon=inline-start]:ps-2 hover:bg-muted hover:text-foreground inline-flex items-center justify-center outline-none px-2.5 rounded-lg select-none shrink-0 text-sm transition-all whitespace-nowrap"

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex gap-4" dir="rtl">
    <RtlAlertDialog>
      <RtlAlertDialog.Trigger className={rtlOutlineTriggerClass} type_="button">
        {"إظهار الحوار"->React.string}
      </RtlAlertDialog.Trigger>
      <RtlAlertDialog.Content dir="rtl" dataLang="ar">
        <RtlAlertDialog.Header>
          <RtlAlertDialog.Title>
            {"هل أنت متأكد تمامًا؟"->React.string}
          </RtlAlertDialog.Title>
          <RtlAlertDialog.Description>
            {"لا يمكن التراجع عن هذا الإجراء. سيؤدي هذا إلى حذف حسابك نهائيًا من خوادمنا."->React.string}
          </RtlAlertDialog.Description>
        </RtlAlertDialog.Header>
        <RtlAlertDialog.Footer>
          <RtlAlertDialog.Cancel> {"إلغاء"->React.string} </RtlAlertDialog.Cancel>
          <RtlAlertDialog.Action> {"متابعة"->React.string} </RtlAlertDialog.Action>
        </RtlAlertDialog.Footer>
      </RtlAlertDialog.Content>
    </RtlAlertDialog>
    <RtlAlertDialog>
      <RtlAlertDialog.Trigger className={rtlOutlineTriggerClass} type_="button">
        {"إظهار الحوار (صغير)"->React.string}
      </RtlAlertDialog.Trigger>
      <RtlAlertDialog.Content dir="rtl" dataLang="ar" size=Sm>
        <RtlAlertDialog.Header>
          <RtlAlertDialog.Media>
            <Icons.Bluetooth />
          </RtlAlertDialog.Media>
          <RtlAlertDialog.Title>
            {"السماح للملحق بالاتصال؟"->React.string}
          </RtlAlertDialog.Title>
          <RtlAlertDialog.Description>
            {"هل تريد السماح لملحق USB بالاتصال بهذا الجهاز؟"->React.string}
          </RtlAlertDialog.Description>
        </RtlAlertDialog.Header>
        <RtlAlertDialog.Footer>
          <RtlAlertDialog.Cancel> {"عدم السماح"->React.string} </RtlAlertDialog.Cancel>
          <RtlAlertDialog.Action> {"السماح"->React.string} </RtlAlertDialog.Action>
        </RtlAlertDialog.Footer>
      </RtlAlertDialog.Content>
    </RtlAlertDialog>
  </div>

@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@react.component
let make = () =>
  <div className="grid w-full max-w-md items-start gap-4" dir="rtl">
    <RtlAlert>
      <Icons.CheckCircle2 />
      <RtlAlert.Title> {"تم الدفع بنجاح"->React.string} </RtlAlert.Title>
      <RtlAlert.Description>
        {"تمت معالجة دفعتك البالغة 29.99 دولارًا. تم إرسال إيصال إلى عنوان بريدك الإلكتروني."->React.string}
      </RtlAlert.Description>
    </RtlAlert>
    <RtlAlert>
      <Icons.Info />
      <RtlAlert.Title> {"ميزة جديدة متاحة"->React.string} </RtlAlert.Title>
      <RtlAlert.Description>
        {"لقد أضفنا دعم الوضع الداكن. يمكنك تفعيله في إعدادات حسابك."->React.string}
      </RtlAlert.Description>
    </RtlAlert>
  </div>

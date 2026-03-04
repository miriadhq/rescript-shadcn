type item = {
  value: string,
  question: string,
  answer: string,
}

let items: array<item> = [
  {
    value: "item-1",
    question: "كيف يمكنني إعادة تعيين كلمة المرور؟",
    answer: "انقر على 'نسيت كلمة المرور' في صفحة تسجيل الدخول، أدخل عنوان بريدك الإلكتروني، وسنرسل لك رابطًا لإعادة تعيين كلمة المرور. سينتهي صلاحية الرابط خلال 24 ساعة.",
  },
  {
    value: "item-2",
    question: "هل يمكنني تغيير خطة الاشتراك الخاصة بي؟",
    answer: "نعم، يمكنك ترقية أو تخفيض خطتك في أي وقت من إعدادات حسابك. ستظهر التغييرات في دورة الفوترة التالية.",
  },
  {
    value: "item-3",
    question: "ما هي طرق الدفع التي تقبلونها؟",
    answer: "نقبل جميع بطاقات الائتمان الرئيسية و PayPal والتحويلات المصرفية. تتم معالجة جميع المدفوعات بأمان من خلال شركاء الدفع لدينا.",
  },
]

@react.component
let make = () =>
  <RtlAccordion defaultValue=["item-1"] className="max-w-md">
    {items
    ->Array.map(item =>
      <RtlAccordion.Item key={item.value} value={item.value}>
        <RtlAccordion.Trigger> {item.question->React.string} </RtlAccordion.Trigger>
        <RtlAccordion.Content> {item.answer->React.string} </RtlAccordion.Content>
      </RtlAccordion.Item>
    )
    ->React.array}
  </RtlAccordion>

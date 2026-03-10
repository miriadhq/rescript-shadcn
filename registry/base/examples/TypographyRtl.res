@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div dir="rtl">
    <h1 className="scroll-m-20 text-4xl font-extrabold tracking-tight text-balance">
      {"فرض الضرائب على الضحك: سجلات ضريبة النكتة"->React.string}
    </h1>
    <p className="text-muted-foreground text-xl leading-7 [&:not(:first-child)]:mt-6">
      {"في قديم الزمان، في أرض بعيدة، كان هناك ملك كسول جداً يقضي يومه كله مستلقياً على عرشه. في أحد الأيام، جاءه مستشاروه بمشكلة: المملكة كانت تنفد من المال."->React.string}
    </p>
    <h2
      className="mt-10 scroll-m-20 border-b pb-2 text-3xl font-semibold tracking-tight transition-colors first:mt-0"
    >
      {"خطة الملك"->React.string}
    </h2>
    <p className="leading-7 [&:not(:first-child)]:mt-6">
      {"فكر الملك طويلاً وبجد، وأخيراً توصل إلى "->React.string}
      <a href="#" className="text-primary font-medium underline underline-offset-4">
        {"خطة عبقرية"->React.string}
      </a>
      {": سيفرض ضريبة على النكات في المملكة."->React.string}
    </p>
    <blockquote className="mt-6 border-s-2 ps-6 italic">
      {"\"في النهاية،\" قال، \"الجميع يستمتع بنكتة جيدة، لذا من العدل أن يدفعوا مقابل هذا الامتياز.\""->React.string}
    </blockquote>
    <h3 className="mt-8 scroll-m-20 text-2xl font-semibold tracking-tight">
      {"ضريبة النكتة"->React.string}
    </h3>
    <p className="leading-7 [&:not(:first-child)]:mt-6">
      {"لم يكن رعايا الملك سعداء. تذمروا واشتكوا، لكن الملك كان حازماً:"->React.string}
    </p>
    <ul className="my-6 ms-6 list-disc [&>li]:mt-2">
      <li>
        {"المستوى الأول من التورية: 5 قطع ذهبية"->React.string}
      </li>
      <li>
        {"المستوى الثاني من النكات: 10 قطع ذهبية"->React.string}
      </li>
      <li>
        {"المستوى الثالث من النكات القصيرة: 20 قطعة ذهبية"->React.string}
      </li>
    </ul>
    <p className="leading-7 [&:not(:first-child)]:mt-6">
      {"نتيجة لذلك، توقف الناس عن رواية النكات، وغرقت المملكة في الكآبة. لكن كان هناك شخص واحد رفض أن تحبطه حماقة الملك: مهرج البلاط المسمى المازح."->React.string}
    </p>
    <h3 className="mt-8 scroll-m-20 text-2xl font-semibold tracking-tight">
      {"ثورة المازح"->React.string}
    </h3>
    <p className="leading-7 [&:not(:first-child)]:mt-6">
      {"بدأ المازح يتسلل إلى القلعة في منتصف الليل ويترك النكات في كل مكان: تحت وسادة الملك، في حسائه، حتى في المرحاض الملكي. كان الملك غاضباً، لكنه لم يستطع إيقاف المازح."->React.string}
    </p>
    <p className="leading-7 [&:not(:first-child)]:mt-6">
      {"وبعد ذلك، في يوم من الأيام، اكتشف سكان المملكة أن النكات التي تركها المازح كانت مضحكة جداً لدرجة أنهم لم يستطيعوا منع أنفسهم من الضحك. وبمجرد أن بدأوا بالضحك، لم يستطيعوا التوقف."->React.string}
    </p>
    <h3 className="mt-8 scroll-m-20 text-2xl font-semibold tracking-tight">
      {"ثورة الشعب"->React.string}
    </h3>
    <p className="leading-7 [&:not(:first-child)]:mt-6">
      {"شعر سكان المملكة بالبهجة من الضحك، وبدأوا في رواية النكات والتورية مرة أخرى، وسرعان ما أصبحت المملكة بأكملها جزءاً من النكتة."->React.string}
    </p>
    <div className="my-6 w-full overflow-y-auto">
      <table className="w-full">
        <thead>
          <tr className="even:bg-muted m-0 border-t p-0">
            <th className="border px-4 py-2 text-start font-bold">
              {"خزينة الملك"->React.string}
            </th>
            <th className="border px-4 py-2 text-start font-bold">
              {"سعادة الشعب"->React.string}
            </th>
          </tr>
        </thead>
        <tbody>
          <tr className="even:bg-muted m-0 border-t p-0">
            <td className="border px-4 py-2 text-start"> {"فارغة"->React.string} </td>
            <td className="border px-4 py-2 text-start"> {"فائضة"->React.string} </td>
          </tr>
          <tr className="even:bg-muted m-0 border-t p-0">
            <td className="border px-4 py-2 text-start"> {"متواضعة"->React.string} </td>
            <td className="border px-4 py-2 text-start"> {"راضٍ"->React.string} </td>
          </tr>
          <tr className="even:bg-muted m-0 border-t p-0">
            <td className="border px-4 py-2 text-start"> {"ممتلئة"->React.string} </td>
            <td className="border px-4 py-2 text-start"> {"منتشٍ"->React.string} </td>
          </tr>
        </tbody>
      </table>
    </div>
    <p className="leading-7 [&:not(:first-child)]:mt-6">
      {"الملك، عندما رأى مدى سعادة رعاياه، أدرك خطأ طرقه وألغى ضريبة النكتة. أُعلن المازح بطلاً، وعاشت المملكة في سعادة دائمة."->React.string}
    </p>
    <p className="leading-7 [&:not(:first-child)]:mt-6">
      {"مغزى القصة هو: لا تستهن أبداً بقوة الضحك الجيد وكن دائماً حذراً من الأفكار السيئة."->React.string}
    </p>
  </div>
